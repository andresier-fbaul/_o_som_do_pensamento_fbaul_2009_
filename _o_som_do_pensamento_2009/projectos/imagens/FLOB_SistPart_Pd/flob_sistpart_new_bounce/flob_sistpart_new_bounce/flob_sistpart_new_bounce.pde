/*
  multi touch camera draw sketch
 with particle systems
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


SysPart sp;
int px,py,ppx,ppy;
PFont font;

/// program
void setup(){
  //bug 882 processing 1.0.1
  try { 
    quicktime.QTSession.open(); 
  } 
  catch (quicktime.QTException qte) { 
    qte.printStackTrace(); 
  }

  size(1200,800,OPENGL);
  frameRate(25);
  // init video data and stream
  video = new Capture(this, videores, videores, 25);  

  // init blob tracker
  flob = new Flob(this, video); 
  //flob.mirrorX(true); 
  flob.setTresh(TRESH);

  flob.setOm(flob.CONTINUOUS_DIFFERENCE); 
  background(255);
  
  font = createFont(PFont.list()[2], 100);
  textFont(font,100);
  
  sp = new SysPart(10,width/2,height/2); //num parts, centerx, centery 

}



void draw(){
  if(video.available()) {
    video.read();
    flob.calc(  flob.binarize(video) );    



    //write test image to frame
    if(drawimg)
       image(video, 0, 0, width, height);
//      image(flob.videotex, 0, 0, width, height);


    noStroke();
    fill(0,20);
    rect(0,0,width,height);

    sp.update();
    sp.draw(); 


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

      ppx = px;
      ppy = py;
      px = (int)(centermass[0]*width);
      py = (int)(centermass[1]*height);
      
      
      

     sp.setPosForce(px,py,ppx,ppy);
      //sp.reIginite();  





    }

  }

}

void keyPressed(){
  if(key=='q')
   video.settings();
  
  
  
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





