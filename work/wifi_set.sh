if [ ! $# == 2 ]; then
echo "Usage: $0 uuid password:"
exit
fi

wpa_passphrase "$1"   "$2" > /etc/wpa_supplicant.conf
killall -9 wpa_supplicant

rfkill unblock all
ifdown wlan0
ifup wlan0
udhcpc -i wlan0





