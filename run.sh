#!/usr/bin/env sh

# Linux Server Installer Pro
# Created by @Linuztx
# Copyright (C) 2024 Linuztx

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Constants
TIMEOUT=1
MAX_RETRIES=10
ARCH_DEFAULT=$(uname -m)
ARCH_ALT=$([ "$ARCH_DEFAULT" = "x86_64" ] && echo "amd64" || echo "arm64")

# Function to print colored messages
print_message() {
    color=$1
    message=$2
    printf "${color}%s${NC}\n" "$message"
}

# Function to display the menu
display_menu() {
    print_message $BLUE "=================================================="
    print_message $BLUE "|      Linux Server Installer Pro by @Linuztx    |"
    print_message $BLUE "=================================================="
    print_message $BLUE "|                Copyright (C) 2024              |"
    print_message $BLUE "=================================================="
    print_message $YELLOW "|        1.) Ubuntu (20.04 Focal Fossa)          |"
    print_message $YELLOW "|        2.) Alpine (3.19, Linux)                |"
    print_message $YELLOW "|        3.) Debian (12, Bookworm)               |"
    print_message $YELLOW "|        4.) Fedora (40, Linux)                  |"
    print_message $YELLOW "|        5.) Use the already installed distro    |"
    print_message $BLUE "=================================================="
}

# Function to install a distribution
install_distro() {
    distro_name=$1
    distro_dir=$2
    rootfs_url=$3

    print_message $GREEN "Starting installation of $distro_name..."
    curl -L --retry $MAX_RETRIES --retry-delay $TIMEOUT --output /tmp/rootfs.tar.gz "$rootfs_url"
    if [ $? -eq 0 ]; then
        mkdir -p "$(pwd)/$distro_dir"
        tar -xf /tmp/rootfs.tar.gz -C "$(pwd)/$distro_dir" ${4:+--strip-components=1}
        rm -f /tmp/rootfs.tar.gz
        print_message $GREEN "$distro_name base system installed successfully."
    else
        print_message $RED "Failed to download the $distro_name base system."
        exit 1
    fi
}

# Main script
display_menu
read -p "Choose a distro (1/2/3/4/5): " distro

case $distro in
    1) install_distro "Ubuntu Server 20.04 Focal Fossa" "ubuntu" "http://cdimage.ubuntu.com/ubuntu-base/releases/20.04/release/ubuntu-base-20.04.4-base-${ARCH_ALT}.tar.gz" ;;
    2) install_distro "Alpine Server 3.19" "alpine" "https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/${ARCH_DEFAULT}/alpine-minirootfs-3.19.1-${ARCH_DEFAULT}.tar.gz" ;;
    3) install_distro "Debian Server 12 Bookworm" "debian" "https://github.com/termux/proot-distro/releases/download/v4.7.0/debian-bullseye-${ARCH_DEFAULT}-pd-v4.7.0.tar.xz" 1 ;;
    4) install_distro "Fedora 40" "fedora" "https://github.com/termux/proot-distro/releases/download/v4.15.0/fedora-${ARCH_DEFAULT}-pd-v4.15.0.tar.xz" 1 ;;
    5)
        if [ -d "$(pwd)/ubuntu" ] || [ -d "$(pwd)/alpine" ] || [ -d "$(pwd)/debian" ] || [ -d "$(pwd)/fedora" ]; then
            print_message $BLUE "Available Installed Linux Distros:"
            [ -d "$(pwd)/ubuntu" ] && print_message $YELLOW "1.) Ubuntu (20.04 Focal Fossa)"
            [ -d "$(pwd)/alpine" ] && print_message $YELLOW "2.) Alpine (3.19, Linux)"
            [ -d "$(pwd)/debian" ] && print_message $YELLOW "3.) Debian (12, Bookworm)"
            [ -d "$(pwd)/fedora" ] && print_message $YELLOW "4.) Fedora (40, Linux)"
            read -p "Choose a distro to use (1/2/3/4): " installed_distro
            case $installed_distro in
                1) distro_dir="ubuntu" ;;
                2) distro_dir="alpine" ;;
                3) distro_dir="debian" ;;
                4) distro_dir="fedora" ;;
                *) print_message $RED "Invalid choice. Exiting."; exit 1 ;;
            esac
            [ ! -d "$(pwd)/$distro_dir" ] && print_message $RED "The directory for the chosen distro does not exist. Please install the distro first." && exit 1
            print_message $GREEN "Using the already installed $distro_dir base system."
        else
            print_message $RED "No distro installed. Please install a distro first."
            exit 1
        fi
        ;;
    *) print_message $RED "Invalid choice. Exiting."; exit 1 ;;
esac

# Download and set up proot
if [ ! -x "$(pwd)/$distro_dir/usr/local/bin/proot" ]; then
    mkdir -p "$(pwd)/$distro_dir/usr/local/bin"
    curl -L --retry $MAX_RETRIES --retry-delay $TIMEOUT --output "$(pwd)/$distro_dir/usr/local/bin/proot" "https://proot.gitlab.io/proot/bin/proot"
    chmod 755 "$(pwd)/$distro_dir/usr/local/bin/proot"
    print_message $GREEN "proot has been downloaded and permissions have been set."
fi

# Set up DNS
[ ! -f "$(pwd)/$distro_dir/etc/resolv.conf" ] && printf "nameserver 1.1.1.1\nnameserver 1.0.0.1\n" > "$(pwd)/$distro_dir/etc/resolv.conf"

# Display startup message
print_message $BLUE "=================================================="
print_message $BLUE "|      Linux Server Installer Pro by @Linuztx    |"
print_message $BLUE "=================================================="
print_message $BLUE "|               Copyright (C) 2024               |"
print_message $BLUE "=================================================="
print_message $GREEN "|           Starting The Linux Server...         |"
print_message $BLUE "=================================================="
print_message $YELLOW "To login as root, type 'su'"
print_message $YELLOW "To quit the proot environment, enter 'exit' twice."

# Start the linux server environment using proot
"$(pwd)/$distro_dir/usr/local/bin/proot" --rootfs="$(pwd)/$distro_dir" \
    -0 -w "/root" -b /dev -b /sys -b /proc -b /etc/resolv.conf --kill-on-exit