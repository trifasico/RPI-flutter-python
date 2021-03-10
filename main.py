from simple_websocket_server import WebSocketServer, WebSocket
from threading import Thread
import time

clients = []
trama = ""
timeant = time.time()

class MyWebSocket(WebSocket):
    def handle(self):
        global trama
        # echo message back to client
        #self.send_message(self.data)
        print(self.data)
        trama = self.data

    def connected(self):
        print(self.address, 'connected')
        clients.append(self)
        print(clients)

    def handle_close(self):
        print(self.address, 'closed')
        clients.remove(self)
        trama = ""

server = WebSocketServer('192.168.0.230', 8000, MyWebSocket)

def websocket_server():
    while(1):
        server.handle_request()

def read_text_input():
    while(1):
        text = input()
        for client in list(clients):
            client.send_message(text)
            print("texto enviado", text)

def trama_print():
    global timeant
    global trama
    print(time.time() - timeant)
    while True:
        #print(".", end='')
        if (trama != "" and (time.time() - timeant > 2)):
            timeant = time.time()
            print(trama)

if __name__ == '__main__':
    Thread(target=websocket_server).start()
    Thread(target=read_text_input).start()
    Thread(target=trama_print).start()

