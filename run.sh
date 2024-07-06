#!/usr/bin/env sh

### CREATED BY @Linuztx ###
### SERVER INSTALLER PRO ###
### 2024 ###
# This script downloads and installs a Linux base system (Ubuntu, Alpine, or Debian) 
# and sets up a proot environment to run the chosen system

# Constants for the script
TIMEOUT=1
MAX_RETRIES=10
ARCH_DEFAULT=$(uname -m)

# Determine the alternative architecture name based on the current architecture
case "$(uname -m)" in
    x86_64) ARCH_ALT=amd64 ;;
    aarch64) ARCH_ALT=arm64 ;;
    *)
        echo "Unsupported architecture: $(uname -m)"
        exit 1
        ;;
esac

echo "=================================================="
echo "|      @Linuztx Linux Server Installer Pro       |"
echo "=================================================="
echo "|                @Copyright 2024                 |"
echo "=================================================="
echo "|        1.) Ubuntu (24.04, Noble Numbat)        |"
echo "|        2.) Alpine (3.19, Linux)                |"
echo "|        3.) Debian (12, Bookworm)               |"
echo "|        4.) Use the already installed distro    |"
echo "=================================================="
read -p "Choose a distro (1/2/3/4): " distro
while true; do
    case $distro in
    1) 
        distro_dir="ubuntu"
        while true; do
            read -p 'Do you want to install Ubuntu Server 24.04, Noble Numbat, Linux? (Yes/no): ' prompt
            case $prompt in
                [yY][eE][sS])
                    echo -e "Starting installation...\n"
                    curl -L --retry $MAX_RETRIES --retry-delay $TIMEOUT --output /tmp/rootfs.tar.xz \
                        "https://github.com/termux/proot-distro/releases/download/v4.11.0/ubuntu-noble-${ARCH_DEFAULT}-pd-v4.11.0.tar.xz"
                    if [ $? -eq 0 ]; then
                        mkdir $(pwd)/$distro_dir
                        tar -xf /tmp/rootfs.tar.xz -C "$(pwd)/$distro_dir" --strip-components=1
                        rm -f /tmp/rootfs.tar.xz
                        echo -e "\nUbuntu Server 24.04, Noble Numbat Linux base system installed successfully.\n"
                    else
                        echo -e "\nFailed to download the Ubuntu Server 24.04, Noble Numbat, Linux base system.\n"
                        exit 1
                    fi
                    break 2
                    ;;
                [nN][oO])
                    echo -e "Skipping Installation...\n"
                    break 2
                    ;;
                *)
                    echo "Please answer Yes or no."
                    ;;
            esac
        done
    ;;
    2)
        distro_dir="alpine"
        while true; do
            read -p 'Do you want to install Alpine Server 3.19, Linux? (Yes/no): ' prompt
            case $prompt in
                [yY][eE][sS])
                    echo -e "Starting installation...\n"
                    curl -L --retry $MAX_RETRIES --retry-delay $TIMEOUT --output /tmp/rootfs.tar.gz \
                        "https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/x86_64/alpine-minirootfs-3.19.1-${ARCH_DEFAULT}.tar.gz"
                    if [ $? -eq 0 ]; then
                        mkdir $(pwd)/$distro_dir
                        tar -xf /tmp/rootfs.tar.gz -C "$(pwd)/$distro_dir"
                        rm -f /tmp/rootfs.tar.gz
                        echo -e "\nAlpine Server 3.19 Linux base system installed successfully.\n"
                    else
                        echo -e "\nFailed to download the Alpine Server 3.19, Linux base system.\n"
                        exit 1
                    fi
                    break 2
                    ;;
                [nN][oO])
                    echo -e "Skipping Installation...\n"
                    break 2
                    ;;
                *)
                    echo "Please answer Yes or no."
                    ;;
            esac
        done
    ;;
    3)        
        distro_dir="debian"
        while true; do
            read -p 'Do you want to install Debian Server 12, bookworm? (Yes/no): ' prompt
            case $prompt in
                [yY][eE][sS])
                    echo -e "Starting installation...\n"
                    curl -L --retry $MAX_RETRIES --retry-delay $TIMEOUT --output /tmp/rootfs.tar.xz \
                        "https://github.com/termux/proot-distro/releases/download/v4.7.0/debian-bullseye-${ARCH_DEFAULT}-pd-v4.7.0.tar.xz"
                    if [ $? -eq 0 ]; then
                        mkdir $(pwd)/$distro_dir
                        tar -xf /tmp/rootfs.tar.xz -C "$(pwd)/$distro_dir" --strip-components=1
                        rm -f /tmp/rootfs.tar.xz 
                        echo -e "\nDebian Server 12, bookworm base system installed successfully.\n"
                    else
                        echo -e "\nFailed to download the Debian Server 12, bookworm base system.\n"
                        exit 1
                    fi
                    break 2
                    ;;
                [nN][oO])
                    echo -e "Skipping Installation...\n"
                    break 2
                    ;;
                *)
                    echo "Please answer Yes or no."
                    ;;
            esac
        done
    ;;
    4)
        if [ -d "$(pwd)/ubuntu" ] || [ -d "$(pwd)/alpine" ] || [ -d "$(pwd)/debian" ]; then
            echo -e "\n=================================================="
            echo "|       Available Installed Linux Distros        |"
            echo "=================================================="
            [ -d "$(pwd)/ubuntu" ] && echo "|        1.) Ubuntu (24.04, Noble Numbat)        |"
            [ -d "$(pwd)/alpine" ] && echo "|        2.) Alpine (3.19, Linux)                |"
            [ -d "$(pwd)/debian" ] && echo "|        3.) Debian (12, Bookworm)               |"
            echo "=================================================="
            read -p "Choose a distro to use (1/2/3): " installed_distro
            case $installed_distro in
                1)
                    distro_dir="ubuntu"
                    ;;
                2)
                    distro_dir="alpine"
                    ;;
                3)
                    distro_dir="debian"
                    ;;
                *)
                    echo -e "\nInvalid choice. Please choose 1, 2, or 3.\n"
                    exit 1
                    ;;
            esac
            
            # Check if the chosen directory exists
            if [ ! -d "$(pwd)/$distro_dir" ]; then
                echo -e "\nThe directory for the chosen distro does not exist. Please install the distro first.\n"
                exit 1
            fi
            echo -e "Using the already installed $distro_dir base system.\n"
        else
            echo -e "No distro installed. Please install a distro first."
            exit 1
        fi
        break  # Exit the loop
    ;;            
    *)
        echo -e "\nInvalid choice. Please choose 1, 2, or 3.\n"
    ;;
    esac
