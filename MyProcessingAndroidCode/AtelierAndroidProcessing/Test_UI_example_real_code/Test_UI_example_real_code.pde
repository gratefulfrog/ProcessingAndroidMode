
App app;

public void settings(){
  fullScreen();
  orientation(LANDSCAPE);
}

void setup(){
  app = new App(this);
}

void draw(){
  app.display();
}
void mousePressed(){
  app.mousePressed();
}

// called on keyboard key press
void keyPressed() {  
  app.keyPressed(key);
}

// only called if a selecton is made, i.e. not cancelled
void onKetaiListSelection(KetaiList klist){
    app.onSelection(klist.getSelection());
  }