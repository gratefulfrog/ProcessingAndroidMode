// Ketai stuff
import ketai.ui.*;

// a java hash table for elegance!
import java.util.HashMap;

class App {
  KetaiList selectionlist;
  KetaiVibrate vibe;

  HashMap<String, Integer> cMap = new HashMap<String,Integer>();
  
  PApplet pa;
  
  // variable will be modified in the code     
  color backgroundColor;
  
  // used to show vibration if device cannot do it...
  int vibrateStart  = 0;
  boolean vibrating = false;
  
  App(PApplet paa){
    pa = paa;
    vibe = new KetaiVibrate(pa);
    initTextDisplay();
    initColors();
  }
  void initTextDisplay(){
    textSize(textS);
    textAlign(CENTER);
  }
  // init the color hash table and the backgroun color
  void initColors(){
    for (int i=0;i<cNameVec.length; i++){
      cMap.put(cNameVec[i],cVec[i]);    
    }
    backgroundColor = cMap.get("Black");
  }
  
  void display(){
    background(backgroundColor);
    drawUI();
    text(getScreenText(), width/2, height/2);
    checkVib();
  }
  
  void drawUI(){
    pushStyle();
    fill(backgroundColor);
    stroke(cMap.get("White"));
    rect(0, 0, width/3, 100);
    rect(width/3, 0, width/3, 100);
    rect((width/3)*2, 0, width/3, 100);
    
    fill(cMap.get("White"));
    text("Keyboard", width/6, 60); 
    text("PopUp", width/2, 60); 
    text("Vibrate", width*5/6, 60); 
    popStyle();
  }
  
  String getScreenText(){
    String res = "click screen to change background color";
    if (vibrating){
      res = "Vibrating...";
    }
    return res;
  }
  
  void checkVib(){
    vibrating =  millis() - vibrateStart < vibTime;
  }
  
  void mousePressed(){
    // a tap below the rectangles triggers the color selection
    if (mouseY > 100){
      selectionlist = new KetaiList(pa, cNameVec);
    }
    // otherwise do the rectangle action
    else {
      if (mouseX < width/3) {
        KetaiKeyboard.toggle(pa);
      }
      else if (mouseX > 2*width/3){
        doVibrate();
      }
      else{
         KetaiAlertDialog.popup(pa, "Pop Up!", "this is a popup message box");
      }
    }
  }
  
  void doVibrate(){
    vibrating = true;
    vibrateStart = millis();
    vibe.vibrate(vibTime);
  }
  
  // called on keyboard key press
  void keyPressed(char key) {  
    if (key == CODED)
      return;
    String msg = String.valueOf(key);
    switch(key){
      case ENTER:
      case RETURN:
        msg = "ENTER";
        break;
      case ' ':
        msg = "SPACE";
        break;
    }
    KetaiAlertDialog.popup(pa, 
                          "Key Pressed!", 
                          "You pressed the <" + msg  + "> key!"); 
  }
  
  void onSelection(String selection){
   backgroundColor =  app.cMap.get(selection);
  }
}