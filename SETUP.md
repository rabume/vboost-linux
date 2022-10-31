## Setup Vertigo Boost on Manjaro

### Requirements:
- Manjaro KDE
- Steam installed for main user

1. Create group: `sudo groupadd boost`
2. Create 10 user accounts:
    - Add account: `sudo useradd account1`
    - Set password: `sudo passwd account1`
    - Create home directory: `sudo mkhomedir_helper account1`
    - Add to group: `sudo usermod -a -G boost account1`

3. Copy steam folder from your main user to all other Users home.

    ``` bash
    sudo cp -avr /home/main/.local/share/Steam /home/account1/.local/share/
    ```
    Change owner and group of folder to the right account
    ``` bash
    sudo chown -R account1 /home/account1/.local/share/steam
    sudo chgrp -R boost /home/account1/.local/share/steam
    sudo chmod -R g+rwx /home/account1/.local/share/steam
    ```

4. Enable xhost: `sudo xhost +`

5. Start steam on all users and login then close again.  
The first start we create all the needed files.
- Change account with su: `sudo account1`
- Start steam: 
    ``` bash
    cd /home/account1/.local/share/Steam
    ./steam.sh
    ```
6. Delete on all 10 users the steamapps folder and create a link from the main users steamapps 
    ``` bash
    sudo ln -s (path to lib, "steamapps") /path/toaccount/steamfolder
    ```
7. Start steam with the main user and download CS:GO

8. Install firejail: `sudo pacman -S firejail`

9. Install net-tools: `sudo pacman -S net-tools`

10. Take the namespace scripts and move it in to a folder named script. 
Set permissions: `chmod +x ./scripts/*`

11.	Create 10 namespaces: `sudo ./scripts/ns-create 10` 

12.	Get your display ID: `echo $DISPLAY`

13.	Use the ID you got above in the command below.
    ``` bash
    sudo firejail --noprofile --name=jail1 --netns=ns1 --allusers su --account1 -c "DISPLAY=:1 steam -login username password -applaunch 730 -windowed -h 270 -w 270 -nosound -novid"
    ```
In the command above change jail / ns / always to the next number for each account steam. Also change account / user.
The lock file in /tmp has to be deleted after every start of any csgo instance. The name is always the same so you can easily write a shell script for that task.