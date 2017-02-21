/* runs SOMETIMES on nexus 4(?) but crashes alot
 * but ketai.jar must be added to the data directory!
 * and never forget fullScreen() in setup!  
 */

import ketai.sensors.*;

KetaiLocation location;
double longitude, latitude, altitude;
float accuracy;

public void settings(){
  fullScreen();
  orientation(LANDSCAPE);  /// seems to cause crashes?
}
void setup() {
  textAlign(CENTER, CENTER);
  textSize(50);
  location = new KetaiLocation(this);
}
void draw() {
  background(78, 93, 75);
  if (location.getProvider() == "none")
    text("Location data is unavailable. \n" +
    "Please check your location settings.", width/2, height/2);
  else
    text( "Latitude: " + latitude + "\n" +
          "Longitude: " + longitude + "\n" +
          "Altitude: " + altitude + "\n" + " m" +
          "Accuracy: " + accuracy + "\n" + " m" +
          "Provider: " + location.getProvider(), width/2, height/2);
}
void onLocationEvent(double _latitude, double _longitude, double _altitude, float _accuracy) {
  longitude = _longitude;
  latitude = _latitude;
  altitude = _altitude;
  accuracy = _accuracy;
  println("lat/lon/alt/acc: " + latitude + "/" + longitude + "/"  + altitude + "/" + accuracy);
}