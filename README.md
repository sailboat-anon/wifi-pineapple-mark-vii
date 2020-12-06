Fun scripts for the WiFi Pineapple Mark VII (Module Support is Light)

# __scripts/ohc-api.sh - keep your loot!  and outsource the GPU pieces.__

This simple bash script for the [Hak Wifi Pineapple Mark VII](https://shop.hak5.org/products/wifi-pineapple) features persistent handshake storage and automatically submits your handshakes to [this wonderful service](onlinehashcrack.com)(onlinehashcrack.com)!  

You will receive an email confirmation and upon completion!  Sit back, relax, and automate your WPA pen-test workload with ohc-api.sh.

## __install and use__

```  
 wget https://raw.githubusercontent.com/sailboat-anon/wifi-pineapple-mark-vii/main/scripts/ohc-api.sh
 chmod a+x ohc-api.sh
 ./ohc-api.sh 
 ```
You'll likely want to run this on a schedule (default: 5min)
```
export VISUAL=nano; crontab -e
*/5 * * * * /pineapple/ohc-api.sh
```

## __workflow:__

* capture handshakes using mark vii
* handshakes are moved from /tmp to /root/loot/handshakes
* handshakes are sent to the onlinehashcrack.com api, user receives an email confirmation and upon completion
* (be sure to set the 'email' variable below to your email address)
* submitted handshakes in /root/loot/handshakes are renamed 'submitted-<formername>.cpab'
 
__persistent handshake storage:__ /root/loot/handshakes

__transaction logs:__ /root/loot/handshakes/logs
