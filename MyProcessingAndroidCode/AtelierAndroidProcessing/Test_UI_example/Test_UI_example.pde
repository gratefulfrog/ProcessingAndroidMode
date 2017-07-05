// Ketai stuff
import ketai.ui.*;
KetaiList selectionlist;
KetaiVibrate vibe;

// a java hash table for elegance!
import java.util.HashMap;
HashMap<String, Integer> cMap = new HashMap<String,Integer>();

// a vector of color instances 
final color cVec[] = {color(255,0,0),
                      color(0,255,0),
                      color(0,0,255),
                      color (128,128,128),
                      color (0,0,0)};

// vector of color names
final String cNameVec[] = {"Red","Green","Blue","Gray","Black"};

// variable will be modified in the code     
color backgroundColor;

// used to show vibration if device cannot do it...
int vibrateStart  = 0;
final int vibTime = 1000;
boolean vibrating = false;

public void settings(){
  fullScreen();
  orientation(LANDSCAPE);
}

void setup(){
  textSize(28);
  textAlign(CENTER);
  vibe = new KetaiVibrate(this);
  initColors();
}

// init the color hash table and the backgroun color
void initColors(){
  for (int i=0;i<cNameVec.length; i++){
    cMap.put(cNameVec[i],cVec[i]);    
  }
  backgroundColor = cMap.get("Black");
}

void draw(){
  background(backgroundColor);
  drawUI();
  text(getScreenText(), width/2, height/2);
  checkVib();
}

void drawUI(){
  pushStyle();
  textAlign(CENTER);
  fill(backgroundColor);
  stroke(255);
  rect(0, 0, width/3, 100);
  rect(width/3, 0, width/3, 100);
  rect((width/3)*2, 0, width/3, 100);

  fill(255);
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
    selectionlist = new KetaiList(this, cNameVec);
  }
  // otherwise do the rectangle action
  else {
    if (mouseX < width/3) {
      KetaiKeyboard.toggle(this);
    }
    else if (mouseX > 2*width/3){
      vibrating = true;
      vibrateStart = millis();
      vibe.vibrate(vibTime);
    }
    else{
       KetaiAlertDialog.popup(this, "Pop Up!", "this is a popup message box");
    }
  }
}

// only called if a selecton is made, i.e. not cancelled
void onKetaiListSelection(KetaiList klist){
  backgroundColor = cMap.get(klist.getSelection());
}

// called on keyboard key press
void keyPressed() {  
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
  KetaiAlertDialog.popup(this, 
                        "Key Pressed!", 
                        "You pressed the <" + msg  + "> key!"); 
}