/* runs on emulator and nexus 4
 */

import ketai.ui.*;
import android.view.MotionEvent;

KetaiGesture gesture;
float rectSize = 100;
float rectAngle = 0;
int x, y;
color c = color(255);
color bg = color(78, 93, 75);

void setup(){
  fullScreen();
  orientation(LANDSCAPE);
  gesture = new KetaiGesture(this);
  textSize(32);
  textAlign(CENTER, BOTTOM);
  rectMode(CENTER);
  noStroke();
  x = width/2;
  y = height/2;
}

void draw(){
  background(bg);
  pushMatrix();
  translate(x, y);
  rotate(rectAngle);
  fill(c);
  rect(0, 0, rectSize, rectSize);
  popMatrix();
}

public boolean surfaceTouchEvent(MotionEvent event) {
  //call to keep mouseX and mouseY constants updated
  super.surfaceTouchEvent(event);
  //forward events
  return gesture.surfaceTouchEvent(event);
}

void onTap(float x, float y){
  text("SINGLE", x, y-10);
  println("SINGLE:" + x + "," + y);
}

void onDoubleTap(float x, float y){
  text("DOUBLE", x, y-10);
  println("DOUBLE:" + x + "," + y);
  
  if (rectSize > 100)
    rectSize = 100;
  else
    rectSize = height - 100;
}

void onLongPress(float x, float y){
  text("LONG", x, y-10);
  println("LONG:" + x + "," + y);
  c = color(random(255), random(255), random(255));
}

void onFlick( float x, float y, float px, float py, float v){
  text("FLICK", x, y-10);
  println("FLICK:" + x + "," + y + "," + v);
  bg = color(random(255), random(255), random(255));
}


void onPinch(float x, float y, float d){
  rectSize = constrain(rectSize+d, 10, height);
  println("PINCH:" + x + "," + y + "," + d);
}

void onRotate(float x, float y, float angle){
  rectAngle += angle;
  println("ROTATE:" + angle);
}

void mouseDragged(){
  if (abs(mouseX - x) < rectSize/2 && abs(mouseY - y) < rectSize/2){
    if (abs(mouseX - pmouseX) < rectSize/2)
      x += mouseX - pmouseX;
    if (abs(mouseY - pmouseY) < rectSize/2)
      y += mouseY - pmouseY;
  }
}