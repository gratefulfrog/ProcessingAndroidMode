class App {
  // flags are now encapuslated in the App class as 
  // instance variables
  boolean rectL,
          rectR;
  
  // constructor takes care of setting things up
  App(){
    clearRects();
    setDrawingAttributes();
  }
  
  // this is where the work is done
  void display() {
    background(gray);
    rectRL();
  }
  
  // set the drawing style parameters
  void setDrawingAttributes(){
    noStroke();
    fill(black);
  }
  // check the flags and create rects as needed
  void rectRL(){
    if (rectL){
      rect(0, 0, width/2, height);
    }
    if (rectR){
      rect(width/2, 0, width/2, height);
    }
  }
  // clear the flags
  void clearRects(){
    rectL = rectR = false;
  }
  // mouse pressed callback, sets flags
  public void mousePressed() {
    if (mouseX < width/2) {
      rectL = true;  // Left
    } 
    else {
      rectR = true;  // Right
    }
  }
  // mouse released callback, clears flags
  public void mouseReleased(){
    clearRects();
  }
}