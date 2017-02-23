/* Wifi to pc from Nexus 4
 * works PERFECTLY !!!
 */


import netP5.*;
import oscP5.*;  
import ketai.net.*;
import ketai.sensors.*;
OscP5 oscP5;
KetaiSensor sensor;


NetAddress remoteLocation;
float myAccelerometerX, myAccelerometerY, myAccelerometerZ;
int x, y, p;
String myIPAddress;
String remoteAddress = "192.168.1.3";

public void settings(){
  fullScreen();
  orientation(PORTRAIT); //LANDSCAPE);
}

void setup() {
  sensor = new KetaiSensor(this);
  textAlign(CENTER, CENTER);
  textSize(36);
  initNetworkConnection();
  sensor.start();
}

void draw() {
  background(78, 93, 75);
  
  text( "Remote Mouse Info: \n" +
        "mouseX: " + x + "\n" +
        "mouseY: " + y + "\n" +
        "mousePressed: " + p + "\n\n" +
        "Local Accelerometer Data: \n" +
        "x: " + nfp(myAccelerometerX, 1, 3) + "\n" +
        "y: " + nfp(myAccelerometerY, 1, 3) + "\n" +
        "z: " + nfp(myAccelerometerZ, 1, 3) + "\n\n" +
        "Local IP Address: \n" + myIPAddress + "\n\n" +
        "Remote IP Address: \n" + remoteAddress, width/2, height/2);
  
  OscMessage myMessage = new OscMessage("accelerometerData");
  myMessage.add(myAccelerometerX);
  myMessage.add(myAccelerometerY);
  myMessage.add(myAccelerometerZ);
  oscP5.send(myMessage, remoteLocation);
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("iii")){
    x = theOscMessage.get(0).intValue();
    y = theOscMessage.get(1).intValue();
    p = theOscMessage.get(2).intValue();
  }
}

void onAccelerometerEvent(float x, float y, float z){
  myAccelerometerX = x;
  myAccelerometerY = y;
  myAccelerometerZ = z;
}
void initNetworkConnection(){
  oscP5 = new OscP5(this, 18000);
  remoteLocation = new NetAddress(remoteAddress, 18000);
  myIPAddress = KetaiNet.getIP();
}