/* runs on emulator and nexus 4
 */

void setup(){
  fullScreen(); 
  //size(400, 400);
}
void draw()
{
// no display output, so nothing to do here
}
void mousePressed ()
{
println("PRESSED x:" + mouseX + " y: " + mouseY);
}
void mouseReleased ()
{
println("RELEASED x:" + mouseX + " y: " + mouseY);
}
void mouseDragged ()
{
println("DRAGGED x:" + mouseX + " y: " + mouseY);
}