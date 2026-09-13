import processing.opengl.*;
import processing.video.*;

//vars
int numPixels;
int[] pFrame;
float movementSum;
int threshold = 15; //threshold for motion tracking
int x, y, i;
color cColor;

Capture cam1;

void setup(){

  //bug 882 processing 1.0.1
  try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }

  size(640,480,OPENGL);
  background(255);

  String[] devices = Capture.list(); //lists all available capture devices
  //println(devices); //prints the list of available devices to the console
  cam1 = new Capture(this, width, height, devices[5]);

  int numPixels = width*height; //number of pixels to store in the buffer
  pFrame = new int[numPixels]; //create an array to store the previous frame for comparison
  loadPixels(); //make the pixels array available for direct manipulation
}

void draw() { 
  if (cam1.available()){

    cam1.read(); //read new video frame
    cam1.loadPixels(); //make the pixels array available for direct manipulation

    int movementSum = 0;

    /*
    if (x==width && y==height){
     println("frame processed!");
     }
     */

    //for every 10 pixels on the video frame:
    for (x=0; x < width-1; x+=10){
      for (y=0; y < height-1; y+=10){
        int i = y*width+x;
        color cColor = cam1.pixels[i];
        color pColor = pFrame[i];

        //extract the red, green, and blue components from current pixel:
        int cR = (cColor >> 16) & 0xFF;
        int cG = (cColor >> 8) & 0xFF;
        int cB = cColor & 0xFF;
        //extract the red, green, and blue components from previous pixel:
        int pR = (pColor >> 16) & 0xFF;
        int pG = (pColor >> 8) & 0xFF;
        int pB = pColor & 0xFF;
        //compute the difference of the red, green, and blue values
        int diffR = abs(cR - pR);
        int diffG = abs(cG - pG);
        int diffB = abs(cB - pB);

        //add these differences to the running tally:
        movementSum += diffR + diffG + diffB;

        //pixels[i] = color(diffR, diffG, diffB); //render the difference image to the screen

        //if the color difference is bigger than the threshold:
        if (diffR>threshold && diffG>threshold && diffB>threshold) {
          colorMotion(cColor);
          pFrame[i] = cColor; //save the current color into the 'previous' buffer
        } 
        else { //draw white ellipses
          colorBck();
        }

      }
    }

    //to prevent flicker from frames that are all black (no movement),
    //only update the screen if the image has changed:
    if (movementSum > 0) {
      updatePixels();
      //println(movementSum); // Print the total amount of movement to the console
    }

  }
}

void colorMotion(color cColor){
  noStroke();
  fill(cColor, 200);
  smooth();
  float diam = random (15,20);
  ellipse(x, y, diam, diam);
}

void colorBck(){
  //pixels[i] = color(255, 255, 255);
  noStroke();
  fill(255, 200);
  ellipse(x, y, 15, 15);
}

void keyPressed(){
  if (key=='s')
    saveFrame("ellipses.jpg");
}







