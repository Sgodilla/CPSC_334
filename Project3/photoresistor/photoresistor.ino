#include <WebServer.h>
#include <WiFi.h>
#include <WiFiUdp.h>

//set up to connect to an existing network (e.g. mobile hotspot from laptop that will run the python code)
const char* ssid = "TP-LINK_57F9";
const char* password = "07374173";
WiFiUDP Udp;
unsigned int localUdpPort = 4210;  //  port to listen on
char incomingPacket[255];  // buffer for incoming packets

const int lightPin = 32;
int lightVal = 0;

void setup() {
  // put your setup code here, to run once:
  int status = WL_IDLE_STATUS;
  Serial.begin(115200);
  pinMode(lightPin, INPUT);
  WiFi.mode(WIFI_MODE_STA);

  WiFi.begin(ssid, password);
  Serial.println("");

  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("Connected to wifi");
  Udp.begin(localUdpPort);
  Serial.printf("Now listening at IP %s, UDP port %d\n", WiFi.localIP().toString().c_str(), localUdpPort);

  // we recv one packet from the remote so we can know its IP and port
  bool readPacket = false;
  while (!readPacket) {
    int packetSize = Udp.parsePacket();
    if (packetSize)
     {
      // receive incoming UDP packets
      Serial.printf("Received %d bytes from %s, port %d\n", packetSize, Udp.remoteIP().toString().c_str(), Udp.remotePort());
      int len = Udp.read(incomingPacket, 255);
      if (len > 0)
      {
        incomingPacket[len] = 0;
      }
      Serial.printf("UDP packet contents: %s\n", incomingPacket);
      readPacket = true;
    } 
  }
}

void loop() {
  // put your main code here, to run repeatedly:
  lightVal = analogRead(lightPin);
  
  // once we know where we got the inital packet from, send data back to that IP address and port
  Udp.beginPacket(Udp.remoteIP(), Udp.remotePort());
  // Just test touch pin - Touch0 is T0 which is on GPIO 4.
  Udp.printf(lightPin);
  Udp.endPacket();
  delay(1000);
}
