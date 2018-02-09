#!/bin/python
import socket,pdb,logging,multiprocessing
import threading
import time
import json
import os
import sys

################################################################################

global DaemonStatus
DaemonStatus = 'S1'
global iconnect_ams_hotspots
iconnect_ams_hotspots = [] 

class Beacon:

    __slots__ = '__sock', '__addr'

    def __init__(self, port):
        "Initialize the beacon for sending and receiving data."
        self.__sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.__sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, True)
        self.__sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, True)
        self.__sock.bind(('0.0.0.0', port))
        self.__addr = '255.255.255.255', port

    def __del__(self):
        "Shutdown and close the underlying socket."
        self.__sock.close()

    def recv(self, size):
        "Receive a broadcast through the underlying socket."
        return self.__sock.recvfrom(size)

    def send(self, data,addr):
        "Send a broadcast through the underlying socket."
        #assert self.__sock.sendto(data, addr) == len(data), \
         #      'Not all data was sent through the socket!'
        self.__sock.sendto(data,addr)    
    def gettimeout(self):
        return self.__sock.gettimeout()

    def settimeout(self, value):
        self.__sock.settimeout(value)

    def deltimeout(self):
        self.__sock.setblocking(True)


################################################################################
#start listen port(default 3333)
def listen_commands(b, timeout):
    try:
        b.settimeout(timeout)
        wifi_setup = read_config_file()
        data, address = b.recv(1 << 12)
        logging.info('[{}]From: {} Recerve:{}'.format(wifi_setup['port'],address, data.decode()))
        reponse = {
                    "tag":"WIFI-setup-response",
                    "result":"ok|fail"
                }
        
        data_py = json.loads(data)
        if isinstance(data_py,dict):
            for (key,value) in data_py.items():
                if data_py[key] != '' and data_py[key] is not None:
                    reponse['result'] = 'ok'
                else:
                    reponse['result'] = 'fail'
                    break
        else:
            reponse['result'] = 'fail'
        b.send(json.dumps(reponse),address)
        logging.debug("[listen port]Response {} Data: {}".format(address,reponse))
        if reponse['result'] == 'ok':
            if scan_wifi("decide_received_wifi_information",data_py['ssid']):
                status = set_wifi(data_py['ssid'],data_py['password'])
                if status:
                    wifi_setup['ssid/password']['ssid'] = data_py['ssid']
                    wifi_setup['ssid/password']['password'] = data_py['password']
                    wifi_setup['ever_connected'] = 'Yes'
                    write_config_file(wifi_setup)
                    DaemonStatus='S3'
                    return True
                else:
                    return False
            else:
                return False
    except Exception as e:
        del b
        return False
            
            
################################################################################
#according to ssid and password ,set wifi
def set_wifi(ssid,password):
    status = os.system('./wifi_set.sh ' + ssid + ' ' + password )
    if status == 0:
        logging.info('[set wifi]set wifi success')
        return True
    else:
        logging.info('[set wifi]set wifi failed !')
        return False

###############################################################################
#check the current system connect wifi or not connect
def check_wifi():
    status_file = os.popen("iwconfig wlan0 | grep 'Point'")
    status = status_file.read().strip().split()
    status_file.close()
    if "Not-Associated" in status:
        logging.info("[check wifi]Current exist wlan:False")
        return None
    else:
        addr  = os.popen("ifconfig wlan0 | grep 'inet addr' | cut -d ':' -f 2 | awk '{print $1}'")
        ssid = os.popen("iwconfig wlan0 |grep 'ESSID' | cut -d ':' -f 2")
        if addr.read() == "":
            set_wifi(ssid.read().replace('\"','').replace('\n','').strip(),"12345678")
        addr  = os.popen("ifconfig wlan0 | grep 'inet addr' | cut -d ':' -f 2 | awk '{print $1}'")
        logging.info("[check wifi]Current exist wlan:addr:"+ addr.read() +" ESSID:" +ssid.read())
        SSID = ssid.read().replace('\"','').replace('\n','').strip()
        addr.close()
        ssid.close()
        return SSID

