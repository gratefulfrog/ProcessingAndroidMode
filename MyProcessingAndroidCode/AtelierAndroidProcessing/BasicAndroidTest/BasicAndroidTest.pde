/* BasicAndroidTest
 * good points:
 ** simple to understand
 * bad points:
 ** no structure means that you have to read every line to understand
 ** use of "magic numbers" for fill and background colors instead of meaningful names
 */

void setup() {
  fullScreen();
  noStroke();
  fill(0);
}

void draw() {
  background(204);
  if (mousePressed) {
    if (mouseX < width/2) {
      rect(0, 0, width/2, height); // Left
    } else {
      rect(width/2, 0, width/2, height); // Right
    }
  }
}