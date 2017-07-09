
class Wheel{
  final float w = Defaults.wheelWidth,
              h = Defaults.wheelHeight,
              pos[] = {0,0};
              
  Wheel(float x, float y){
    pos[0] = x;
    pos[1] = y;
  }
  
  void display(){
    pushStyle();
    stroke(Defaults.wheelColor);
    fill(Defaults.wheelColor);
    rectMode(CENTER);
    rect(pos[0],pos[1],w,h);
    popStyle();
  }
}

class Axel{
  final float w = Defaults.axelWidth,
              wt = 4,
              pos[] = {0,0};
              
  Axel(float x, float y){
    pos[0] = x-w/2.0;
    pos[1] = y;
  }
  
  void display(){
    pushStyle();
    stroke(Defaults.wheelColor);
    strokeWeight(wt);
    fill(Defaults.wheelColor);
    line(pos[0],pos[1],pos[0]+w,pos[1]);
    popStyle();
  }
}

class DriveAxel{
  Wheel wl, wr;
  Axel a;
  
  DriveAxel(float x, float y){
    // x,y are center of horizontal axel
    a = new Axel(x,y);
    wl = new Wheel(a.pos[0],y);
    wr = new Wheel(a.pos[0] + a.w,y);
  }
  
  void display(){
    wl.display();
    a.display();
    wr.display();
  }   
}   
  
     
class Car{
  DriveAxel fa, ra;
  PShape s;
    
  final float len = Defaults.carHieght,
              wid = Defaults.carWidth,
              dyFrontAxel = -0.255 * len,
              dyRearAxel = (13.25/15.0)* len + dyFrontAxel,
              dxCenterLine = -0.5 * wid,
              B = dyRearAxel,
              maxSteeringAngle = radians(30),  
              maxVelocity =  1000;  //mm par second
              
  float     maxSteeringAngularVelocity = radians(150);  // radians par dt
  
  float heading = 0,
        velocity = 0,
        pos[] = {0,0},
        steeringAngle = 0,
        steeringAngularVelocity = 0;

  final color carColor = Defaults.red;
  
  float distanceFrontToWhite,
        headingDifferenceWithTrack,
        distanceMiddle2White;
  
  boolean inMiddle = false;
        
  final int nbSensors = 2;
  int li[] = new int[nbSensors],
      ri[] = new int[nbSensors];
        
  int jumpStatus = -1;
  
  float intoJumpVelocity,
        jumpInitX,
        jumpInitY;
  boolean jumping = false;
  
  Car(float x, float y, float theta, float distMiddleToWhite){
    pos[0] = x;
    pos[1] = y;
    heading = theta;
    distanceMiddle2White = distMiddleToWhite;
    
    fa = new DriveAxel(0,0);
    ra = new DriveAxel(0,B);
    if (ISJS){
      s = loadShape("CarSimA/data/CarBodyLongerFilled.svg");
    }
    else{
      s = loadShape("CarBodyLongerFilled.svg");
    }
  }
  
  void steeringAngleSet(float a){
    steeringAngle = max(-maxSteeringAngle,min(a,maxSteeringAngle));
  }
  void steeringAngleInc(float inc){
    steeringAngleSet(inc+steeringAngle);
  }
  void steeringAngularVelocitySet(float a){
    steeringAngularVelocity = max(-maxSteeringAngularVelocity,min(a,maxSteeringAngularVelocity));
  }
  void steeringAngularVelocityInc(float inc){
    steeringAngularVelocitySet(inc+steeringAngularVelocity);
  }
  void velocitySet(float a){
    velocity = a; //max(-maxVelocity,min(a,maxVelocity));
  }
  void velocityInc(float inc){
    velocitySet(inc+velocity);
  }
  
  void update(float dt){
    
    // update steering angle
    steeringAngleInc(steeringAngularVelocity*dt);
    final float R = B/abs(sin(steeringAngle)),
                dc = velocity * dt,
                dx = dc * sin(steeringAngle+heading),
                dy = -dc * cos(steeringAngle+heading),
                dTheta = dc/R;
    heading += dTheta*(steeringAngle == 0 ? 1 :steeringAngle/abs(steeringAngle));
    pos[0] += dx;
    pos[1] += dy; 
  }
  void updateSteeringAndVelocity(){
   if(jumpStatus ==0){  // accelleration!!
      intoJumpVelocity = jumping ? intoJumpVelocity : velocity;
      velocitySet(Defaults.JumpSpeed);
      jumping = true;
    }
    if (jumpStatus == 2){  // the eagle has landed, go back to normal speed!
      velocitySet(intoJumpVelocity);
      jumping = false;
    }
    if(jumpStatus==1){  // POP! we are airborne!
      steeringAngularVelocitySet(0);
      steeringAngleSet(0);
      // no steering during the air time!
      return;
    }
    // if inMiddle, turn the steering to the opposite of the angular differnce,
    // else turn the wheels to min( 90-angleDiff/2.0 constrained of course to physical limits
    //float signOfAngle =  distanceFrontToWhite>distanceMiddle2White ? -1.0 : 1.0;
    if (inMiddle){
      //println("In Middle, heading diff", degrees(headingDifferenceWithTrack));
      steeringAngleSet(headingDifferenceWithTrack);
    }
    else{
      //println("Not in Middle, heading diff", degrees(signOfAngle*(-HALF_PI+(headingDifferenceWithTrack)/2.0)));
      steeringAngleSet((distanceFrontToWhite>distanceMiddle2White ? -1.0 : 1.0)*(-HALF_PI+(headingDifferenceWithTrack)/2.0));
    }  
  }

