import socket,time
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# 建立连接:
s.connect(('localhost', 8888))
# 接收欢迎消息:
#print(s.recv(1024).decode('utf-8'))
for data in [b'Michael', b'Tracy', b'Sarah']:
    # 发送数据:
    s.send(data)
    print (data)
    time.sleep(3)
 #   print(s.recv(1024).decode('utf-8'))
s.send(b'exit')
s.close()
