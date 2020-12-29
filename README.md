Fun scripts for the WiFi Pineapple Mark VII (Module Support is Light)

# __ohc-api - Keep your loot! Outsource the cracking pieces.__

This simple bash script for the [Hak Wifi Pineapple Mark VII](https://shop.hak5.org/products/wifi-pineapple) to fully automate your WPA war-driving and cracking.  It also keeps your handshake loot (pcab files) in a safe space so you don't lose them when the device crashes/resets/reboots.

It uses the onlinehashcrack.com API to submit your .pcab captures to their free cloud cracking service.  You'll receive an email with the results! 

You will receive an email confirmation and upon completion!  Sit back, relax, and automate your WPA pen-test workload with ohc-api.sh.

## __Use__

```  
 nano ohc-api.sh
 (change the receiving email address, 'email=')
 chmod +x ohc-api.sh
 ./ohc-api.sh 
 ```
You'll likely want to run this on a schedule (default: 5min)
```
export VISUAL=nano; crontab -e
*/5 * * * * /pineapple/ohc-api.sh
```

Persistent handshake storage: /root/loot/handshakes | Transaction logs: /root/loot/handshakes/logs


```                  .   Fairwinds!
                .'|     .8
               .  |    .8:
              .   |   .8;:        .8
             .    |  .8;;:    |  .8;
            .     n .8;;;:    | .8;;;
           .      M.8;;;;;:   |,8;;;;;
          .    .,"n8;;;;;;:   |8;;;;;;
         .   .',  n;;;;;;;:   M;;;;;;;;
        .  ,' ,   n;;;;;;;;:  n;;;;;;;;;
       . ,'  ,    N;;;;;;;;:  n;;;;;;;;;
      . '   ,     N;;;;;;;;;: N;;;;;;;;;;
     .,'   .      N;;;;;;;;;: N;;;;;;;;;;
    ..    ,       N6666666666 N6666666666
    I    ,        M           M
   ---nnnnn_______M___________M______mmnnn
         "-.                          /
  __________"-_______________________/_________
  ```
