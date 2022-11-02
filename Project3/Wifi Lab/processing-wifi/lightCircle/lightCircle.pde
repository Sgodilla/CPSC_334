import hypermedia.net.*;
int PORT_RX=4210;
String HOST_IP = "172.29.26.79";//IP Address of the PC in which this App is running
UDP udp;//Create UDP object for receiving

void setup(){
  udp= new UDP(this, PORT_RX, HOST_IP);
  udp.log(true);
  udp.listen(true);
  noLoop();
}

void draw(){
 
} 

void receive(byte[] data, String HOST_IP, int PORT_RX){
 
  String value=new String(data);
  println(value);
    
}
