/* runs on emulator and nexus 4
 * but ketai.jar must be added to the data directory (for the emulator??)
 * and never forget fullScreen() in setup!  
 */

import ketai.sensors.*;

KetaiSensor sensor;
PVector magneticField, accelerometer, gyro, orient, gravity, linearAcceleration, rotationVector, gameRotation ;
float light, proximity, pressure;

int significantMotionTime = 0;

final int timeOut = 3000;

void setup(){
  fullScreen();
  sensor = new KetaiSensor(this);
  sensor.start();
  println(sensor.list());
  accelerometer = new PVector();
  magneticField = new PVector();
  gyro  = new PVector();
  orient = new PVector();
  gravity = new PVector();
  linearAcceleration  = new PVector();
  rotationVector = new PVector();
  gameRotation = new PVector();

  orientation(PORTRAIT);
  textAlign(CENTER, CENTER);
  textSize(28);
}

void draw()
{
  background(78, 93, 75);
  text("Accelerometer (m/s^2) :" + "\n" 
    + "x: " + nfp(accelerometer.x, 1, 2) + "\n" 
    + "y: " + nfp(accelerometer.y, 1, 2) + "\n" 
    + "z: " + nfp(accelerometer.z, 1, 2) + "\n"
    + "MagneticField (µT) :" + "\n" 
    + "x: " + nfp(magneticField.x, 1, 2) + "\n"
    + "y: " + nfp(magneticField.y, 1, 2) + "\n" 
    + "z: " + nfp(magneticField.z, 1, 2) + "\n"
    + "Gyroscopes  (rotation in rads/sec) :" + "\n" 
    + "x: " + nfp(gyro.x, 1, 2) + "\n"
    + "y: " + nfp(gyro.y, 1, 2) + "\n" 
    + "z: " + nfp(gyro.z, 1, 2) + "\n"
    + "Gravity (m/s^2) :" + "\n" 
    + "x: " + nfp(gravity.x, 1, 2) + "\n"
    + "y: " + nfp(gravity.y, 1, 2) + "\n" 
    + "z: " + nfp(gravity.z, 1, 2) + "\n"
    + "Orientation (heading in Degrees) :" + "\n" 
    + "x: " + nfp(orient.x, 1, 2) + "\n"
    + "y: " + nfp(orient.y, 1, 2) + "\n" 
    + "z: " + nfp(orient.z, 1, 2) + "\n"
    + "Linear Acceleration (m/s^2, minus gravity) :" + "\n" 
    + "x: " + nfp(linearAcceleration.x, 1, 2) + "\n"
    + "y: " + nfp(linearAcceleration.y, 1, 2) + "\n" 
    + "z: " + nfp(linearAcceleration.z, 1, 2) + "\n"
    + "Rotation Vector (%) :" + "\n" 
    + "x: " + nfp(rotationVector.x, 1, 2) + "\n"
    + "y: " + nfp(rotationVector.y, 1, 2) + "\n" 
    + "z: " + nfp(rotationVector.z, 1, 2) + "\n"
    + "Game Rotation (%) :" + "\n" 
    + "x: " + nfp(gameRotation.x, 1, 2) + "\n"
    + "y: " + nfp(gameRotation.y, 1, 2) + "\n" 
    + "z: " + nfp(gameRotation.z, 1, 2) + "\n"
    + "Light Sensor (lx) : " + light + "\n" 
    + "Proximity Sensor : " + proximity + "\n"
    + "Pressure Sensor (mBar) : " + pressure + "\n"
    + "Significant Motion (broken?) : " + significantMotionTime
    , 20, 0, width, height);
}

void onAccelerometerEvent(float x, float y, float z, long timeStamp, int accuracy){
  accelerometer.set(x, y, z);
}
void onMagneticFieldEvent(float x, float y, float z, long timeStamp, int accuracy){
  magneticField.set(x, y, z);
}
void onLightEvent(float v){
  light = v;
}
void onProximityEvent(float v){
  proximity = v;
}
void onPressureEvent(float p, long timeStamp, int accuracy){ //: p ambient pressure in hPa or mbar
  pressure = p;
}
void onGyroscopeEvent(float x, float y, float z, long timeStamp, int accuracy){ //: x,y,z rotation in rads/sec
  gyro.set(x,y,z);
}
void onGravityEvent(float x, float y, float z){
  gravity.set(x,y,z);
}
void onSignificantMotionEvent(){
  significantMotionTime = millis();
}
void onOrientationEvent(float x, float y, float z){
  orient.set(x,y,z);
}
void onLinearAccelerationEvent(float x, float y, float z){ //: x,y,z acceleration force in m/s^2, minus gravity
  linearAcceleration.set(x,y,z);
}

void onRotationVectorEvent(float x, float y, float z){
  rotationVector.set(x,y,z);
}
void onGameRotationEvent(float x, float y, float z){
  gameRotation.set(x,y,z);
}

public void mousePressed() { 
  if (sensor.isStarted())
    sensor.stop(); 
  else
    sensor.start(); 
  println("KetaiSensor isStarted: " + sensor.isStarted());
}