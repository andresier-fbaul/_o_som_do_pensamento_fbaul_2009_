
/// time rain, andré sier
/// som do pensamento 2009

import processing.video.*;
import processing.opengl.*;

// cam vars
PImage frames[];
Capture cam;
int time = 50;///10*30;//10seg@30pfs frames
int timehead;

// planes vars
plane p[];
int np = 50;


void setup(){
  //bug 882 processing 1.0.1
  try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }

  size(700,500,OPENGL);
  frameRate(30);
  // init video buffer
  frames = new PImage[time];
  for(int i=0;i<frames.length;i++){
    frames[i] = new PImage(320,240); 
  }
  // init cam
  cam = new Capture(this,320,240,30);

  // init planes
  p = new plane[np];
  for(int i=0;i<p.length;i++){
    p[i] = new plane(); 
  }

  // a perspectiva defeito do opengl
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(PI * fov / 360.0);
  perspective(fov, float(width)/float(height), 
  0.001, 10000.0);//cameraZ/10.0, cameraZ*10.0);



}




void draw(){

  if(cam.available()){

    background(0);
    cam.read(); 

//    if(mousePressed) {
      timehead = (timehead + 1) % frames.length;
      frames[timehead].copy(cam,0,0,320,240,0,0,320,240);
//    }
    
    
    noStroke();
  
    for(int i=0;i<p.length;i++){
      p[i].render(); 
    }

  }

}

void keyPressed(){
  if (key=='s'){
    saveFrame("timerain-#####.jpg");
  }  
}