############################################################################   
# scan iconnect-ams hotspot and store ssid into a global arrary
def scan_wifi(use_sign,*ssid):
    while True:
        os.system('./wifi_scan.sh 2>/tmp/ssids')
        fd = open('/tmp/ssids')
        if fd.read().startswith("command failed"):
            time.sleep(3)
            fd.close()
        else:
            fd.close()
            break
    fd= open('/tmp/ssids')
    if use_sign == 'find_hotspot':
        global iconnect_ams_hotspots 
        iconnect_ams_hotspots = []
        for line in fd:
            ssid = line.strip().replace("\n","")
            if ssid.startswith("iconnect-ams-"):
                length = len(ssid)
                crc =int(ssid[(length-3):length])
                check = crc % 10 + (crc/10)%10 + (crc/100)%10
                if check == 10:
                    logging.debug("[scan wifi]discover wifi:%s" % ssid)
                    iconnect_ams_hotspots.append(ssid)
    elif use_sign == 'decide_wifi_config_file':
        if ssid[0] != '' or ssid[1] != '':
            exist_ssid = False
            for line in fd:
                ssid = line.strip().replace('\n','')
                if ssid == ssid[0]:
                    exist_ssid = True
                    fd.close()
                    loggging.info("[scan wifi]exist wifi:%s" % ssid[0])
                    return exist_ssid
            fd.close()
            logging.info("[scan wifi]Not exist wifi:%s" % ssid[0])
            return False
        else:
            fd.close()
            return False
    elif use_sign == 'decide_received_wifi_information':
        wifi_ssid = ssid[0]
        for line in fd:
            ssid_de = line.strip().replace("\n","")
            if ssid_de == wifi_ssid:
                fd.close()
                return True
        fd.close()
        logging.info("[scan wifi] Not exist wifi:%s" % ssid[0])
        return False
    fd.close()
      
########################################################################
def wifi_thread():
    global DaemonStatus
    DaemonStatus='S1'
    CurrentIconnectHotspotIndex=0
    while True:
        # step 1: load the config file
        wifi_setup = read_config_file()
        # step 2: 
        if wifi_setup['suspend_daemon'] == 1:
            logging.info('[wifi thread]wifi set daemon not start!')
            time.sleep(60)
            continue

        if wifi_setup['disable'] == 'Yes' or wifi_setup['disable'] == 'yes':
            # to disable wifi here
            os.system('ifconfig wlan0 down')
            logging.info('[wifi thread]wlan0 interface is down!')
            time.sleep(60)
            continue


        ssid = check_wifi()
        if ssid == None:
            if DaemonStatus == 'S1':
                CurrentIconnectHotspotIndex=0
                scan_wifi('find_hotspot')
                if len(iconnect_ams_hotspots) == 0:
                    DaemonStatus='S3'
                else:
                    DaemonStatus='S2'
                continue
            
            if DaemonStatus == 'S2':
                if CurrentIconnectHotspotIndex < len(iconnect_ams_hotspots):
                    if set_wifi(iconnect_ams_hotspots[CurrentIconnectHotspotIndex],'12345678'):
                        continue
                    else:
                        time.sleep(15)
                        CurrentIconnectHotspotIndex += 1
                        continue
                else:
                    DaemonStatus = 'S3'
                    continue

            if DaemonStatus =='S3':
                configured_ssid = read_config_file()['ssid/password']['ssid']
                configured_password = read_config_file()['ssid/password']['password']
                if scan_wifi("decide_wifi_config_file",configured_ssid,configured_password):
                    set_wifi(configured_ssid, configured_password)
                DaemonStatus='S1'
                continue
        else:
            port = wifi_setup['port']
            b = Beacon(port)
            logging.info("start listen on %s..." %port )
            if listen_commands(b, 10):
                logging.info('Received udp packet !')
                continue
            else:
                logging.info('Not received udp packet or set wifi failed!')
                DaemonStatus='S3'
                continue
################################################################################
#read config file of wifi
def read_config_file():
    fb = open('wifi_setup.cfg')
    wifi_configure = json.load(fb)
    fb.close()
    return wifi_configure

#write config file of wifi
def write_config_file(wifi_status):
    fb = open('wifi_setup.cfg','w')
    fb.write(json.dumps(wifi_status,indent = 4))
    fb.close()
################################################################################

if __name__ == '__main__':
    
    logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S')
                    filename='ams_config.log',
                    filemode='w')
    if len(sys.argv) > 2:
        print '[Usage]:wifi_daemon.py -s=on|off'
        exit()
    if len(sys.argv) == 2:
        daemon_status = sys.argv[1].split('=')
        if len(daemon_status) != 2:
            print '[Usage]:wifi_daemon.py -s=on|off'
            exit()
        if daemon_status[0] == '-s':
            if daemon_status[1] == 'on':
                wifi_setup = read_config_file()
                wifi_setup['suspend_daemon'] = 0
                write_config_file(wifi_setup)
                exit()
            if daemon_status[1] == 'off':
                wifi_setup = read_config_file()
                wifi_setup['suspend_daemon'] = 1
                write_config_file(wifi_setup)
                exit()
            print '[Usage]:wifi_daemon.py -s=on|off'
            exit()
        print '[Usage]:wifi_daemon.py -s=on|off'
        exit()
    t1 = threading.Thread(target=wifi_thread)
    t1.start()
