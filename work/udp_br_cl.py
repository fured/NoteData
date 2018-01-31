"""Module for simple UDP broadcast support.

The classes in this module are stepping stones for building discoverable
services on a network. Server replies are to be handled by the importer."""

################################################################################

__author__ = 'Stephen "Zero" Chappell <Noctis.Skytower@gmail.com>'
__date__ = '4 December 2011'
__version__ = '$Revision: 5 $'

################################################################################

import socket,pdb,logging,multiprocessing
import threading
import time
import json
import os
################################################################################

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
#
def test():
    "Test the beacon broadcasting class."
    b = Beacon(3333)
    logging.info("Start listening in '3333' port....")
    test_recv(b)

def test_send(b):
    "Test the beacon's send method."
    while True:
        b.send(time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()).encode())
        time.sleep(5)

def test_recv(b):
    "Test the beacon's recv method."
    while True:
        data, address = b.recv(1 << 12)
        logging.info('[3333]From: {} Recerve:{}'.format(address, data.decode()))
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
            change_wifi(True)
            set_wifi(data_py['ssid'],data_py['password'])
            change_wifi(False)
      
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
        return False
    else:
        addr  = os.popen("ifconfig wlan0 | grep 'inet addr' | cut -d ':' -f 2 | awk '{print $1}'")
        ssid = os.popen("iwconfig wlan0 |grep 'ESSID' | cut -d ':' -f 2")
        if addr.read() == "":
            os.system('./wifi_set.sh ' + ssid.read().replace('\"','').replace('\n','').strip() + ' ' + '12345678' + ' >> /dev/null 2>>ams_config.log')
        addr  = os.popen("ifconfig wlan0 | grep 'inet addr' | cut -d ':' -f 2 | awk '{print $1}'")
        logging.info("[wifi]Current exist wlan:addr:"+ addr.read() +" ESSID:" +ssid.read())
        addr.close()
        ssid.close()
        return True
            
################################################################################

if __name__ == '__main__':
    
    logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S')
            #        filename='ams_config.log',
             #       filemode='w')
    __WAIT_SET_WIFI = False
    def change_wifi(status):
        global __WAIT_SET_WIFI
        __WAIT_SET_WIFI = status
    def aaa():
        while True:
            logging.info(__WAIT_SET_WIFI)
            if not __WAIT_SET_WIFI:
                if not check_wifi():
                    wifi_set()
            time.sleep(3)

    lock = threading.Lock()
    t1 = threading.Thread(target=aaa)
    t2 = threading.Thread(target=test)
    t1.start()
    t2.start() 
