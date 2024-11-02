#!/bin/bash

made_by() {
    echo "
Made by:
 ____  _______     ______    _    ____  
|  _ \| ____\ \   / /  _ \  / \  / ___| 
| | | |  _|  \ \ / /| | | |/ _ \ \___ \ 
| |_| | |___  \ V / | |_| / ___ \ ___) |
|____/|_____|  \_/  |____/_/   \_\____/ 

GitHub: https://github.com/devdas-gupta/
"
}

made_by

DEFAULT_FILE_WORDLIST="/usr/share/wordlists/dirb/big.txt"

get_domain_info() {
    domain=$1

    echo "Fetching information for $domain..."
    amass intel -d $domain
}

get_ip_address() {
    domain="$1"

    echo "Getting IP address for $domain..."
    ip_address=$(dig +short "$domain")
    if [[ $? -ne 0 ]]; then
        echo "Failed to get IP address for $domain."
        return 1
    fi
    echo "IP Address: $ip_address"
}

display_domain_info() {
    domain=$1

    echo "Displaying information for $domain..."
    echo "=== Domain Information ==="
    whois $domain
    echo "=========================="
}

nmap_scan() {
    target=$1
    scan_type=$2

    if [ "$scan_type" = "skip" ]; then
        echo "Skipping nmap scan..."
    else
        echo "Running $scan_type nmap scan for $target..."
        
        case $scan_type in
            "normal")
                nmap_output=$(nmap -p- -T4 $target)
                ;;
            "aggressive")
                nmap_output=$(nmap -p- -T4 -A --script=default,http-enum,ssl-enum-ciphers,vulners $target)
                ;;
            "custom")
                echo "Enter custom nmap options (e.g., -p80,443 -sV):"
                read -r custom_options
                echo "Running custom nmap scan with options: $custom_options"
                nmap_output=$(nmap $custom_options $target)
                ;;
            *)
                echo "Invalid option. Using normal nmap scan."
                nmap_output=$(nmap -p- -T4 $target)
                ;;
        esac

        echo "=== Nmap Information ==="
        echo "$nmap_output"
        echo "========================"
    fi
}

scan_directories() {
    domain=$1

    echo "Running Full Scan for $domain with ffuf..."
    ffuf -u "https://$domain/FUZZ" -w $DEFAULT_FILE_WORDLIST -e .html,.php,.asp,.aspx,.txt -of html -o ffuf-report.html
}

main() {
    echo "Enter the domain (e.g., example.com):"
    read domain

    # Run get_domain_info sequentially
    get_domain_info $domain

    # Display ASCII art and "Made by" message
    made_by

    # Display domain information
    display_domain_info $domain

    # Get IP address
    get_ip_address $domain

    # Choose nmap scan type
    echo "Choose nmap scan type (or type 'skip' to skip nmap scan):"
    echo "1. Normal Scan"
    echo "2. Aggressive Scan"
    echo "3. Custom Scan"
    read scan_choice

    case $scan_choice in
        "skip")
            scan_type="skip"
            ;;
        1)
            scan_type="normal"
            ;;
        2)
            scan_type="aggressive"
            ;;
        3)
            scan_type="custom"
            ;;
        *)
            scan_type="normal"
            ;;
    esac

    # Run nmap_scan sequentially
    nmap_scan $domain $scan_type

    # Run ffuf scan sequentially
    scan_directories $domain

    echo "Script completed."
}

main
