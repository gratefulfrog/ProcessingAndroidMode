/* runs on emulator and nexus 4
 */

void setup(){
  fullScreen(); 
  //size(400, 400);
}
void draw(){
ellipse(mouseX, mouseY, mouseX-pmouseX, mouseY-pmouseY);
}