#!/bin/bash
# Login as root
# username: root
# password: root

# Change the root password
# passwd root
# <enter a new password>

# Create a new user
# adduser
# passwd <username>

# Login into new user
# logout
# username: <newuser>
# password: <newuserpassword>

# Enable DHCP for an easy wired internet connection
# dhcpcd eth0

# Install GIT to start using GitHub shell scripts
# pacman -S git-core

# Install OpenSSH
read CHOICE "Do you want to install OpenSSH?(y/n): "
if [ "$CHOICE" == "y" ]; then
	sudo pacman -S openssh
fi

# Set custom port?
read CHOICE "Do you want to set a custom port?(y/n): "
if [ "$CHOICE" == "y" ]; then
	sudo nano /etc/ssh/sshd_config
fi

# Take note of MAC addr (after "link/ether")
read CHOICE "Do you want to take a note of the MAC address?(y/n): "
if [ "$CHOICE" == "y" ]; then
	ipaddr
fi

read -p "Hit ENTER to continue..."
