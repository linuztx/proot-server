# Proot Server

This repository contains a script for installing and running a Linux base system (Ubuntu, Alpine, or Debian) on servers or environments that do not have root access. The script utilizes proot, a user-space implementation of chroot, allowing you to perform actions that typically require root access. This makes it possible to set up a full-fledged Linux environment on servers or within containers where you don't have root privileges.

## Prerequisites

Before running the script, ensure the following tools are installed:

- curl: Used for fetching necessary files from the internet.
- tar: Used for extracting the downloaded files.
- proot: Used for creating a chroot-like environment without root privileges.

## Supported Architectures

The script is tested on x86_64 and aarch64 architectures. Other architectures may not work as expected.

## Usage

To use the script, simply run the `run.sh` file. The script will download the necessary files, create a new directory for the chosen Linux environment, and start a shell session inside the environment. You can then install additional packages, configure the environment, and run services as needed.

To exit the environment, simply type `exit` twice in the shell session. You can re-enter the environment by running the `run.sh` script again.

## Limitations

While proot provides a user-space implementation of chroot, it does not provide full isolation like a true chroot environment. This means that some actions that require root access may not work as expected. For example, you may not be able to create network interfaces, modify system files, or perform other administrative tasks that require root privileges.

## Installation

To use this script, you need to clone the repository, navigate to the directory, make the script executable, and then run it. Here are the commands you need to run:

```shellscript
git clone https://github.com/linuztx/proot-server.git
cd proot-server
./run.sh
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
