#!/bin/bash

sudo firejail --join=jail1 su - root -c "DISPLAY=:0 /home/user/Desktop/vboost-linux/blocked_ips.sh" &
sleep 9

sudo firejail --join=jail2 su - root -c "DISPLAY=:0 /home/user/Desktop/vboost-linux/blocked_ips.sh" &
sleep 9

sudo firejail --join=jail3 su - root -c "DISPLAY=:0 /home/user/Desktop/vboost-linux/blocked_ips.sh" &
sleep 9

sudo firejail --join=jail4 su - root -c "DISPLAY=:0 /home/user/Desktop/vboost-linux/blocked_ips.sh" &
sleep 9

sudo firejail --join=jail5 su - root -c "DISPLAY=:0 /home/user/Desktop/vboost-linux/blocked_ips.sh" &
sleep 9

sudo firejail --join=jail6 su - root -c "DISPLAY=:0 /home/user/Desktop/vboost-linux/blocked_ips.sh" &
sleep 9

sudo firejail --join=jail7 su - root -c "DISPLAY=:0 /home/user/Desktop/vboost-linux/blocked_ips.sh" &
sleep 9

sudo firejail --join=jail8 su - root -c "DISPLAY=:0 /home/user/Desktop/vboost-linux/blocked_ips.sh" &
sleep 9

sudo firejail --join=jail9 su - root -c "DISPLAY=:0 /home/user/Desktop/vboost-linux/blocked_ips.sh" &
sleep 9

sudo firejail --join=jail10 su - root -c "DISPLAY=:0 /home/user/Desktop/vboost-linux/blocked_ips.sh" &
