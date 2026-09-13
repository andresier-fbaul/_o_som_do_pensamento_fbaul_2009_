import processing.core.*; import processing.video.*; import java.applet.*; import java.awt.*; import java.awt.image.*; import java.awt.event.*; import java.io.*; import java.net.*; import java.text.*; import java.util.*; import java.util.zip.*; public class GettingStartedCapture2a extends PApplet {/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 */ 
 


Capture cam;

public void setup() {
  size(640, 480);
  String[] devices = Capture.list();
  println(devices);

  cam = new Capture(this, width, height, devices[5]);
}

public void draw() {
  if (cam.available() == true) {
    cam.read();
    image(cam, mouseX, mouseY, 160,120);
  }
} 


public void keyPressed(){
 if(key=='s')
    cam.settings(); 
}


  static public void main(String args[]) {     PApplet.main(new String[] { "GettingStartedCapture2a" });  }}