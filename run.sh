#!/usr/bin/env sh

### CREATE BY @Linuztx ###
### UBUNTU 22.04 ###
### 2024 ###
# This script downloads and installs the Ubuntu Server 22.04 base system
# and sets up a proot environment to run it.

# Constants
TIMEOUT=1
MAX_RETRIES=10

# Determine the alternative architecture name based on the current architecture
case "$(uname -m)" in
    x86_64) ARCH_ALT=amd64 ;;
    aarch64) ARCH_ALT=arm64 ;;
    *)
        echo "Unsupported architecture: $(uname -m)"
        exit 1
        ;;
esac

# Check if the Ubuntu base system is already installed
if [ ! -d "$(pwd)/bin" ]; then
    echo "=================================================="
    echo "      @Linuztx Ubuntu Server 22.04 Installer      "
    echo "=================================================="
    echo "                 @Copyright 2024                  "
    echo "=================================================="
    # Prompt the user for installation confirmation
    while true; do
        read -p 'Do you want to install Ubuntu Server 22.04? (Yes/no): ' prompt
        case $prompt in
            [yY][eE][sS])
                echo -e "Starting installation...\n"
                curl -L --retry $MAX_RETRIES --retry-delay $TIMEOUT --output /tmp/rootfs.tar.gz \
                    "https://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04-base-${ARCH_ALT}.tar.gz"
                if [ $? -eq 0 ]; then
                    tar -xf /tmp/rootfs.tar.gz -C "$(pwd)"
                    rm -f /tmp/rootfs.tar.gz
                    echo -e "\nUbuntu Server 22.04 base system installed successfully.\n"
                else
                    echo -e "\nFailed to download the Ubuntu Server 22.04 base system.\n"
                    exit 1
                fi
                break
                ;;
            [nN][oO])
                echo -e "Skipping Installation...\n"
                exit 0
                ;;
            *)
                echo "Please answer Yes or no."
                ;;
        esac
    done
fi

# Download and set up proot if not already installed
if [ ! -x "$(pwd)/usr/local/bin/proot" ]; then
    mkdir -p "$(pwd)/usr/local/bin"
    while [ ! -s "$(pwd)/usr/local/bin/proot" ]; do
        rm -f "$(pwd)/usr/local/bin/proot"
        curl -L --retry $MAX_RETRIES --retry-delay $TIMEOUT --output "$(pwd)/usr/local/bin/proot" "https://proot.gitlab.io/proot/bin/proot"
        if [ -s "$(pwd)/usr/local/bin/proot" ]; then
            chmod 755 "$(pwd)/usr/local/bin/proot"
            echo -e "\nproot has been downloaded and permissions have been set successfully.\n"
        else
            echo -e "\nFailed to download proot, retrying in 5 seconds...\n"
            sleep 5
        fi
    done
fi

# Finalize the installation if not already done
if [ ! -f "$(pwd)/etc/resolv.conf" ]; then
    mkdir -p "$(pwd)/etc"
    printf "nameserver 1.1.1.1\nnameserver 1.0.0.1\n" > "$(pwd)/etc/resolv.conf"
fi

# Display the startup message
echo "=================================================="
echo "      @Linuztx Ubuntu Server 22.04 Installer      "
echo "=================================================="
echo "                 @Copyright 2024                  "
echo "=================================================="
echo "              Starting Ubuntu Server...           "
echo "=================================================="
echo 'To login as root, type "su"'
echo -e "To quit the proot environment, enter \"exit\" twice to fully exit.\n"

# Start the Ubuntu environment using proot
"$(pwd)/usr/local/bin/proot" --rootfs="$(pwd)" \
    -0 -w "/root" -b /dev -b /sys -b /proc -b /etc/resolv.conf --kill-on-exit
