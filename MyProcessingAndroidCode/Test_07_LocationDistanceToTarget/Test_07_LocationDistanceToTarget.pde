/* runs SOMETIMES on nexus 4?  orientation(LANDSCAPE) seems to cause a problem wih fullScreen
 * but ketai.jar must be added to the data directory!
 * and never forget fullScreen() in setup!  
 */

import ketai.sensors.*;

KetaiLocation location;
double longitude, latitude, altitude;
float accuracy;
Location target;

public void settings(){
  fullScreen();
  orientation(LANDSCAPE);  
}

void setup() {
  textAlign(CENTER, CENTER);
  textSize(50);
  location = new KetaiLocation(this);
  target = new Location("target");
  target.setLatitude(50.841708);
  target.setLongitude(4.322397);
}

void draw() {
  background(78, 93, 75);
  if (location.getProvider() == "none"){
    text("Location data is unavailable. \n" + "Please check your location settings.", 0,0, width, height);
  }
  else  {
    float distance = round(location.getLocation().distanceTo(target));
    text("Location data:\n" +
    "Latitude: " + latitude + "°" + "\n" +
    "Longitude: " + longitude + "°" + "\n" +
    "Altitude: " + altitude  + " m" + "\n" +
    "Accuracy: " + accuracy  + " m" + "\n" +
    "Distance to FabLabXL: "+ nf(distance/1000.0,0,2) + " km\n" +
    "Provider: " + location.getProvider(), 20, 0, width, height);
  }
}
void onLocationEvent(Location _location) {
    println("onLocation event: " + _location.toString());
    longitude = _location.getLongitude();
    latitude = _location.getLatitude();
    altitude = _location.getAltitude();
    accuracy = _location.getAccuracy();
}