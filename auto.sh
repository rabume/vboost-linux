#! /bin/bash

#Start Autoaccpet
clear
sleep 1
echo "-- Vertigo Boost Script --"
echo "-- Author: wandermaus   --"
echo ""

# Check if log files got created
if [ ! -f /home/user/.local/share/Steam/steamapps/common/Counter-Strike\ Global\ Offensive/csgo/1.log ] || [ ! -f /home/user/.local/share/Steam/steamapps/common/Counter-Strike\ Global\ Offensive/csgo/2.log ]; then
    echo "Please create the logfiles!"
    exit
fi

echo -n "" > /home/user/.local/share/Steam/steamapps/common/Counter-Strike\ Global\ Offensive/csgo/1.log
echo -n "" > /home/user/.local/share/Steam/steamapps/common/Counter-Strike\ Global\ Offensive/csgo/2.log

matchFound=0

while :
do

while [ "$matchFound" == 0 ]
do
search1=$(tail -n 200 /home/user/.local/share/Steam/steamapps/common/Counter-Strike\ Global\ Offensive/csgo/1.log | grep 'Received Steam datagram ticket for server steamid')
search2=$(tail -n 200 /home/user/.local/share/Steam/steamapps/common/Counter-Strike\ Global\ Offensive/csgo/2.log | grep 'Received Steam datagram ticket for server steamid')

if [ "$search1" ] && [ "$search2" ]; then
if [ "$search1" == "$search2" ]; then
echo "---- Match found! ----"
matchID1=$(echo $search1 | cut -d '=' -f2)
echo "Lobby [1]: $matchID1"

matchID2=$(echo $search2 | cut -d '=' -f2)
echo "Lobby [2]: $matchID2"

echo -n "" > /home/user/.local/share/Steam/steamapps/common/Counter-Strike\ Global\ Offensive/csgo/1.log
echo -n "" > /home/user/.local/share/Steam/steamapps/common/Counter-Strike\ Global\ Offensive/csgo/2.log

echo ""

sleep 5

window_id=$(xdotool search -name "VertigoBoost @$i")

#Get Window Postition and set Position
for val in $window_id
do
sleep 0.2
geo=$(xdotool getwindowgeometry $val 2> /dev/null)
xdotool windowactivate $val 2> /dev/null
tmp_x=$(echo $geo | awk '{print $4}' | cut -d"," -f2)
tmp_y=$(echo $geo | awk '{print $4}' | cut -d"," -f1)
x1=$((tmp_x+192))
y=$((tmp_y+225))
x2=$((tmp_x+202))
xdotool mousemove $y $x1 click 1 2> /dev/null
xdotool mousemove $y $x2 click 1 2> /dev/null
xdotool mousemove $y $x1 click 1 2> /dev/null
xdotool mousemove $y $x2 click 1 2> /dev/null
done

fi
fi

done

done
