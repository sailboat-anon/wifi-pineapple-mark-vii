Fun scripts for the WiFi Pineapple Mark VII

# __loot-n-scoot.sh - Keep your loot! Outsource the cracking pieces.__

This simple bash script for the [Hak Wifi Pineapple Mark VII](https://shop.hak5.org/products/wifi-pineapple) to fully automate your WPA war-driving and cracking.  It also keeps your handshake loot (pcap files) in a safe space so you don't lose them when the device crashes/resets/reboots.

It submits your .pcaps to https://onlinehashcrack.com and https://wpa-sec.stanev.org free cloud cracking services.  You'll receive an email with the results! 

Sit back, relax, and automate your WPA pen-test workload with loot-n-scoot.sh.

## __Requirements__

- WPA-SEC Key: https://wpa-sec.stanev.org/?get_key
- Valid e-mail address

## __Use__

```  
 chmod +x loot-n-scoot.sh
./loot-n-scoot.sh -e sailboat@marina-network.local -k 906ea9affd7e10a19af871a8592c8aen 
 ```
You can also use environment variables for automation/debugging/security
```
export email=sailboat@marina-network.local; export wpasec_key=906ea9affd7e10a19af871a8592c8aen; ./loot-n-scoot.sh
```
You'll likely want to run this on a schedule (default: 5min)
```
export VISUAL=nano; crontab -e
*/5 * * * * /root/loot-n-scoot.sh -e sailboat@marina-network.local -k 906ea9affd7e10a19af871a8592c8aen 
```

Persistent handshake storage: /root/loot/handshakes | Transaction logs: /root/loot/handshakes/logs

![newUI](https://github.com/sailboat-anon/wifi-pineapple-mark-vii/blob/main/img/newUI.png)

![successful_run](https://github.com/sailboat-anon/wifi-pineapple-mark-vii/blob/main/img/successful%20run.png)

![submitted_view_ui](https://github.com/sailboat-anon/wifi-pineapple-mark-vii/blob/main/img/submitted-caps.png)