done
        

# Download and set up proot if not already installed
if [ ! -x "$(pwd)/$distro_dir/usr/local/bin/proot" ]; then
    mkdir -p "$(pwd)/$distro_dir/usr/local/bin"
    while [ ! -s "$(pwd)/$distro_dir/usr/local/bin/proot" ]; do
        rm -f "$(pwd)/$distro_dir/usr/local/bin/proot"
        curl -L --retry $MAX_RETRIES --retry-delay $TIMEOUT --output "$(pwd)/$distro_dir/usr/local/bin/proot" "https://proot.gitlab.io/proot/bin/proot"
        if [ -s "$(pwd)/$distro_dir/usr/local/bin/proot" ]; then
            chmod 755 "$(pwd)/$distro_dir/usr/local/bin/proot"
            echo -e "\nproot has been downloaded and permissions have been set successfully.\n"
        else
            echo -e "\nFailed to download proot, retrying in 5 seconds...\n"
            sleep 5
        fi
    done
fi

# Finalize the installation if not already done
if [ ! -f "$(pwd)/$distro_dir/etc/resolv.conf" ]; then
    mkdir -p "$(pwd)/$distro_dir/etc"
    printf "nameserver 1.1.1.1\nnameserver 1.0.0.1\n" > "$(pwd)/$distro_dir/etc/resolv.conf"
fi

# Display the startup message
echo "=================================================="
echo "|       @Linuztx Linux Server Installer Pro      |"
echo "=================================================="
echo "|                @Copyright 2024                 |"
echo "=================================================="
echo "|            Starting Linux Server...            |"
echo "=================================================="
echo 'To login as root, type "su"'
echo -e "To quit the proot environment, enter \"exit\" twice to fully exit.\n"

# Start the Ubuntu environment using proot
"$(pwd)/$distro_dir/usr/local/bin/proot" --rootfs="$(pwd)/$distro_dir" \
    -0 -w "/root" -b /dev -b /sys -b /proc -b /etc/resolv.conf --kill-on-exit
