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

# Static IP configuration
ip link set eth0 down
echo "Description='Raspberry PI Static ethernet connection'
Interface=eth0
Connection=ethernet
IP=static
Address=('192.168.1.50/24')
Gateway='192.168.1.1'
DNS=('8.8.8.8' '8.8.4.4')
SkipNoCarrier=yes" << /etc/netctl/home
netctl start home
# port forward your router to let port 80 through to your rpi webserver
# also be sure your ISP doesn't block these permanently
# I had to go to my client panel and enable an option that defined me as an experienced user so I could open up port 80
# After this, test if your port is actually open with this tool => http://www.yougetsignal.com/tools/open-ports/
# This tool will also automatically fetch your public IP
# Also take note if you restart your modem to make your settings take effect, your public ip might already be changed

# DDNS is a built-in feature in my modem and thus I don't need to bother my RPI with this task

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
# sudo pacman -S wget
# This can be achieved with curl + raw git file hosting

# Get the installation zip file
# sudo wget https://github.com/ackoujens/archlinux-raspberry-pi-webserver-install-script/archive/master.zip
# same as the above

# Install UNZIP utility
# sudo pacman -S Unzip
# same as the above

# Unzip the zip file
# sudo unzip master.zip
# same as the above

# EXECUTE SCRIPT
# . archlinux-raspberry-pi-webserver-install-script-master/archlinux-raspberry-pi-webserver-install-script.sh
# same as the above
