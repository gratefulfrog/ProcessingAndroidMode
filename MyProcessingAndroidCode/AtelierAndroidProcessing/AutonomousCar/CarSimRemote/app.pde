class App {
  float deltaT = 1/frameRate; //0.02;

  Car car;
  boolean manualSteering = true;

  float   x,
          y,
          w;
  float maxS = Defaults.maxSteeringSensitivity,
        sInc = radians(Defaults.stdSteeringSensitivity),
        saInc = radians(maxS*0.01);
 
  final float vInc = 10;
  
  final float trackXOffsetCurvy = 100,
              trackXOffsetOval   = 160,
              trackYOffsetCurvy = 30,
              trackYOffsetOval  = 300;
  
  App(){
    float xOffset,
          yOffset;
    
    if(CURVY_TRACK){
      xOffset = trackXOffsetCurvy;
      yOffset = trackYOffsetCurvy;
    }
    else{
      //Defaults.mm2pix = MM2PX_OVAL;
      xOffset = trackXOffsetOval;
      yOffset = trackYOffsetOval;
    }
    x = width/2.0 + Defaults.trackStraightLength/2.0 + xOffset;
    y = height/4.0 + yOffset;
    w = Defaults.trackOuterDiameter;

    doCurvyTrack(x,y,w);
    reset();
  }
  void display(){
    // first display the bg & track
    background(Defaults.grey);
    displayTrack();
    
    car.displayParams();   
    // now display the animate objects
    // this updates the car's sensors
    car.display();
    
    updateDeltaT();
    
    // now update the animate objects
    car.update(deltaT);
    if (manualSteering || (car.velocity == 0)){
      return;
    }
    car.updateSteeringAndVelocity();
  }
  

  void displayTrack(){
    if(CURVY_TRACK){
      //doImageCurvyTrack(g_track,x,y,w);
      doCurvyTrack(x,y,w);
    }
    else{
       doOvalTrack(x,y,w);
    }  
  }
  
  void updateDeltaT(){
    deltaT = 1/frameRate; 
  }
  
  void reset(){
    car = new Car(x-Defaults.trackStraightLength,y-w/2.0+(Defaults.trackBlackWidth + Defaults.trackWhiteWidth)/2.0,radians(90),Defaults.trackBlackWidth/2.0);   
  }
}