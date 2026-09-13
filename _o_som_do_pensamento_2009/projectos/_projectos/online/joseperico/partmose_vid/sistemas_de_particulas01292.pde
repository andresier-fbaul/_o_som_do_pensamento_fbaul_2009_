/*
    sistemas de partículas video // o som do pensamento // 2009
    José Perico
*/
import processing.opengl.*;
import processing.video.*;
import s373.flob.*;

Capture video;
Flob flob; 
int timeout=0;
/// video params
int TRESH = 20;       //adjust treshold value here or keys t/T!!
int videores=128;
boolean drawimg=false; // key 'i' toggles draw


SysPart sp;

void setup(){
  
   try { 
    quicktime.QTSession.open(); 
  } 
  catch (quicktime.QTException qte) { 
    qte.printStackTrace(); 
  }
 
size(800,600,OPENGL);
  frameRate(30);
  
    video = new Capture(this, videores, videores, 25);  
    
    flob = new Flob(this, video); 
  flob.mirrorX(true); 
  flob.setTresh(TRESH);

  flob.setOm(flob.CONTINUOUS_DIFFERENCE); 
  background(0);

 sp = new SysPart(50,width/2,height/2); //num parts, centerx, centery 
  
  
  
}


void draw(){
  
  if(video.available()) {
    video.read();
    flob.calc(  flob.binarize(video) );  
    
     if(drawimg)
       image(video, 0, 0, width, height);
       
//         for(int i=0; i < sp.length; i++) {
//    sp[i].update();
//    sp[i].draw(); 
//  }
  
   int numblobs = flob.getNumBlobs(); 
    if(numblobs>0) { 
      float centermass[] = new float[3];
 
      for(int i = 0; i < numblobs; i++) {
        centermass = flob.getCentroidPixelcount(i);
     //   int numsys = (int)constrain(i,0,sp.length);
      //  sp[numsys].setPosForce(centermass[0]*width,centermass[1]*height);
     //   sp[numsys].reIgnite();  

      }
    }
  }
 background(0);
 sp.update();
 sp.draw(); 
  
}

void mousePressed(){
 
  sp.setPos(mouseX,mouseY);
  
}

void keyPressed(){
  if(key=='s')
    saveFrame("syspart1-######.jpg"); 
}

