#!/bin/bash
#Assign existing hostname to $hostn
hostn=$(cat /etc/hostname)

#Display existing hostname
echo "Hostname attuale $hostn"

#Ask for new hostname $newhost
echo "inserisci nuovo hostname: "
read newhost

#change hostname in /etc/hosts & /etc/hostname
sudo sed -i "s/$hostn/$newhost/g" /etc/hosts
sudo sed -i "s/$hostn/$newhost/g" /etc/hostname

#display new hostname
echo "nuovo hostname $newhost"

#Press a key to reboot
read -s -n 1 -p "Premi un tasto per riavviare "
sudo reboot
