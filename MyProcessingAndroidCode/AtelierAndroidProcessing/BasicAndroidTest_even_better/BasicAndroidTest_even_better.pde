/* BasicAndroidTest_even_better
 * good points:
 ** structured code allows for understanding at different levels, no need to read all the code
 ** magic numbers replaced by constant meaningful names
 ** callbacks just set flags
 * bad points:
 ** use of even more global variables...
 */

final color black = color(0,0,0),
            gray  = color(128,128,128);

boolean rectL = false,
        rectR = false;

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
  rectRL();
}

void setDrawingAttributes(){
  noStroke();
  fill(black);
}

void rectRL(){
  if (rectL){
    rect(0, 0, width/2, height);
  }
  if (rectR){
    rect(width/2, 0, width/2, height);
  }
}

void mousePressed() {
  if (mouseX < width/2) {
    rectL = true;  // Left
  } 
  else {
    rectR = true;  // Right
  }
}
void mouseReleased(){
  rectL = rectR = false;
}