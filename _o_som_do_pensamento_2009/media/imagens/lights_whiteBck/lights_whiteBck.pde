import processing.video.*;

//vars

int[] pFrame; //array to store previous frame
PImage img; //image variable for b&w background
int threshold = 30; //threshold for motion tracking
int x, y, i;
color cColor; //variable to hold current color

Capture cam1;

void setup(){

  //bug 882 processing 1.0.1:
  try { 
    quicktime.QTSession.open(); 
  } 
  catch (quicktime.QTException qte) { 
    qte.printStackTrace(); 
  }

  size(640,480,P2D);
  background(255);

  String[] devices = Capture.list(); //lists all available capture devices
  //println(devices); //prints the list of available devices to the console
  cam1 = new Capture(this, width, height, devices[5]);

  int numPixels = width*height; //number of pixels to store in the buffer
  pFrame = new int[numPixels]; //create an array to store the previous frame for comparison

  img = new PImage();

}

void draw() { 
  if (cam1.available()){

    cam1.read(); //read new video frame
    
    boolean update=false; //set update true every 10 frames
    if(frameCount%20==0){
      update=true;
    }
    
    if(update){ //update the background image
    background (255); //refresh background
    }


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

        //if the color difference is bigger than the threshold:
        if (diffR>threshold && diffG>threshold && diffB>threshold) {
          colorMotion(cColor); //draw colored ellipses
          pFrame[i] = cColor; //save the current color into the 'previous' buffer
        }
      }
    }
  }
}

void colorMotion(color cColor){
  noStroke();
  smooth();
  
  float diam = random (10,30);
  float myAlpha = random (100,230);
  fill(cColor, myAlpha);
  ellipse(x, y, diam, diam);
}

void keyPressed(){
  if (key=='s')
    saveFrame("ellipses.jpg");
}
















