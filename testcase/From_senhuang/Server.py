import socket
import pid_ove


class socket_server:

  def __init__(self):
      self.sock=socket.socket()
      port=8888
      host='127.0.0.1'
      self.sock.bind((host,port))
      self.sock.listen(10)

server = socket_server()
### data received from Modelica

while True:
    conn,addr=server.sock.accept()
    print ('Got a connection from {}.'.format(addr))
    data = conn.recv(1024)
    print data

### inputs for Modelica models
    inputs=''
    datas=data.split(',')
   
    if data.find('tzone')!=-1:
#          print datas[3]
          q=max(pid_ove.compute_control(float(datas[3])),0)
#          print q
### Getting rid of the variable names from the incoming message
    for i in range((len(datas)-1)/2):
         if data.find('q')!=-1:
                    inputs=str(datas[1])+','+str(q)+','
         else:
                    inputs=inputs+str(datas[i*2+1])+','
    print inputs
    conn.send(inputs[:-1])
