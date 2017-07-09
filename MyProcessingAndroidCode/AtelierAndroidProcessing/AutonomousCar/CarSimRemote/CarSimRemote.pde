  /* CarSimM
 * Autonomous Car Simulation and DEvt. platform
 * this verison implements various experiments in modal control, doesn't really work yet 2017 02 09...
 */
 
import oscP5.*;
import netP5.*;
import java.net.InetAddress;

import java.net.*;
import java.util.*;


final boolean ISJS   = false;

boolean  CURVY_TRACK = true;

defaults Defaults;
App app;

//we will use these variables to get the IP of the machine
InetAddress inet;
String myIP;

/* this will check if the user is done entering 
   the IP of the machine on their phone */
boolean check=false;

OscP5 oscP5;


public InetAddress getCurrentIp() {
  try {
    Enumeration<NetworkInterface> networkInterfaces = NetworkInterface
            .getNetworkInterfaces();
    while (networkInterfaces.hasMoreElements()) {
      NetworkInterface ni = (NetworkInterface) networkInterfaces
              .nextElement();
      Enumeration<InetAddress> nias = ni.getInetAddresses();
      while(nias.hasMoreElements()) {
        InetAddress ia= (InetAddress) nias.nextElement();
        if (!ia.isLinkLocalAddress() 
         && !ia.isLoopbackAddress()
         && ia instanceof Inet4Address) {
            return ia;
        }
      }
    }
  } 
  catch (SocketException e) {
    println("unable to get current IP " + e.getMessage(), e);
  }
  return null;
}


void setup(){
  size(1800,900);
  frameRate(50);  // nb steps per second
  Defaults = new defaults();
  app = new App();
  oscP5 = new OscP5(this,32000);
}

void draw(){
  if (check==false){
      try {
        myIP = split(getCurrentIp().toString(),'/')[1];
      }
      catch (Exception e) {
        e.printStackTrace();
        myIP = "couldnt get IP"; 
      }
      textSize(25);
      text("Please enter this IP address on your phone: \n"+myIP, width/2, height/2);
      textSize(15);
      text("Once you're done, press any key or click anywhere on the window", width/2, height/2+80);
  }
  else {
    app.display();
  }
}

void oscEvent(OscMessage theOscMessage) {

  /* get and print the address pattern and the typetag of the received OscMessage */
  //these are just for checking reasons

  println("### received an osc message with addrpattern "+theOscMessage.addrPattern()+" and typetag "+theOscMessage.typetag());
  theOscMessage.print();
  
  /*
  here I am receiving the sensor and gesture values from the android app
  the values are stored in an array, the osc message, and each location of the array contains a value
  the locations are determined in the android application
  */
  
  float angle=theOscMessage.get(0).floatValue(),
        speed=theOscMessage.get(1).floatValue();
  app.car.steeringAngleSet(-angle);
  app.car.velocitySet(speed);
  }

void mousePressed(){
  check=true;
  CURVY_TRACK = ! CURVY_TRACK;
  Defaults  = new defaults();
  app = new App();
}

//////  key controls /////////

void keyPressed(){
  if (key == CODED){
    codedKey();
  }
  else{
    unCodedKey();
  }
}

void unCodedKey(){
  switch(key){
    case 'c':
    case 'C':
      app.sInc+=radians(1.0);
      break;
    case 'm':
    case 'M':
      app.manualSteering = !app.manualSteering;
      break;
    case 'p':
    case 'P':
      app.car.velocitySet(0);
      break;
    case 'r':
    case 'R':
      app.reset();
      break;
    case 's':
    case 'S':
      app.car.steeringAngleSet(0);
      app.car.steeringAngularVelocitySet(0);
      break;
    case 'x':
    case 'X':
      app.sInc-= radians(1.0);
      break;
    default:
      if (!ISJS){
        exit();
      }
      break;
  }
}

void codedKey(){
  switch(keyCode){
    case UP:
      app.car.velocityInc(app.vInc);
      break;
    case DOWN:
      app.car.velocityInc(-app.vInc);
      break;
    case LEFT:
        app.car.steeringAngleInc(-app.sInc);
      break;
    case RIGHT:
      app.car.steeringAngleInc(app.sInc);
      break;
  }
}