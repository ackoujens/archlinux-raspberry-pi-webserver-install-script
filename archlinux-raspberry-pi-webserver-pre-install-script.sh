#!/bin/bash

# *********************************************************** #
#   archlinux-raspberry-pi-webserver-pre-install-script.sh    #
#                   written by Jens Ackou                     #
#                                                             #
#      steps needed before proceeding with main install       #
#               tested on a 8Gb micro sd card                 #
# *********************************************************** #

## MANUAL STEPS - UNABLE TO PUT THESE SETUP STEPS INTO A BASH SCRIPT
## These steps take care of downloading and unpacking the script.
## Before a connection is made to the package it is impossible IMO
## to include these steps into a script that can be downloaded.

# See all commands
set -x

# Login as root
# username: root
# password: root

# Enable DHCP for an easy wired internet connection
dhcpcd eth0

# TODO Is this step movable to an automated section?
# Change the root password for safety
passwd root

# TODO Is this step needed in here? If not it can be movable to an autmated section.
# Install SUDO for more permissive actions
pacman -S sudo

# Create a new user
echo "Creating a new user account."
read -p 'Username: ' uservar
useradd $uservar && passwd $uservar

# Put new user in sudoers file
sudo adduser <username> sudo
# OR
# nano /etc/sudoers
# scroll down to "User privilege specification" and add the line
# <username> ALL=(ALL) ALL
# ctrl+x to exit nano
# Enter 'Y' to overwrite the sudoers file

# Login into new user OR execute proceeding script AS another user
# logout
# username: <newuser>
# password: <newuserpassword>

# Install WGET to retreive any files
sudo pacman -S wget

# Get the installation zip file
sudo wget https://github.com/ackoujens/archlinux-raspberry-pi-webserver-install-script/archive/master.zip

# Install UNZIP utility
sudo pacman -S Unzip

# Unzip the zip file
sudo unzip master.zip

# EXECUTE SCRIPT
. archlinux-raspberry-pi-webserver-install-script-master/archlinux-raspberry-pi-webserver-install-script.sh
