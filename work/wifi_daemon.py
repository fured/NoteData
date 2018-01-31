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
        self.__sock.shutdown(socket.SHUT_RDWR)
        self.__sock.close()

    def recv(self, size):
        "Receive a broadcast through the underlying socket."
        return self.__sock.recvfrom(size)

    def send(self, data,addr):
        "Send a broadcast through the underlying socket."
        #assert self.__sock.sendto(data, addr) == len(data), \
         #      'Not all data was sent through the socket!'
        self.__sock.sendto(data,addr)    
    def __gettimeout(self):
        return self.__sock.gettimeout()

    def __settimeout(self, value):
        self.__sock.settimeout(value)

    def __deltimeout(self):
        self.__sock.setblocking(True)

    timeout = property(__gettimeout, __settimeout, __deltimeout,
                       'Timeout on blocking socket operations.')

################################################################################

# return: true - timeout
def listen_commands(b, timeout):
        b.__settimeout(timeout)
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
        logging.debug("[3333]Response {} Data: {}".format(address,reponse))
        if reponse['result'] == 'ok':
            #save_config();
            set_wifi(data_py['ssid'],data_py['password'])
            wifi_setup['ssid/password']['ssid'] = data_py['ssid']
            wifi_setup['ssid/password']['password'] = data_py['password']
            wifi_setup['ever_connected'] = 'Yes'
            write_config_file(wifi_setup)
            return False
        return True 
            
            
################################################################################
#according to ssid and password ,set wifi
def set_wifi(ssid,password):
#   pdb.set_trace()
    os.system('./wifi_set.sh ' + ssid + ' ' + password )
    logging.info('set wifi success')

 
#################################################################################
#according to check_wifi() status to set wifi
def wifi_set():
    logging.info("Scan and Set wifi ....")
    os.system("./wifi_scan.sh ")
    fd = open("/tmp/ssids")
    for line in fd:
        ssid = line.strip().replace("\n","")
        if ssid.startswith("iconnect-ams-"):
            length = len(ssid)
            crc =int(ssid[(length-3):length])
            check = crc % 10 + (crc/10)%10 + (crc/100)%10
            if check == 10:
                logging.debug("[wifi]Set wifi:uuid is '%s'  password is '12345678'" % ssid)
                set_wifi(ssid,"12345678")
                if check_wifi():
                    break
    fd.close()
    time.sleep(3)
    
    
    
    
################################################################################
#check the current system connect wifi or not connect
def check_wifi():
    status_file = os.popen("iwconfig wlan0 | grep 'Point'")
    status = status_file.read().strip().split()
    status_file.close()
    if "Not-Associated" in status:
        logging.info("[wifi]Current exist wlan:False")
        return Null
    else:
        addr  = os.popen("ifconfig wlan0 | grep 'inet addr' | cut -d ':' -f 2 | awk '{print $1}'")
        ssid = os.popen("iwconfig wlan0 |grep 'ESSID' | cut -d ':' -f 2")
        if addr.read() == "":
            set_wifi(ssid.read().replace('\"','').replace('\n','').strip(),"12345678")
        #addr  = os.popen("ifconfig wlan0 | grep 'inet addr' | cut -d ':' -f 2 | awk '{print $1}'")
        logging.info("[wifi]Current exist wlan:addr:"+ addr.read() +" ESSID:" +ssid.read())
        SSID = ssid.read()
        addr.close()
        ssid.close()
        return SSID

   
# scan iconnect-ams hotspot and store ssid into a global arrary
def scan_wifi():
    os.system('./wifi_scan.sh')
    fd = open('/tmp/ssids')
    for line in fd:
        ssid = line.strip().replace("\n","")
        if ssid.startswith("iconnect-ams-"):
            length = len(ssid)
            crc =int(ssid[(length-3):length])
            check = crc % 10 + (crc/10)%10 + (crc/100)%10
            if check == 10:
                logging.debug("[wifi]discover wifi:%s" % ssid)
                iconnect-ams-hotspots.append(ssid)
      
    return Null

def wifi_thread():
    global DaemonStatus
    print DaemonStatus
    DaemonStatus='S1'
    CurrentIconnectHotspotIndex=0
    
    while True:
        # step 1: load the config file
        wifi_setup = read_config_file()
        # step 2: 
        if wifi_setup['suspend_daemon'] == 1:
            logging.info('wifi set daemon not start!')
            time.sleep(60)
            continue

        if wifi_setup['disable'] == 'Yes' or wifi_setup['disable'] == 'yes':
            # to disable wifi here
            os.system('ifconfig wlan0 down')
            logging.info('wlan0 interface is down!')
            time.sleep(60)
            continue


        ssid = check_wifi()
        
        if ssid == none:
            if DaemonStatus == 'S1':
                CurrentIconnectHotspotIndex=0
                scan_wifi();
                if len(iconnect-ams-hotspots) == 0:
                    DaemonStatus='S3'
                else:
                    DaemonStatus='S2'
                continue
            
            if DaemonStatus == 'S2':
                if CurrentIconnectHotspotIndex == len(iconnect-ams-hotspots):
                    DaemonStatus='S3'
                set_wifi(iconnect-ams-hotspots[CurrentIconnectHotspotIndex], '12345678')
                CurrentIconnectHotspotIndex += 1
                continue
        
            if DaemonStatus =='S3':
                set_wifi(configured_ssid, configured_password)
                DaemonStatus='S1'
                continue
        elif ssid.startswith('iconnect-ams-'):  #to change it as match
            port = wifi_setup['port']
            b = Beacon(port)
            if listen_commands(b, 30) == True:
                #timeout
                continue
            else:
                DaemonStatus='S3'
                continue
        else:
            port = wifi_setup['port']
            b = Beacon(port)
            if listen_commands(b, 60) == True:
                #timeout
                continue
            else:
                DaemonStatus='S3'
                continue         
################################################################################
def read_config_file():
    fb = open('wifi_setup.cfg')
    wifi_configure = json.load(fb)
    fb.close()
    return wifi_configure

def write_config_file(wifi_status):
    fb = open('wifi_setup.cfg','w')
    fb.write(json.dumps(wifi_status))
    fb.close()
################################################################################

if __name__ == '__main__':
    
    logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S')
            #        filename='ams_config.log',
             #       filemode='w')
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

