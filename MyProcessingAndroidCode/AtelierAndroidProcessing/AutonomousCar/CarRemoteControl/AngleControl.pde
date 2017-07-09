class AngleControl{
  float currentAngle, // radians
        maxAngle,
        minAngle,
        display2Angle,
        bigR,
        littleR,
        x,
        y;
   final float displayRangeDegrees = 120,
               chouillardFactor    = 0.2;
   
   // drawing parameters
   
   
   AngleControl(float maxA, float cx, float cy){ // symetric max angle in degrees 
     maxAngle     = radians(maxA);
     minAngle     = radians(-maxA);
     x = cx;
     y = cy;
     currentAngle = 0;
     bigR = width;
     littleR = bigR*(1-chouillardFactor);
     display2Angle = displayRangeDegrees/(2*maxA);
   }
   
   float setAngle(float angleRadians){
     return currentAngle = constrain(angleRadians,minAngle,maxAngle);
   }
   
   void display(){
     pushMatrix();
     translate(x,y);
     displayArc();
     displayIndicatorLine();
     displayAngleText();
     popMatrix();
   }
   void displayArc(){
     float arcCorrector= 5;
      
     pushStyle();
     ellipseMode(CENTER);
     pushMatrix();
     rotate(-radians(displayRangeDegrees/4.0));
     fill(red);
     arc(0,0,bigR,bigR,-radians(displayRangeDegrees),0);
     popMatrix();
     pushMatrix();
     rotate(-radians((displayRangeDegrees-(arcCorrector*2))/4.0));
     fill(black);
     arc(0,0,littleR,littleR,-radians(displayRangeDegrees+arcCorrector),0);
     popMatrix();
     popStyle();
   }
   
   void displayIndicatorLine(){
     pushStyle();
     fill(green);
     stroke(green);
     strokeWeight(20);
     pushMatrix();
     rotate(-(currentAngle/maxAngle)*(radians(displayRangeDegrees)/2.0));
     float len = -(bigR+littleR)/4.0;
     line(0,0,0,len);
     popMatrix();
     popStyle();
   }
   
   void displayAngleText(){
     int currentDegrees = round(degrees(currentAngle));
     pushStyle();
     fill(blue);
     textAlign(CENTER,BOTTOM);
     pushMatrix();
     translate(0,-(bigR+littleR)/4.0);
     text("Steering Angle\n" + currentDegrees,0,20);
     popStyle();
     popMatrix();
   }
   /*
   void update(float mx,float my){
     // compute new angle and set
     float angleDegrees = degrees(atan2(y-my,mx-x)) -90,
           result = constrain(angleDegrees,-displayRangeDegrees/2.0,displayRangeDegrees/2.0); //,-60,60,-displayRangeDegrees/2.0,displayRangeDegrees/2.0);
     println(angleDegrees, result, degrees(setAngle(radians(result/display2Angle))));
   }
   */
    void update(float mx,float my){
     // compute new angle and set
     float angle = (atan2(y-my,mx-x)) -(PI/2.0),
           result = constrain(angle,radians(-displayRangeDegrees/2.0),radians(displayRangeDegrees/2.0)); //,-60,60,-displayRangeDegrees/2.0,displayRangeDegrees/2.0);
     println(angle, result, setAngle(result/display2Angle));
   }
}
     