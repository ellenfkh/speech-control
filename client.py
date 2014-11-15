import socket

sock = socket.socket()
sock.connect(("localhost", 3456))
sock.send("Hello!\n")

sock.close()
