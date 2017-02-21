import ketai.camera.*;
KetaiCamera cam;


public void settings(){
  fullScreen();
  orientation(LANDSCAPE);
}

void setup() {
  cam = new KetaiCamera(this, 1280,720, 30);
  imageMode(CENTER);
}
void draw() {
  if (cam.isStarted())
  image(cam, width/2, height/2);
}
void onCameraPreviewEvent() {
  cam.read();
}
void mousePressed() {
  if (cam.isStarted()){
    cam.stop();
  }
  else
    cam.start();
}