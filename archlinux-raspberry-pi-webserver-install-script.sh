#!/bin/bash
# Login as root
# username: root
# password: root

# Change the root password
# passwd root
# <enter a new password>

# Enable DHCP for an easy wired internet connection
# dhcpcd eth0

# Install GIT to start using GitHub shell scripts
# pacman -S git-core

# Install sudo for more permissive actions
# pacman -S sudo

# Create a new user
# adduser
# passwd <username>

# Put new user in sudoers file
# nano /etc/sudoers
# scroll down to "User privilege specification" and add the line
# <username> ALL=(ALL) ALL
# ctrl+x to exit nano
# Enter 'Y' to overwrite the sudoers file

# Login into new user
# logout
# username: <newuser>
# password: <newuserpassword>

# Install wget to retreive any files
# sudo pacman -S wget

# Get the installation zip file
# sudo wget https://github.com/ackoujens/archlinux-raspberry-pi-webserver-install-script/archive/master.zip

# Install Unzip utility
# sudo pacman -S Unzip

# Unzip the zip file
# sudo unzip master.zip

# Move script file to main directory
# sudo mv archlinux-raspberry-pi-webserver-install-script-master/archlinux-raspberry-pi-webserver-install-script.sh .

# EXECUTE SCRIPT
# . archlinux-raspberry-pi-webserver-install-script.sh

# See all commands
set -x

# Remove any garbage files
sudo rm ArchLinuxARM-rpi-2-latest.tar.gz
sudo rmdir archlinux-raspberry-pi-webserver-install-script-master

# Create a home directory for your user

# Install OpenSSH
read -r -p "Do you wish to install OpenSSH?(y/N): " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]] then
	sudo pacman -S openssh

  # Set custom SSH port?
  read -r -p "Do you wish to set a custom SSH port?(y/N): " response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]] then
  	sudo nano /etc/ssh/sshd_config
  fi

  # Take note of MAC addr (after "link/ether")
  read -r -p "Do you want to take a note of the MAC address?(y/n): " response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]] then
  	ip addr
  fi
  read -p "Hit ENTER if you're ready to continue ..."

  echo "Running SSH service"
  sudo systemctl start sshd

  echo "Enabling SSH on startup"
  sudo systemctl enable sshd
fi

# Remove script after execution as it is not safe to run this script again on a clean install
# sudo rmd archlinux-raspberry-pi-webserver-install-script-master.sh

# Disable seeing all commands
set +x
