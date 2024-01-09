# WebProbe

WebProbe is a bash script that combines various web reconnaissance and scanning tools to gather information about a target domain. It provides domain information, IP address lookup, and performs enhanced nmap scans and directory enumeration using ffuf.

## Features

- Fetches domain information using amass.
- Retrieves the IP address of the target domain.
- Displays whois information for the domain.
- Runs an enhanced nmap scan with detailed information, allowing users to choose from Normal, Aggressive, or Custom scans.
- Scans directories using ffuf with a default wordlist.
- Supports skipping nmap scan if desired.
- Customizable directory scanning options for full scans or specific wordlists.

## Preview

![WebProbe Preview](https://github.com/Devdas-gupta/WebProbe/blob/main/demo.png)

## Prerequisites

- [amass](https://github.com/OWASP/Amass)
- [nmap](https://nmap.org/)
- [ffuf](https://github.com/ffuf/ffuf)

## Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/Devdas-gupta/WebProbe.git
    cd WebProbe
    ```

2. Run the script:

    ```bash
    ./WebProbe.sh
    ```

3. Follow the on-screen prompts to enter the target domain.

## Contributing

If you'd like to contribute, please fork the repository and create a pull request.

## About Me

Hi, I'm Devdas Kumar, the creator of WebProbe. I'm passionate about cybersecurity and exploring the depths of web technologies. This tool is a result of my journey in the field, and I hope it proves useful to others in their cybersecurity endeavors.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
