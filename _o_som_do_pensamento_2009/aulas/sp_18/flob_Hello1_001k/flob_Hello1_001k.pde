/*
 download flob @ http://s373.net/code/flob

  new flob only 001k

  blur,
  global coordinates (no more *=width)
  get arraylist of elements and access what u need

 */


import processing.opengl.*;
import processing.video.*;
import s373.flob.*;

/// vars
Capture video;
Flob flob; 
ArrayList blobs; // an ArrayList to hold the gathered blobs

/// video params
int TRESH = 20;       //adjust treshold value here or keys t/T!!
int videores=128;//64//256
boolean drawimg=true; // key 'i' toggles draw
String info="";
PFont font;
int videotex = 0;
//case 0: videotex = videoimg; break;
//case 1: videotex = videotexbin; break;
//case 2: videotex = videotexmotion; break;
//case 3: videotex = videoteximgmotion; break;
/// program

void setup(){
  //bug 882 processing 1.0.1
  try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }

  size(700,500,OPENGL);
  frameRate(25);
  rectMode(CENTER);
  // init video data and stream
  video = new Capture(this, videores, videores, 25);  

  // init blob tracker
 
 // flob = new Flob(this, video); // builds internally vars according to video.width
  flob = new Flob(this, video, width,height); // NEW: pass in width and height of scene, get values in those ranges
 
  flob.setTresh(TRESH); //set the new threshold to the binarize engine
  flob.setThresh(TRESH);
  flob.setSrcImage(videotex);

  flob.setBackground(video); // zero background to contents of video
  flob.setBlur(0); //NEW : blur filter inside binarize
  flob.setMirror(true,false);
  
  
  font = createFont("arial",10);
  textFont(font);
}



void draw(){

  if(!drawimg)
    background(0);

  // main image loop
  if(video.available()) {

    video.read();

  //  flob.calc(  flob.binarize(video) );    
  
    blobs = flob.track(  flob.binarize(video) );    // blobs is now 
                                                    // arraylist of <trackedBlob> type

    // flob.calc calcs current blobs and returns an arraylist with the data
    //blobs = flob.calc(flob.binarize(video));    

  }

  //write test image to frame
  if(drawimg)
    image(flob.getSrcImage(), 0, 0, width, height);

  //report presence graphically
  fill(255,152,255);
  rect(0,0,flob.getPresencef()*width,10);


  //get and use the data
  int numblobs = blobs.size();//flob.getNumBlobs();  

// no need
//  float center[] = new float[2];
//  float dim[] = new float[2];


  for(int i = 0; i < numblobs; i++) {

     trackedBlob tb = (trackedBlob)flob.getTrackedBlob(i); 
    //now access all these fields. 
    // pos & vel & dim results are local world coords
    
    // int tb.id;
    // float tb.cx;
    // float tb.cy;
    // float tb.velx;
    // float tb.vely;
    // float tb.prevelx;
    // float tb.prevely;
    // int tb.presencetime;
    // float tb.dimx;
    // float tb.dimy;
    // int tb.birthtime;
   

  
    // inserir teste espacial aqui


    // desenhar as blobs

    //box
    fill(0,0,255,100);
    rect(tb.cx,tb.cy,tb.dimx,tb.dimy);

    //centroid
    fill(0,255,0,100);
    rect(tb.cx,tb.cy, 20, 20);
    
    info = ""+tb.id+" "+tb.presencetime+" "+tb.cx+" "+tb.cy+" "+tb.birthtime;
    text(info,tb.cx,tb.cy);
 //   println(info);

  }

}


void keyPressed(){
  if(key=='i')
    drawimg^=true;
  else if (key=='s')
    video.settings();
  else if (key=='v'){  
    videotex = (videotex+1)%4;
    flob.setSrcImage(videotex);
  }
  else if(key=='t'){
    TRESH-=2;
    flob.setTresh(TRESH);
    println("video tresh: "+TRESH);
  }
  else if(key=='T'){
    TRESH+=2;
    flob.setTresh(TRESH);
    println("video tresh: "+TRESH);
  }   
  else
    init_video_bg(); //any key sets new background to test against

    
}


void init_video_bg(){
  flob.setBackground(video);
  // the same as ..
  //  video.loadPixels();
  //  arraycopy(video.pixels, flob.backgroundPixels);
}

