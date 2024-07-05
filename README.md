# Proot Server

This repository contains a script for installing and running Ubuntu Server 22.04 on servers that do not have root access. The script uses PRoot, a user-space implementation of chroot, mount --bind, and binfmt_misc, allowing you to perform actions that normally require root access. This makes it possible to install a full-fledged Ubuntu Server 22.04 environment on servers where you don't have root privileges.

## Prerequisites

Before running the script, make sure the following tools are installed:

- curl: Used for fetching necessary files from the internet.
- tar: Used for extracting the downloaded files.
- supported architecture: The script is tested on x86_64 and aarch64 architectures. Other architectures may not work.

## Usage

To use the script, simply run the `run.sh` file. The script will download the necessary files, create a new directory for the Ubuntu Server environment, and start a shell session inside the environment. You can then install additional packages, configure the environment, and run services as needed.

To exit the environment, simply type `exit` twice in the shell session. You can re-enter the environment by running the `run.sh` script again.

## Limitations

While PRoot provides a user-space implementation of chroot, it does not provide full isolation like a true chroot environment. This means that some actions that require root access may not work as expected. For example, you may not be able to create network interfaces, modify system files, or perform other administrative tasks that require root privileges.

## Installation

To use this script, you need to clone the repository, navigate to the directory, make the script executable, and then run it. Here are the commands you need to run:

```shellscript
git clone https://github.com/linuztuxx/proot-server.git
cd proot-server
chmod +x run.sh
./run.sh
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
