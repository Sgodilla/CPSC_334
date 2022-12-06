import socket
import sys

LOCAL_UDP_IP = "172.29.30.59"
SHARED_UDP_PORT = 4210
server = socket.socket()
server.bind((LOCAL_UDP_IP, SHARED_UDP_PORT))
server.listen(4)
client_socket, client_address = server.accept()
print(client_address, "has connected")
while True:
    recvieved_data = client_socket.recv(1024)
    print(recvieved_data)