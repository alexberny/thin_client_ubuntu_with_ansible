#!/bin/bash

newhost=""
hostn=$(hostname)
while [ -z $newhost ];
do
    newhost=$(zenity --entry --title="Inserisci il nuovo hostname" --text="Hostname non settato, inserisci il nuovo hostname" --entry-text "$hostn")
done
sed -i "s/$hostn/$newhost/g" 
/etc/hosts; sed -i "s/$hostn/$newhost/g" /etc/hostname
zenity --notification --window-icon="info" --text="Nuovo hostname inserito!" 
reboot