  void display(){
    detectJump();
    
    pushStyle();
    pushMatrix();
    translate(pos[0],pos[1]);
    rotate(heading);
    shapeMode(CENTER);
    if (jumpStatus != 1){
      displaySensor(0);
      displaySensor(1);
    }
    shape(s, 0,-dyFrontAxel,wid,len);
    pushMatrix();
    rotate(steeringAngle);
    fa.display();
    popMatrix();
    ra.display();
    popMatrix();
    popStyle();
  }

  void displaySensor(int  id){
    float y = id *B;
    pushStyle();
    strokeWeight(2);
    stroke(Defaults.targetColor);
    displaySensorIntercepts(id);
    line(-Defaults.sensorHalfWidth,y,Defaults.sensorHalfWidth,y);
    popStyle();
  }

  void displaySensorIntercepts(int id){
    float ang = heading-HALF_PI;
    float yOffset = id * B;
    float pX = pos[0] - yOffset*cos(ang),
          pY = pos[1] - yOffset*sin(ang);
    li[id] = -Defaults.sensorInterceptLimit;
    ri[id] = Defaults.sensorInterceptLimit;
    
    for (int i = 0;i<Defaults.sensorInterceptLimit; i++){
      int x = round(pX - i*sin(ang)),
          y = round(pY + i*cos(ang));
      color c = get(x,y);      
      //if(c != color(0)){
      if(c == color(255)){
          ri[id] = i;
        break;
      }
    }
    for (int i = 0;i>-Defaults.sensorInterceptLimit; i--){
      int x = round(pX - i*sin(ang)),
          y = round(pY + i*cos(ang));
      color c = get(x,y);      
      //if(c != color(0)){
      if(c == color(255)){
        li[id] = i;
        break;
      } 
    }
    pushStyle();
    stroke(Defaults.green);
    strokeWeight(4);
    line(li[id],yOffset-Defaults.sensorInterceptHalfLength,li[id],yOffset+Defaults.sensorInterceptHalfLength);
    line(ri[id],yOffset-Defaults.sensorInterceptHalfLength,ri[id],yOffset+Defaults.sensorInterceptHalfLength);
    popStyle();
    distanceFrontToWhite = ri[0];
    inMiddle = abs(distanceFrontToWhite-distanceMiddle2White) <= Defaults.trackerMiddleEpsilon;
    //println("ri[0], distanceMiddle2White, Defaults.trackerMiddleEpsilon", ri[0], distanceMiddle2White, Defaults.trackerMiddleEpsilon);
    headingDifferenceWithTrack = -atan2(ri[1]-ri[0],B);
  }  
    
  void detectJump(){
    color c = get(round(pos[0]),round(pos[1]));
    switch(jumpStatus){
      case -1:
        if (green(c) >180 && red(c) < 50 && blue(c)< 50){ //!=0){ //== Defaults.green){
          jumpStatus++;
          jumpInitX = pos[0];
          jumpInitY = pos[1];
        }
        break;
      case 0:
        float d = dist(pos[0],pos[1],jumpInitX,jumpInitY);
        if (d>Defaults.Jumplength){
          jumpStatus++;
        }
        break;
      case 1:
        d = dist(pos[0],pos[1],jumpInitX,jumpInitY);
        if (d>2.0*Defaults.Jumplength){
          jumpStatus++;
        }
        break;
      case 2:
        jumpStatus=-1;
        break;
    }
  }
    
  void displayParams(){
    int x = 10,
        nbLines = 11,
        y = height - nbLines *20,
        dy = 15;
        
    pushMatrix();
    pushStyle();
    fill(Defaults.blue);
    translate(x,y);
    showJumpStatus();
    translate(0,dy);
    text("FrameRate : \t" +round(frameRate),0,0);
    translate(0,dy);
    text("In Middle : \t" + inMiddle,0,0);
    translate(0,dy);
    text("Velocity : \t" + round(velocity),0,0);
    translate(0,dy);
    text("Heading : \t" + round(formatHeading(degrees(heading))),0,0);
    translate(0,dy);
    text("Position : \t" + round(pos[0]) + ", " + round(pos[1]),0,0);
    translate(0,dy);
    text("Steering Angle: \t" +  round(degrees(steeringAngle)),0,0);
    translate(0,dy);
    text("Steering power : \t" + round(degrees(app.sInc)),0,0);
    translate(0,dy);
    text("Click the window, then use the Arrow keys and",0,0);
    translate(0,dy);
    pushStyle();
    if (app.manualSteering){
      fill(Defaults.green);
    }
    text("'M' : toggle manual steering",0,0);
    popStyle();
    translate(0,dy);
    text("'P' : Pause",0,0);
    translate(0,dy);
    text("'R' : Reset",0,0);
    translate(0,dy);
    text("'S' : Steer Straight",0,0);
    translate(0,dy);
    text("'X/C' : dec/inc Steering Power",0,0);
    translate(0,dy);    
    text("Mouse Click to change tracks",0,0);
    popStyle();
    popMatrix();
  }

  void showJumpStatus(){
    switch(jumpStatus){
      case 0:
        text("Jump: Acceleration!",0,0);
        break;
      case 1:
        text("Jump: Pop!",0,0);
        break;
      case 2:
        text("Jump: Land!",0,0);
        break;
      default:
        text("No Jump",0,0);
        break;
    }
  }
}
  
  

float formatHeading(float h){
  float res = h %360;
  return res<0 ? 360 + res : res;
}