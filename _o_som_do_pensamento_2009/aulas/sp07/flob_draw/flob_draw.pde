/*
  multi touch camera draw sketch
 */

import processing.opengl.*;
import processing.video.*;
import s373.flob.*;

/// vars
Capture video;
Flob flob; 
int timeout=0;
/// video params
int TRESH = 30;       //adjust treshold value here or keys t/T!!
int videores=128;
boolean drawimg=false; // key 'i' toggles draw

/// program
void setup(){
 //bug 882 processing 1.0.1
  try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }

  size(700,700,OPENGL);
  frameRate(25);
  // init video data and stream
  video = new Capture(this, videores, videores, 25);  

  // init blob tracker
  flob = new Flob(this, video); 
  flob.mirrorX(true); 
  flob.setTresh(TRESH);

  flob.setBackground(video); 
  background(0);
}



void draw(){
  if(video.available()) {
    video.read();
    flob.calc(  flob.binarize(video) );    

    //write test image to frame
    if(drawimg)
      image(flob.videotex, 0, 0, width, height);

    // apagar o background se 1000 frames 
    // com pouquissima actividade

    if(flob.getPresencef() < 0.01) {
      timeout++;
      print("-");
      if (timeout > 1000){
        timeout=0;
        background(0); 
      }
    } 
    else {
      timeout = 0; 
    }

    fill(255,150);    
    //get and use the data
    int numblobs = flob.getNumBlobs();  
    float centermass[] = new float[3];

    for(int i = 0; i < numblobs; i++) {
      centermass = flob.getCentroidPixelcount(i); 
      // put the normalized coords in this image context coords
      centermass[0] = centermass[0] * width;
      centermass[1] = centermass[1] * height;
      float rad = centermass[2]*0.05;//map(centermass[2],0,2500,2,250);

      ellipse(centermass[0], centermass[1], rad,rad);
    }
  }

}

void keyPressed(){
  if(key=='i')
    drawimg^=true;
  else if(key=='t'){
    TRESH-=2;
    flob.setTresh(TRESH);
    println("video tresh: "+TRESH);
  }
  else if(key=='T'){
    TRESH+=2;
    flob.setTresh(TRESH);
    println("video tresh: "+TRESH);
  }  else if(key=='s'){
    saveFrame("videodraw-######.jpg");
  }  else
    init_video_bg(); //any key sets new background to test against

}


void init_video_bg(){
  background(0);
  flob.setBackground(video);
}


