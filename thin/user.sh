
 
export DISPLAY=:0
/usr/bin/x11vnc  -create -xkb -noxrecord -noxfixes -noxdamage -display :0 -auth /var/run/lightdm/root/:0 -rfbauth /home/user/.x11vnc.pass -forever -rfbport 5905 & 

. /home/user/config 

#HOST=172.16.10.254
#HOST=$(ip route | grep default  | awk ' { print $3 } ')

while :
do
  ping -c 1 $HOST 
  if [ $? -eq 0 ]
  then
  pkill -9 pqiv
  /usr/bin/vmware-view --fullscreen --nonInteractive --usbAutoConnectAtStartUp="TRUE" --usbAutoConnectOnInsert="TRUE" --nomenubar --serverURL="vdi.revspa.it" --domainName="REVSPA"
  else
   
  pqiv -t -i -f  /home/user/Pictures/REV.gif & 
  #sleep 15 ; kill $!
  fi
  sleep 15
done

#############################
#!/bin/bash

set +e

a = 0
showed_alert = 0
showed_loading = false

##### set new hostname if hostname is set to default
hostn = $(hostname)
while [ hostname = "thin" ];
do
  if zenity --entry --title="Inserisci il nuovo hostname" --text="Hostname non settato, inserisci il nuovo hostname" 
  then 
    newhost= $? 
    #change hostname in /etc/hosts & /etc/hostname
    sudo sed -i "s/$hostn/$newhost/g" /etc/hosts
    sudo sed -i "s/$hostn/$newhost/g" /etc/hostname
    zenity --notification --window-icon="info" --text="Nuovo hostname inserito!" 
    sudo reboot
  fi
fi

while :
do
  # get active interface
  eths_dev=$(nmcli -t -f uuid,type,device c s --active | grep 802 | awk -F  ":" '{ print $3 }' | paste -s -d, -)
  if [ -z "$eths_dev" ]
  then
    if [ ! "$showed_loading" ]
    then
      pqiv -t -i -f  /home/user/Pictures/REV.gif &
      showed_loading = true
    fi
    ((a+=1))
    if [ $a -ge 4 ]
    do
      if [ "$showed_alert" = 0 ]
      then
        showed_alert = 1
        zenity --error --width=200 --text "Errore di rete, contattare l'ufficio ICT"
        showed_alert = 0
      fi
    done
  else
    # reset condition
    pkill -9 pqiv
    showed_loading = false
    a = 0
    # set current active interface for vino
    eths_uuid=$(nmcli -t -f uuid,type c s --active | grep 802 | awk -F  ":" '{ print "'\''" $1 "'\''" }' | paste -s -d, -)
    gsettings set org.gnome.settings-daemon.plugins.sharing.service:/org/gnome/settings-daemon/plugins/sharing/vino-server/ enabled-connections "[ $eths_uuid ]"

    vmware-view --nomenubar
  fi
  sleep 15
done