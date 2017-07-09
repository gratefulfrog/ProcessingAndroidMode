class DebugTracer{
  boolean prevMousePressed = false;
  int countR = 0,
      countP = 0;    
  
  public void showMousePressed(){
    if(mousePressed != prevMousePressed){
      println("mouse pressed: " + str(mousePressed));
      prevMousePressed = mousePressed;
    }
  }
  
  void showPressCount(){
    println("press: " + str(countP++));
  }
  void showReleaseCount(){
    println("release: " + str(countR++));
  }
}