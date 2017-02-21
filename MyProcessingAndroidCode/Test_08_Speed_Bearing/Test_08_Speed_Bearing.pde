/* runs SOMETIMES on nexus 4?  orientation(LANDSCAPE) seems to cause a problem wih fullScreen
 * but ketai.jar must be added to the data directory!
 * and never forget fullScreen() in setup!  
 */

import ketai.sensors.*;

KetaiLocation location;
float speed,bearing;

public void settings(){
  fullScreen();
  orientation(LANDSCAPE);  
}

void setup() {
  textAlign(CENTER, CENTER);
  textSize(50);
  location = new KetaiLocation(this);
}

void draw() {
  background(78, 93, 75);
  if (location.getProvider() == "none"){
    text("Location data is unavailable. \n" + "Please check your location settings.", 0,0, width, height);
  }
  else  {
    text("Provider: " + location.getProvider() + "\n" +
    "Travel speed: "+ speed + " m/s\n" + "Bearing: "+ bearing + "°", 0, 0, width, height);
  }
}
void onLocationEvent(Location _location) {
    println("onLocation event: " + _location.toString());
    speed = _location.getSpeed();
    bearing = _location.getBearing();
}