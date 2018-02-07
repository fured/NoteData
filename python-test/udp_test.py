import socket
def listen():
    try:
        s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
        s.bind(('127.0.0.1',9999))
        s.settimeout(10)
        print 'Bind UDP on 9999....'
        #while True:
        data,addr = s.recvfrom(1024)
        print "Received from %s:%s" % (addr,data)
        s.sendto('Hello,%s!' % data,addr)
        return True
    except socket.timeout as e:
        return False


if __name__ == "__main__":
    if listen() == True:
        print "received success!"
    else:
        print "received failed!"
