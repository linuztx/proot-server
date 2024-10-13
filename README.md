# Proot Server: Linux Server Installer Pro

[![GitHub](https://img.shields.io/github/license/linuztx/proot-server)](https://github.com/linuztx/proot-server/blob/main/LICENSE)

![proot-server](https://github.com/user-attachments/assets/976c7478-8d4b-4d4b-b35e-ad49c77ae5fe)

## Overview

Proot Server is a powerful shell script that enables you to install and run various Linux distributions (Ubuntu, Alpine, Debian, or Fedora) in a proot environment. This tool is particularly useful for setting up Linux environments on systems where you don't have root access or in situations where you need isolated Linux instances.

## Features

- **Multiple Distribution Support**: Choose from Ubuntu 20.04 Focal Fossa, Alpine 3.19, Debian 12 Bookworm, or Fedora 40.
- **Architecture Compatibility**: Supports x86_64 (amd64) and aarch64 (arm64) architectures.
- **Proot Integration**: Utilizes proot for creating a chroot-like environment without requiring root privileges.
- **Persistent Installation**: Installed distributions can be reused in subsequent runs.
- **Automatic Dependency Handling**: Downloads and sets up proot if not already installed.
- **DNS Configuration**: Automatically sets up DNS resolution using Cloudflare's DNS servers.

## Prerequisites

- `curl`: For downloading distribution files and proot.
- `tar`: For extracting downloaded files.
- Internet connection for downloading necessary files.

## Usage

1. **Clone the Repository**:
   ```
   git clone https://github.com/linuztx/proot-server.git
   cd proot-server
   ```

2. **Run the Script**:
   ```
   ./run.sh
   ```

3. **Choose a Distribution**:
   - Select from options 1-4 to install a new distribution.
   - Choose option 5 to use an already installed distribution.

4. **Installation Process**:
   - The script will download the selected distribution's rootfs.
   - It will extract the files and set up the environment.

5. **Proot Setup**:
   - If not present, the script will download and configure proot.

6. **Entering the Environment**:
   - After setup, you'll be automatically entered into the proot environment.
   - Use `su` to switch to root user within the environment.

7. **Exiting the Environment**:
   - Type `exit` twice to fully exit the proot environment.

## Supported Distributions and Versions

- Ubuntu 20.04 Focal Fossa
- Alpine 3.19
- Debian 12 Bookworm
- Fedora 40

## Directory Structure

The script creates directories for each installed distribution:
- `./ubuntu` for Ubuntu
- `./alpine` for Alpine
- `./debian` for Debian
- `./fedora` for Fedora

## Network Configuration

The script automatically sets up `/etc/resolv.conf` with Cloudflare's DNS servers (1.1.1.1 and 1.0.0.1).

## Limitations

- While proot provides a chroot-like environment, it does not offer full system isolation.
- Some operations requiring true root access may not function as expected.

## Troubleshooting

- If downloads fail, the script will retry up to 10 times with a 1-second delay between attempts.
- Ensure you have a stable internet connection for successful downloads.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
