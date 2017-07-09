class App {
  // flags are now encapuslated in the App class as 
  // instance variables
  boolean rectL,
          rectR;
  
  DebugTracer dbt = null;
  
  // constructor takes care of setting things up
  App(boolean deb){
    if (deb){
      dbt = new DebugTracer();
    }
    clearRects();
    setDrawingAttributes();
  }
  
  // this is where the work is done
  void display() {
    background(gray);
    rectRL();
    if (dbt != null){
      dbt.showMousePressed();
    }
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
    if (dbt != null){
      dbt.showPressCount();
    }
    if (mouseX < width/2) {
      rectL = true;  // Left
    } 
    else {
      rectR = true;  // Right
    }
  }
  // mouse released callback, clears flags
  public void mouseReleased(){
    if (dbt != null){
      dbt.showReleaseCount();
    }
    clearRects();
  }
}