iw wlan0 scan | sort | uniq -c | sort -n |  awk -F ':' '/SSID:/ {print $2;}' > /tmp/ssids  
cat /tmp/ssids
