/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 */ 
 
import processing.video.*;

Capture cam;

void setup() {
  size(640, 480);
  String[] devices = Capture.list();
  println(devices);

  cam = new Capture(this, width, height, devices[5]);
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    image(cam, mouseX, mouseY, 160,120);
  }
} 


void keyPressed(){
 if(key=='s')
    cam.settings(); 
}

