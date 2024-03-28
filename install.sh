#!/bin/bash

# Define the install_ffmpeg function
install_ffmpeg() {
    if [ "$(uname)" == "Darwin" ]; then
        # MacOS
        if ! brew install ffmpeg; then
            echo "Failed to install ffmpeg on macOS." >&2
            exit 1
        fi
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        # Attempt to identify Linux distribution and install ffmpeg
        if [ -f /etc/debian_version ]; then
            # Debian-based distributions
            sudo apt-get update && sudo apt-get install -y ffmpeg
        elif [ -f /etc/fedora-release ]; then
            # Fedora
            sudo dnf install -y ffmpeg
        elif [ -f /etc/arch-release ]; then
            # Arch Linux
            sudo pacman -Sy ffmpeg
        elif [ -f /etc/centos-release ] || [ -f /etc/redhat-release ]; then
            # CentOS or RHEL
            sudo yum install epel-release -y
            sudo yum update -y
            sudo yum install ffmpeg ffmpeg-devel -y
        else
            echo "Unsupported Linux distribution." >&2
            exit 1
        fi
    elif [[ "$(uname -s)" =~ MINGW(32|64)_NT ]]; then
        # Windows (MINGW environment, typically Git Bash)
        echo "Please install ffmpeg manually on Windows." >&2
        exit 1
    else
        echo "Unsupported operating system." >&2
        exit 1
    fi
}

# Main script execution starts here

# Ensure the script is run with root privileges if necessary
if [ "$(id -u)" != "0" ] && [ "$(uname)" != "Darwin" ]; then
    echo "This script might need to be run as root (or use sudo) to install packages" >&2
    exit 1
fi

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg could not be found. Installing ffmpeg to use the make_my_video script."
    install_ffmpeg
else
    echo "ffmpeg is already installed."
fi

# Proceed with the installation of the make_my_video script
echo "Installing make_my_video script..."

# Copy the script to a location in PATH
cp video_maker.sh /usr/local/bin/make_my_video

# Make the script executable
chmod +x /usr/local/bin/make_my_video

echo "make_my_video script installed successfully. You can now use it by calling 'make_my_video'."
