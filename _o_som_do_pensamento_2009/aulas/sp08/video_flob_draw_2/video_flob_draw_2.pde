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
int TRESH = 20;       //adjust treshold value here or keys t/T!!
int videores=128;
boolean drawimg=false; // key 'i' toggles draw

Circ circ[];
int numcirc = 20;

/// program
void setup(){
  //bug 882 processing 1.0.1
  try { 
    quicktime.QTSession.open(); 
  } 
  catch (quicktime.QTException qte) { 
    qte.printStackTrace(); 
  }

  size(700,700,OPENGL);
  frameRate(25);
  // init video data and stream
  video = new Capture(this, videores, videores, 25);  

  // init blob tracker
  flob = new Flob(this, video); 
  flob.mirrorX(true); 
  flob.setTresh(TRESH);

  flob.setOm(flob.CONTINUOUS_DIFFERENCE); 
  background(100);
  
  circ = new Circ[numcirc];
  for(int i=0;i<numcirc;i++)
    circ[i] = new Circ();
}



void draw(){
  if(video.available()) {
    video.read();
    flob.calc(  flob.binarize(video) );    

    //write test image to frame
    if(drawimg)
      image(flob.videotex, 0, 0, width, height);

    //get and use the data
    int numblobs = flob.getNumBlobs(); 
    if(numblobs>0) { 
      int who=-1;
      float centermass[] = new float[3];
      //track biggest blob
      for(int i = 0; i < numblobs; i++) {
        float cm[] = flob.getCentroidPixelcount(i);
        if(cm[2] > centermass[2]){
          centermass = cm; 
          who = i;
//          println(centermass[0]+" "+centermass[1]);
        }
      }

      noStroke();

      video.loadPixels();
      int px = (int)(centermass[0]*width);
      int py = (int)(centermass[1]*height);
      int vx = (int)(centermass[0]*video.width);
      int vy = (int)(centermass[1]*video.height);
      fill(video.pixels[vx +vy*video.width ],100);
      float s[] = flob.getDim(who);
      s[0]*=(width*0.025);//(width*0.5);      
 //      println(px+" "+py+" "+s[0]);
      ellipse(px,py,s[0],s[0]);
      
      int numrendercirc = max(numblobs*2,numcirc);
      for(int i=0; i < numrendercirc; i++) {
        circ[i].render(px,py,s[1]);
      }
      

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
  }  
  else if(key=='s'){
    saveFrame("videodraw-######.jpg");
  }  
  else
    init_video_bg(); //any key sets new background to test against

}


void init_video_bg(){
  background(0);
  flob.setBackground(video);
}




