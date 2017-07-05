/* BasicAndroidTest_better
 * good points:
 ** structured code allows for understanding at different levels, no need to read all the code
 ** magic numbers replaced by meaningful names
 * bad points:
 ** mixture of detection of mouse and action in same "callback" code
 ** use of global variables...
 */
 
color black = color(0,0,0),
      gray  = color(128,128,128);

void settings(){
  fullScreen();
  //orientation(LANDSCAPE);
  //orientation(PORTRAIT);
}

void setup() {
  setDrawingAttributes();
}
  
void draw() {
  background(gray);
  rectUnderMouse();
}

void setDrawingAttributes(){
  noStroke();
  fill(black);
}

void rectUnderMouse(){
  if (mousePressed) {
    if (mouseX < width/2) {
      rect(0, 0, width/2, height); // Left
    } else {
      rect(width/2, 0, width/2, height); // Right
    }
  }
}