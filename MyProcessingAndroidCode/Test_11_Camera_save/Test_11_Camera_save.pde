/* failed on Nexus 4
 * gave up on cameras here
 * seems to be an isseu with x,y width,height getting mixed up by Ketai?
 */


import ketai.camera.*;

KetaiCamera cam;

public void settings(){
  fullScreen();
  orientation(LANDSCAPE);
}

void setup() {
  cam = new KetaiCamera(this, 740,480, 5);
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
/*
void draw() {
  background(128);
  if (!cam.isStarted()){
    pushStyle();
    textAlign(CENTER, CENTER);
    String info = "CameraInfo:\n";
    info += "current camera: "+ cam.getCameraID()+"\n";
    info += "image dimensions: "+ cam.width +
    "x"+cam.height+"\n";
    info += "photo dimensions: "+ cam.getPhotoWidth() +
    "x"+cam.getPhotoHeight()+"\n";
    info += "flash state: "+ cam.isFlashEnabled()+"\n";
    text(info, width/2, height/2);
    popStyle();
  }
  else{
    image(cam, width/2, height/2, width, height);
  }
  drawUI();
}
*/