/* Wifi shared whiteboard 
 * same code for PC and Android
 * just change the remoteAddress variable as appropriate
 * works PERFECTLY !!!
 */


import netP5.*;
import oscP5.*;  

OscP5 oscP5;
NetAddress remoteLocation;
int x, y, px, py;

String remoteAddress = "192.168.1.2";

public void settings(){
  fullScreen();
  orientation(PORTRAIT); //LANDSCAPE);
}

void setup() {
  oscP5 = new OscP5(this, 12000);
  remoteLocation = new NetAddress(remoteAddress, 12000);
  background(78, 93, 75);
}

void draw() {
  stroke(0);
  float remoteSpeed = dist(px, py, x, y);
  if (remoteSpeed < 100) 
    strokeWeight(remoteSpeed);
  line(px, py, x, y);
  px = x;
  py = y;
  if (mousePressed) {
    stroke(255);
    float speed = dist(pmouseX, pmouseY, mouseX, mouseY);
    strokeWeight(speed);
    if (speed < 100) 
      line(pmouseX, pmouseY, mouseX, mouseY);
    OscMessage myMessage = new OscMessage("AndroidData");
    myMessage.add(mouseX);
    myMessage.add(mouseY);
    oscP5.send(myMessage, remoteLocation);
  }
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("ii")){
    x = theOscMessage.get(0).intValue();
    y = theOscMessage.get(1).intValue();
  }
}