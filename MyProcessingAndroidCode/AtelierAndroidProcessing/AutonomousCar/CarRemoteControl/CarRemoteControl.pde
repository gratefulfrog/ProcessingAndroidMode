import oscP5.*;
import netP5.*;

import android.view.MotionEvent;
import ketai.ui.*;

////////////////// Comms stuff ///////////////////////
KetaiGesture gesture;

boolean check=false;
OscP5 oscP5;
NetAddress myRemoteLocation;
String pcIP="";
////////////////// end of comms stuff ///////////////////////

final float displayFactor = 0.5,
            nexusWidth = 768,
            nexusHeight = 1280;
            
final int screenW = round(nexusWidth*displayFactor),
          screenH = round(nexusHeight*displayFactor);

final color black = #000000,
            white = #FFFFFF,
            red   = #FF0000,
            green = #00FF00,
            blue  = #0000FF;
            
final int screenTextSize = 36,
          androidTextSize = 72;

void settings(){
  fullScreen();
  orientation(PORTRAIT);
}

AngleControl ac;
SpeedControl sc ;

void setup(){
  gesture = new KetaiGesture(this);

  ac = new AngleControl(30,width/2.0,height/2.0);
  ac.currentAngle = radians(0);
  sc =  new SpeedControl(1000,width,height/2.0);
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);

  textSize(androidTextSize);
 
  myRemoteLocation = new NetAddress("null", 32000);
  KetaiAlertDialog.popup(this, "No IP", "Please enter the IP of the target PC");
}

void draw(){
  background(black);
  if (check==false){
    pushMatrix();
    pushStyle();
    textAlign(CENTER);
    textSize(androidTextSize/2);
    translate(width/2.0,height/4.0);
    text("Enter IP:\n" + pcIP,0,0); // width/5, height/5);   
    //text(pcIP, width/5, height/5+50);
    popStyle();
    popMatrix();
  } 
  else{ 
    ac.display();
    sc.display();
  }
}
  
void   doOsc(){
  OscMessage outgoing = new OscMessage("/controls");
  outgoing.add(ac.currentAngle);
  outgoing.add(sc.currentSpeed);
  oscP5.send(outgoing, myRemoteLocation);
}

void mousePressed(){
  if (!check){
    KetaiKeyboard.toggle(this);
    return;
  }
  if (mouseY > ac.y){
    scMouse();
  }
  else{
    ac.update(mouseX,mouseY);
  }
  doOsc();
}

void mouseDragged(){
  if(!check){
    return;
  }
  if (mouseY > ac.y){
    scMouse();
  }
  else{
    ac.update(mouseX,mouseY);
  }
  doOsc();
}
void scMouse(){
  sc.update(mouseX<= width/2.0 ? 1 :  -1);
}

void keyPressed(){
  if (key==RETURN || key==ENTER){
    myRemoteLocation = new NetAddress(pcIP, 32000);
    check=true;
    textSize(androidTextSize);
    KetaiKeyboard.toggle(this);
    println("Remote Location set: " + pcIP +":32000");
  }
  else {
    pcIP+=key;
    println(pcIP);
  }
}

public boolean surfaceTouchEvent(MotionEvent event) {
  //call to keep mouseX, mouseY, etc updated
  super.surfaceTouchEvent(event);

  //forward event to class for processing
  return gesture.surfaceTouchEvent(event);
}