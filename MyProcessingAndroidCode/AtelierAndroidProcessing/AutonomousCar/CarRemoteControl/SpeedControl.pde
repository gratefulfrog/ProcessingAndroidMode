class SpeedControl{
  final int inc = 10;
  
  float currentSpeed,
        maxSpeed,
        minSpeed,
        wide,
        high;
  
  SpeedControl(float maxS, float wid,float hig){
    currentSpeed =0;
    maxSpeed = maxS;
    minSpeed = -maxS;
    wide = wid;
    high = hig;
  }
  float setSpeed(float v){
    return currentSpeed = constrain(v,minSpeed,maxSpeed);
  }
  void display(){
    displayRects();
    displayText();
  }
  
  void displayRects(){
    float y = (height + high)/2.0,
          x1 = width/2.0 - wide/4.0,
          x2 = width/2.0 + wide/4.0;
    pushStyle();
    rectMode(CENTER);
    pushMatrix();
    translate(x1,y);
    fill(green);
    rect(0,0,wide/2.0,high);
    popMatrix();
    pushMatrix();
    translate(x2,y);
    fill(red);
    rect(0,0,wide/2.0,high);
    popMatrix();
    popStyle();
  }
  void displayText(){
     pushStyle();
     textAlign(CENTER,TOP);
     fill(blue);
     pushMatrix();
     translate(wide/2.0,high);
     text("Speed\n" + round(currentSpeed),0,0);
     translate(-wide/4.0,high/2.0);     
     text("+",0,0);
     translate(wide/2.0,0);
     text("-",0,0);
     popStyle();
     popMatrix();

}
  
  void update(int sign){
    setSpeed(currentSpeed + sign*inc);
  }
}
    
  