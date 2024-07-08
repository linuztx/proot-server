# Proot Server: Linux Environment on Non-Root Servers

[![GitHub](https://img.shields.io/github/license/linuztx/proot-server)](https://github.com/linuztx/proot-server/blob/main/LICENSE)

## Overview

Proot Server is a script designed to install and run a Linux base system (Ubuntu, Alpine, Debian or Fedora) on servers or environments where root access is not available. Utilizing proot, a user-space implementation of chroot, this script enables you to set up a full Linux environment without root privileges.

## Features

- **Rootless Linux Environment**: Run a Linux environment without needing root access.
- **Distro Choice**: Choose from Ubuntu, Alpine, Debian or Fedora distributions.
- **proot Integration**: Leverages proot for creating a chroot-like environment.
- **Easy Installation**: A single script handles the installation and setup process.
- **Re-Entrant Environment**: Re-enter the environment by simply running the script again.

## Prerequisites

Before running the script, ensure you have the following tools installed:

- `curl`: For fetching necessary files from the internet.
- `tar`: For extracting the downloaded files.
- `proot`: For creating a chroot-like environment.

## Supported Architectures

The script is tested and works on `x86_64` and `aarch64` architectures. Compatibility with other architectures is not guaranteed.

## Usage

To use the script, follow these steps:

1. **Clone the Repository**:

   ```shell
   git clone https://github.com/linuztx/proot-server.git
   cd proot-server
   ```

2. **Make the Script Executable**:

   ```shell
   chmod +x run.sh
   ```

3. **Run the Script**:

   ```shell
   ./run.sh
   ```

   The script will guide you through the installation process, allowing you to choose your preferred Linux distribution.

4. **Access the Environment**:
   After installation, the script will start a shell session inside the chosen Linux environment.

5. **Exit the Environment**:
   To exit the environment, type `exit` twice in the shell session.

## Limitations

While proot provides a chroot-like environment, it does not offer full isolation or root-level capabilities. Some actions that require root access may not function as expected.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
