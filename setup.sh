#!/bin/bash
# Setup script for vboost on linux

echo "------------------------------------------------------------"
echo "Automated Vboost Setup"
echo "------------------------------------------------------------"
echo " "

# Variables
password="default"
group="boost"
main_user="user"

# Check if steam is installed and launched once
while ! [[ -d /home/$main_user/.local/share/Steam/ ]]
do
    if ! pacman -Qi steam &> /dev/null
    then
        echo "[!] Steam is not installed on your main user!"
        echo "[>] Installing steam now..."
        sudo su -c "yes | pacman -S steam &> /dev/null"
        echo "[+] Steam successfully installed!"
        echo "[>] Starting steam once on main user..."
        echo "[!] Please exit steam after it fully launched!"
        sudo su $main_user -c "steam -login anonymous &> /dev/null"
    fi
done

echo " "
echo "[+] Steam is installed and was launched once!"
echo " "

# Create usergroup
sudo su -c "sudo groupadd $group"
echo "------------------------------------------------------------"
echo "Creating all users."
echo "------------------------------------------------------------"

# Creating users and profile dir's
counter=1
while [ $counter -le 10 ]
do
    sudo su -c "useradd -p $(openssl passwd -crypt $password) account$counter &> /dev/null"
    sudo su -c "mkhomedir_helper account$counter &> /dev/null"
    sudo su -c "sudo usermod -a -G $group account$counter &> /dev/null"
    echo "[+] Created account$counter!"
    ((counter++))
done
echo "------------------------------------------------------------"
echo " "

# Copy steam from main user to bot accounts
echo "------------------------------------------------------------"
echo "Copy all steam files from main user to the created users."
echo "------------------------------------------------------------"
counter=1
while [ $counter -le 10 ]
do
    echo "[>] Copy files to user: account$counter"
    sudo su -c "mkdir /home/account$counter/.local/ &> /dev/null"
    sudo su -c "mkdir /home/account$counter/.local/share/ &> /dev/null"
    sudo su -c "cp -avr /home/$main_user/.local/share/Steam /home/account$counter/.local/share/ &> /dev/null"
    sudo su -c "chown -R account$counter /home/account$counter/.local/share/Steam &> /dev/null"
    sudo su -c "chgrp -R $group /home/account$counter/.local/share/Steam &> /dev/null"
    sudo su -c "chmod -R g+rwx /home/account$counter/.local/share/Steam &> /dev/null"
    echo "[+] Copied steam from main user to account$counter!"
    ((counter++))
done
echo "------------------------------------------------------------"
echo " "

# Install xhost and enable
echo "[>] Configure xhost..."
echo "[+] Xhost installed!"
sudo su -c "xhost + &> /dev/null"
echo " "

# Start steam once from every user
echo "------------------------------------------------------------"
echo "Starting steam once from every user..."
echo "------------------------------------------------------------"
counter=1
while [ $counter -le 10 ]
do
    echo "Starting steam from account$counter!"
    echo "[!] Exit steam after it fully started!"
    sudo su account$counter -c "sh /home/account$counter/.local/share/Steam/steam.sh -login anonymous &> /dev/null"
    echo "[!] Steam got killed!"
    echo " "
    ((counter++))
done
echo "------------------------------------------------------------"
echo " "

# Delete steamapps folder from every new user
echo "------------------------------------------------------------"
echo "Delete steamapps folder from every new user..."
echo "------------------------------------------------------------"
counter=1
while [ $counter -le 10 ]
do
    echo "[>] Deleting steamapps folder from user account$counter..."
    sudo su account$counter -c "rm -R /home/account$counter/.local/share/Steam/steamapps"
    echo "[!] Deleted folder from account$counter!"
    ((counter++))
done
echo "------------------------------------------------------------"
echo " "

# Delete steamapps folder from every new user
echo "------------------------------------------------------------"
echo "Creating syslink for steamapps folder from main user to every new user"
echo "------------------------------------------------------------"

sudo su -c "chgrp -R $group /home/$main_user/.local/share/Steam/steamapps &> /dev/null"
sudo su -c "chmod -R g+rwx /home/$main_user/.local/share/Steam/steamapps &> /dev/null"

counter=1
while [ $counter -le 10 ]
do
    echo "[>] Creating syslink for user account$counter"
    sudo ln -s /home/$main_user/.local/share/Steam/steamapps /home/account$counter/.local/share/Steam/
    echo "[!] Created syslink for account$counter!"
    ((counter++))
done
echo "------------------------------------------------------------"

# Set permissions for home dir of main user and add main user to boost group
echo " "
echo "[>] Set permissions for home dir of main user..."
sudo su -c "chgrp -R $group /home/$main_user &> /dev/null"
sudo su -c "chmod -R g+rwx /home/$main_user &> /dev/null"
sudo su -c "usermod -a -G $group $main_user &> /dev/null"
echo " "

# Installing firejail sandbox
echo "[>] Installing firejail..."
sudo su -c "yes | pacman -S firejail &> /dev/null"
echo "[+] Firejail installed!"
echo " "

# Installing net-tools
echo "[>] Installing net-tools..."
sudo su -c "yes | pacman -S net-tools &> /dev/null"
echo "[+] Net-tools installed!"
echo " "

# Creating namespaces for every account
NAMESPACE=/var/run/netns/ns1
echo "[>] Creating namespaces..."
sudo su -c "chmod +x ./scripts/*"
sudo su -c "sudo ./scripts/ns-create 10"

# Check if namespaces got created already
if [ -f "$NAMESPACE" ]; then
echo "[+] Created namespaces."
fi
echo " "
echo "[+] Setup done!"