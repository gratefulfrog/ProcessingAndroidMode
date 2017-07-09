class defaults{
  final int maxSteeringSensitivity = 8,
            stdSteeringSensitivity = 5;                    
  
  
  final color red   = #FF0000,
              green = #00FF00,
              blue  = #0000FF,
              grey  = #A7A7A7,
              black = #000000,
              white = #FFFFFF,
              targetColor = red,
              wheelColor = blue;

  float mm2pix,
        trackWhiteWidth,
        trackBlackWidth,
       
        wheelWidth,
        wheelHeight,
        carWidth,
        carHieght,
        axelWidth,
        sensorHalfWidth,
        sensorInterceptHalfLength,
        
        trackerMiddleEpsilon,
 
        trackAvailableDrivingWidth,
        
        trackStraightLengthMM,
        trackStraightLength,
        trackOuterDiameterMM,
        trackOuterDiameter,
        totalWidth,
        
        Jumplength,
        
        JumpSpeed;
        
        int sensorInterceptLimit;
                       
  defaults(){
    mm2pix = CURVY_TRACK ? 0.35 :0.50;  // depends on the size of the track!
  
    trackWhiteWidth =  20 * mm2pix;
    trackBlackWidth =  240 * mm2pix;
                      
    wheelWidth = 10 * mm2pix;
    wheelHeight = 20  * mm2pix;
    carWidth  = 100  * mm2pix;
    carHieght =  160  * mm2pix;
    axelWidth = carWidth -  wheelWidth;
    sensorHalfWidth = 1.5 * (trackBlackWidth + 2*trackWhiteWidth);
    sensorInterceptHalfLength = carWidth/4.0;
    
    trackerMiddleEpsilon = 25 * mm2pix;
    
    Jumplength = 450 * mm2pix;
    JumpSpeed = 800;

    totalWidth = trackWhiteWidth * 2 + trackBlackWidth;
    trackAvailableDrivingWidth = trackBlackWidth - carWidth;

    sensorInterceptLimit = round(sensorHalfWidth);
  
    trackStraightLengthMM = 1500;
    trackStraightLength   = trackStraightLengthMM * mm2pix;
    trackOuterDiameterMM  = 1400;
    trackOuterDiameter    = trackOuterDiameterMM * mm2pix;
  }         
}