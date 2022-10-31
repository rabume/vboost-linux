#!/bin/bash

#SET PATHS
NAMESPACE=/var/run/netns/ns1

cd ..
cd ..
cd ..

sudo xhost +

#CHECK IF NAMESPACES GOT CREATED ALREADY
if [ -f "$NAMESPACE" ]; then
echo "Namespaces exist!"
echo "-----------------------------------"
fi

#CREATE NAMESPACES
if [ ! -f "$NAMESPACE" ]; then
cd /home/user/Desktop/vboost-linux
./scripts/ns-create 10
echo "Namespaces got created!"
echo "-----------------------------------"
fi

# Start steams in firejail jails
sudo firejail --noprofile --name=jail1 --allusers --netns=ns1 su - account1 -c "DISPLAY=:0 steam -silent -login user pass -applaunch 730 -novid -nosound -w 640 -h 480 +exec boost.cfg" &>/dev/null &
echo "ACCOUNT  1:  CS:GO STARTED!"
sleep 6

sudo firejail --noprofile --name=jail2 --allusers --netns=ns2 su - account2 -c "DISPLAY=:0 steam -silent -login user pass -applaunch 730 -novid -nosound -w 640 -h 480 +exec boost.cfg" &>/dev/null &
echo "ACCOUNT  2:  CS:GO STARTED!"
sleep 6

sudo firejail --noprofile --name=jail3 --allusers --netns=ns3 su - account3 -c "DISPLAY=:0 steam -silent -login user pass -applaunch 730 -novid -nosound -w 640 -h 480 +exec boost.cfg" &>/dev/null &
echo "ACCOUNT  3:  CS:GO STARTED!"
sleep 6

sudo firejail --noprofile --name=jail4 --allusers --netns=ns4 su - account4 -c "DISPLAY=:0 steam -silent -login user pass -applaunch 730 -novid -nosound -w 640 -h 480 +exec boost.cfg" &>/dev/null &
echo "ACCOUNT  4:  CS:GO STARTED!"
sleep 6

sudo firejail --noprofile --name=jail5 --allusers --netns=ns5 su - account5 -c "DISPLAY=:0 steam -silent -login user pass -applaunch 730 -novid -nosound -w 640 -h 480 +exec boost.cfg" &>/dev/null &
echo "ACCOUNT  5:  CS:GO STARTED!"
sleep 6

sudo firejail --noprofile --name=jail6 --allusers --netns=ns6 su - account6 -c "DISPLAY=:0 steam -silent -login user pass -applaunch 730 -novid -nosound -w 640 -h 480 +exec boost.cfg" &>/dev/null &
echo "ACCOUNT  6:  CS:GO STARTED!"
sleep 6

sudo firejail --noprofile --name=jail7 --allusers --netns=ns7 su - account7 -c "DISPLAY=:0 steam -silent -login user pass -applaunch 730 -novid -nosound -w 640 -h 480 +exec boost.cfg" &>/dev/null &
echo "ACCOUNT  7:  CS:GO STARTED!"
sleep 6

sudo firejail --noprofile --name=jail8 --allusers --netns=ns8 su - account8 -c "DISPLAY=:0 steam -silent -login user pass -applaunch 730 -novid -nosound -w 640 -h 480 +exec boost.cfg" &>/dev/null &
echo "ACCOUNT  8:  CS:GO STARTED!"
sleep 6

sudo firejail --noprofile --name=jail9 --allusers --netns=ns9 su - account9 -c "DISPLAY=:0 steam -silent -login user pass-applaunch 730 -novid -nosound -w 640 -h 480 +exec boost.cfg" &>/dev/null &
echo "ACCOUNT  9:  CS:GO STARTED!"
sleep 6

sudo firejail --noprofile --name=jail10 --allusers --netns=ns10 su - account10 -c "DISPLAY=:0 steam -silent -login user pass -applaunch 730 -novid -nosound -w 640 -h 480 +exec boost.cfg" &>/dev/null &
echo "ACCOUNT 10:  CS:GO STARTED!"
echo "-----------------------------------"

echo "Press enter when all account are started"
read

# Get Window ID's
mapfile -t csgo_ids < <(xdotool search -name "Counter-Strike: Global Offensive")

# Change Name
for i in {0..9}
do
xdotool set_window --name "VertigoBoost @$((i+1))" ${csgo_ids[i]} 2>/dev/null
done

sleep 5
win_id1=$(xdotool search -name "VertigoBoost @1")
sleep 0.5
xdotool windowmove $win_id1 0 0 2>/dev/null
sleep 0.5

win_id2=$(xdotool search -name "VertigoBoost @2")
sleep 0.5
xdotool windowmove $win_id2 384 0 2>/dev/null
sleep 0.5

win_id3=$(xdotool search -name "VertigoBoost @3")
sleep 0.5
xdotool windowmove $win_id3 768 0 2>/dev/null
sleep 0.5

win_id4=$(xdotool search -name "VertigoBoost @4")
sleep 0.5
xdotool windowmove $win_id4 1152 0 2>/dev/null
sleep 0.5

win_id5=$(xdotool search -name "VertigoBoost @5")
sleep 0.5
xdotool windowmove $win_id5 1536 0 2>/dev/null
sleep 0.5

win_id6=$(xdotool search -name "VertigoBoost @6")
sleep 0.5
xdotool windowmove $win_id6 0 455 2>/dev/null
sleep 0.5

win_id7=$(xdotool search -name "VertigoBoost @7")
sleep 0.5
xdotool windowmove $win_id7 384 455 2>/dev/null
sleep 0.5

win_id8=$(xdotool search -name "VertigoBoost @8")
sleep 0.5
xdotool windowmove $win_id8 768 455 2>/dev/null
sleep 0.5

win_id9=$(xdotool search -name "VertigoBoost @9")
sleep 0.5
xdotool windowmove $win_id9 1152 455 2>/dev/null
sleep 0.5

win_id10=$(xdotool search -name "VertigoBoost @10")
sleep 0.5
xdotool windowmove $win_id10 1536 455 2>/dev/null
sleep 0.5

echo "CS:GO Got moved in position!"
echo "-----------------------------------"
echo "Press CTRL+C to close all CS:GOs"
read