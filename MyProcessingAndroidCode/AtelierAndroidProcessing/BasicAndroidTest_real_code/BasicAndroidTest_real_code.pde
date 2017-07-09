/* BasicAndroidTest_real_code
 * good points:
 ** fully encapsulated and structured code allows for understanding at different levels, 
 ** setup and draw methods are clear and straightforward
 ** constants moved to separate file
 ** App class encapsulates all the work.
 * bad points:
 ** bigger executable
 ** requires understanding of Object Orientation
 */


// turn on or off debug tracing to console
final boolean DEBUG = true;

// the only global varaible is the instance of the App class
App app;

void settings(){
  fullScreen();
  //orientation(LANDSCAPE);
  //orientation(PORTRAIT);
}

void setup() {
  app =new App(DEBUG);
}
void draw() {
  app.display();
}
// mouse callbacks are delgated to the App instance
void mousePressed() {
  app.mousePressed();
}
void mouseReleased(){
  app.mouseReleased();
}