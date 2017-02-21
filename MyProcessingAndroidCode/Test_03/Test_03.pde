/* runs on emulator and nexus 4
 */

void setup(){
  fullScreen();
  noStroke();
  background(0);
  colorMode(HSB, 100, 1, 1);
}

void draw(){
  fill(dist(pmouseX, pmouseY, mouseX, mouseY), 1, 1);
  ellipse(mouseX, mouseY, mouseX-pmouseX, mouseY-pmouseY);
}