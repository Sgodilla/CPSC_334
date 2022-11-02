import win32api, win32con
import socket

UDP_IP = "172.29.133.66"
#UDP_IP = "172.29.133.26" # The IP that is printed in the serial monitor from the ESP32
#UDP_IP = "172.29.16.108"
#UDP_IP = "192.168.1.113" # The IP that is printed in the serial monitor from the ESP32
SHARED_UDP_PORT = 4210
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)  # Internet  # UDP
sock.settimeout(10)
sock.connect((UDP_IP, SHARED_UDP_PORT))

# Initial Cursor Position
cx = 0
xMax = 1920
cy = 0
yMax = 1080

Sensitivity = 100 # Higher numbers = higher sensitivity

enCursor = 0    # Start with cursor disabled
swStateCurr = 0 # Current state of switch
swStatePrev = 0 # Previous state of switch
analogState = 0 # State of analog button

def swPressed():
    global swStateCurr
    global swStatePrev
    return swStatePrev - swStateCurr

def loop():
    global cx
    global cy
    global enCursor
    global swStateCurr
    global swStatePrev
    global analogState

    while True:
        packet = sock.recv(2048)
        print(packet.decode('utf-8'))
        data = packet.decode('utf-8').split(',')
        roll = float(data[0]) * Sensitivity
        pitch = float(data[1]) * Sensitivity
        yaw = float(data[2]) * Sensitivity
        brake = int(data[3])
        throttle = int(data[4])
        analog = int(data[5])

        swStatePrev = swStateCurr
        if (throttle > 0 and brake > 0):
            swStateCurr = 1
        else:
            swStateCurr = 0
        
        #print(roll, pitch, yaw, swStateCurr)

        x = cx - roll
        x = max(min(xMax, x), 0)
        y = cy + pitch
        y = max(min(yMax, y), 0)

        sw = swPressed()

        if (enCursor and sw == 1):
            enCursor = 0
            win32api.keybd_event(0x20, 0, 0, 0) # Press SPACE to pause flight sim
            win32api.keybd_event(0x20, 0, win32con.KEYEVENTF_KEYUP, 0)
        elif (~enCursor and sw == 1):
            enCursor = 1
            (cx, cy) = win32api.GetCursorPos()
            win32api.mouse_event(win32con.MOUSEEVENTF_LEFTDOWN, int(x), int(y), 0, 0) # Left Click the Mouse Button
            win32api.mouse_event(win32con.MOUSEEVENTF_LEFTUP, int(x), int(y), 0, 0)
        if (enCursor):
            win32api.SetCursorPos((int(x), int(y)))

        if (throttle > 0):
            print("Throttle")
            win32api.keybd_event(0x21, 0, 0, 0) # Press Page Up to throttle
        elif (brake > 0):
            print("Brake")
            win32api.keybd_event(0x22, 0, 0, 0) # Press Page Down to brake
        else:
            win32api.keybd_event(0x21, 0, win32con.KEYEVENTF_KEYUP, 0)
            win32api.keybd_event(0x22, 0, win32con.KEYEVENTF_KEYUP, 0)

        if (analog > 100):
            analogState = 1
        elif (analogState == 1):
            win32api.keybd_event(0x47, 0, 0, 0) # Press G key to bring up/down gears
            win32api.keybd_event(0x47, 0, win32con.KEYEVENTF_KEYUP, 0)
            analogState = 0
            

if __name__ == "__main__":
    sock.send('Hello ESP32'.encode())
    loop()