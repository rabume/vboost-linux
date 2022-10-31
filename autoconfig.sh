#!/bin/bash

for j in {1..10}
do

sudo chgrp boost -R /home/account${j}/

for i in $(ls -d /home/account${j}/.local/share/Steam/userdata/*/); do 
folders=$(echo ${i%%/} | cut -d '/' -f8)
if [ $folders != "anonymous" ]
then
    echo "${i%%/}"
    sudo rm -R ${i}*
    sudo cp -avr /home/user/Desktop/vboost-linux/configs/* ${i%%/}
fi
done

done