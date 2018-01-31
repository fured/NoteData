import socket,json


s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
#ts = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.bind(("0.0.0.0",6666))
#ts.connect(("192.168.1.103",12345))
print "listen part 6666...."

while True:
    data,addr = s.recvfrom(1 << 12)
    print("From:{} \n {} \n".format(addr,data.decode()))
    response = {"aaaaaa":"aaaaaaaaa","aaaaaaa":"aaaaaaaa"}
    #ts.send(json.dumps(response))
    print "response"
    s.sendto(json.dumps(response),addr)    
    

