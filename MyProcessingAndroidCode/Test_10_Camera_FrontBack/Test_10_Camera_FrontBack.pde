/* tested on Nexus 4
 * ypdated version of RAD v3
 */


import ketai.camera.*;

KetaiCamera cam;

public void settings(){
  fullScreen();
  orientation(LANDSCAPE);
}

void setup() {
  cam = new KetaiCamera(this, 1280,720,5); //740,480, 5);
  println(cam.list()); //(1)
  // 0: back camera; 1: front camera
  cam.setCameraID(1); //(2)
  imageMode(CENTER);
  stroke(255);
  textSize(48); //(3)
}

void draw() {
  image(cam, width/2, height/2, width, height);
  drawUI(); //(4)
}