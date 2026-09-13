/*
    sistemas de partículas // o som do pensamento // 2009
*/

import processing.video.*;
import s373.flob.*;
import processing.opengl.*;

Capture video;
Flob flob; 

MovieMaker mm;
boolean gravar = false;
int timeout=0;

int TRESH = 30;   //adjust treshold value here or keys t/T!!
int videores=128;
boolean drawimg=false;  // key 'i' toggles draw
 
 float center[] = new float[2];
//println(center[0]);
  float dim[] = new float[2];
  
  
SysPart sp;
SysPart1 sp1;

PFont font;
PFont font1;
//float fontsize;
//int fftband;

void setup(){
 //bug 882 processing 1.0.1
  try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }
  
 size (800,600,OPENGL);
  frameRate(30);
  // init video data and stream
  video = new Capture(this, videores, videores, 30); 
   // init blob tracker
  flob = new Flob(this, video); 
  flob.mirrorX(true); 
  flob.setTresh(TRESH);

  flob.setBackground(video); 
  background(0);
 

  font = createFont(PFont.list()[2], 1);
  font1 = createFont(PFont.list()[2], 1);
  textFont(font,1);

 sp = new SysPart(200,center[0],center[1]); //num parts, centerx, centery 
 sp1 = new SysPart1(3,width/2,height/2); //num parts, centerx, centery 
  
}


void draw(){
 
  if(!drawimg)
    background(0);

  // main image loop
  if(video.available()) {

    video.read();

    flob.calc(  flob.binarize(video) );    

    // flob.calc calcs current blobs and returns an arraylist with the data
    //blobs = flob.calc(flob.binarize(video));    

  }

  //write test image to frame
  if(drawimg)
    image(flob.videotex, 0, 0, width, height);

  //report presence graphically
  fill(255,152,255);
  rect(0,0,flob.getPresencef()*width,10);


  //get and use the data
  int numblobs = flob.getNumBlobs();  
  // or blobs.size() if using the local arraylist...

  float center[] = new float[2];
  float dim[] = new float[2];


  for(int i = 0; i < numblobs; i++) {

    //center and dim are normalized values
    center = flob.getCentroid(i); 
    dim = flob.getDim(i);
    //box = flob.getBox(i);

    // put the normalized coords in this image context coords
    center[0] = center[0] * width;
    println(center[0]);
    center[1] = center[1] * height;
    dim[0] = dim[0] * width;
    dim[1] = dim[1] * height;

    //box
    fill(0,0,255,100);
    rect(center[0],center[1],dim[0],dim[1]);

    //centroid
    fill(0,255,0,100);
    rect(center[0],center[1], 20, 20);

  }
 
 
// background(0);
noStroke(); 
  fill(0,8);
  rect(0,0,width,height);

sp.update();
 textFont(font,random(30, 50));
 sp.draw(); 
 
 sp1.update();
 textFont(font1,random(70, 180));
 sp1.draw(); 
 
 if(gravar)// Add window's pixels to movie
    mm.addFrame(); 
}

void mousePressed(){
 
  
  sp.setPos(center[0],center[1]);
   sp.setPosForce(mouseX,mouseY,pmouseX,pmouseY);
   
  sp1.setPosForce(mouseX,mouseY,pmouseX,pmouseY);
  sp1.setPos(mouseX-10,mouseY-10);
}

void keyPressed() {
//  if(key==' ')
//   background(0);
  
  if(key=='s')
    saveFrame("videoframe-######.jpg");
  if (key == 'g') {

    if(!gravar){
      mm = new MovieMaker(this, width, height, "video.mov", 10, 
      MovieMaker.JPEG, MovieMaker.HIGH);
      gravar = true;
    } 
    else {

      // Finish the movie if space bar is pressed
      mm.finish();
      // Quit running the sketch once the file is written
      exit();

    } 

  }

}

