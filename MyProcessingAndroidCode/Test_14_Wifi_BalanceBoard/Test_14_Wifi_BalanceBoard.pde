/* Wifi shared BalanceBoard 
 * same code for PC and Android
 * just change the remoteAddress variable as appropriate
 * works more or less, anyway, who care?
 */

import oscP5.*;
import netP5.*;
import ketai.sensors.*;

String remoteAddress = "192.168.1.3";
//String remoteAddress = "192.168.1.4";


OscP5 oscP5;
NetAddress remoteLocation;

KetaiSensor sensor;

PImage marble;

float x, 
      y, 
      remoteX, 
      remoteY,
      myAccelerometerX, 
      myAccelerometerY, 
      rAccelerometerX, 
      rAccelerometerY,
      speedX, 
      speedY = .01;

int targetX, 
    targetY, 
    remoteTargetX, 
    remoteTargetY,
    score, 
    remoteScore;

public void settings(){
  fullScreen();
  orientation(LANDSCAPE);
}
void setup() {
  sensor = new KetaiSensor(this);
  textAlign(CENTER, CENTER);
  textSize(72);
  initNetworkConnection();
  sensor.start();
  strokeWeight(5);  
  imageMode(CENTER);
  marble = loadImage("marble.png");
  init();
}

void draw() {
  background(78, 93, 75);
  // Targets
  fill (0);
  stroke(0, 60, 0);
  ellipse(targetX, targetY, 100, 100);
  stroke (60, 0, 0);
  ellipse(remoteTargetX, remoteTargetY, 100, 100);
  noStroke();
  fill(255);
  text(score, targetX, targetY);
  text(remoteScore, remoteTargetX, remoteTargetY);
  // Remote Marble
  tint(120, 0, 0);  //(2)
  image(marble, remoteX, remoteY);  //(3)
  // Local Marble
  speedX += (myAccelerometerX + rAccelerometerX) * 0.1;  //(4)
  speedY += (myAccelerometerY + rAccelerometerY) * 0.1;

  if (x <= 25+speedX || x > width-25+speedX) {
    speedX *= -0.8;  //(5)
  }
  if (y <= 25-speedY || y > height-25-speedY) {
    speedY *= -0.8;
  }
  x -= speedX;  //(6)
  y += speedY;
  tint(0, 120, 0);
  image(marble, x, y);
  // Collision 
  if (dist(x, y, targetX, targetY) < 25) {
    score++;
    background(60, 0, 0);
    init();
  }

  OscMessage myMessage = new OscMessage("remoteData");   //(7)
  myMessage.add(x);
  myMessage.add(y);
  myMessage.add(myAccelerometerX);
  myMessage.add(myAccelerometerY);
  myMessage.add(targetX);
  myMessage.add(targetY);
  myMessage.add(score);
  oscP5.send(myMessage, remoteLocation);
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("ffffiii"))  //(8)
  {
    remoteX = theOscMessage.get(0).floatValue(); 
    remoteY = theOscMessage.get(1).floatValue();
    rAccelerometerX = theOscMessage.get(2).floatValue();
    rAccelerometerY = theOscMessage.get(3).floatValue();
    remoteTargetX = theOscMessage.get(4).intValue();
    remoteTargetY = theOscMessage.get(5).intValue();
    remoteScore = theOscMessage.get(6).intValue();
  }
}

void onAccelerometerEvent(float _x, float _y, float _z)
{
  myAccelerometerX = -_y;
  myAccelerometerY = _x;
}

void initNetworkConnection()
{
  oscP5 = new OscP5(this, 12000);
  remoteLocation = new NetAddress(remoteAddress, 12000);
}
void init() {  //(9)
  x = int(random(25, width-25));
  y = int(random(25, height-25));
  targetX = int(random(25, width-25));
  targetY = int(random(25, height-25));
}