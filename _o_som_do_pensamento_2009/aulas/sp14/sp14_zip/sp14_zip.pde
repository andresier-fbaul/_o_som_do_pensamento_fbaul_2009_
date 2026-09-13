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

  frameRate(25);
  cam = new Capture(this, width, height, devices[6]);
  

}

void draw() {
  if (cam.available() == true) {
    cam.read();
    image(cam, 0,0, 640,480);
    //    image(cam, mouseX, mouseY, 640,480);
    //    println("fps "+frameRate);
  }
} 


void keyPressed(){
  if(key=='s')
    saveFrame("arduino_####.jpg");//cam.settings(); 

}


