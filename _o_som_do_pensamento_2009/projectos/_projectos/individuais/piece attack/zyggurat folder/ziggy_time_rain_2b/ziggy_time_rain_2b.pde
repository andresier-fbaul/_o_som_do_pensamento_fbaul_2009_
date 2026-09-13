
/// time rain, andré sier
/// som do pensamento 2009

import processing.video.*;
import processing.opengl.*;
import javax.media.opengl.*;
import javax.media.opengl.glu.*;
import java.nio.*;
import processing.opengl.*;

import s373.flob.*;


// cam vars
PImage frames[];
Capture cam;
int time = 250;//50;///10*30;//10seg@30pfs frames
int timehead;

Flob flob;

// planes vars
plane p[];
int np = 100;

PGraphicsOpenGL pgl; 
GL gl; 
GLU glu; 

float velx=0,vely=0;

void setup(){
  //bug 882 processing 1.0.1
  try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }

  size(1024,768,OPENGL);
  frameRate(30);
  // init video buffer
  frames = new PImage[time];
  for(int i=0;i<frames.length;i++){
    frames[i] = new PImage(128,128); 
  }
  // init cam
  cam = new Capture(this,128,128,30);
  flob = new Flob(this,cam,width,height);
  flob.setMirror(true,false);
  flob.setOm(1);
  flob.setTresh(10);
  flob.setFade(25);
  

  // init planes
  p = new plane[np];
  for(int i=0;i<p.length;i++){
    p[i] = new plane(); 
  }

  // a perspectiva defeito do opengl
//  float fov = PI/3.0;
//  float cameraZ = (height/2.0) / tan(PI * fov / 360.0);
//  perspective(fov, float(width)/float(height), 
//  0.001, 10000.0);//cameraZ/10.0, cameraZ*10.0);

  perspective( radians(50.0f), float(width)/float(height), 0.01, 50000.0f   );  
  pgl = (PGraphicsOpenGL)g;
  glu = pgl.glu;

  rectMode(CENTER);


}




void draw(){

  if(cam.available()){

    background(0);
    cam.read(); 
    flob.calcsimple(flob.binarize(cam));

    if(frameCount%30==0){//mousePressed) {
      timehead = (timehead + 1) % frames.length;
//      frames[timehead].copy(cam,0,0,320,240,0,0,320,240);
      frames[timehead].copy(cam,0,0,128,128,0,0,128,128);
    }


  gl = pgl.beginGL();
  glu =pgl.glu;
//  gl.setSwapInterval(1); // vsync
  //  gl.glClearColor(0.1f,0.1f,0.1f,0.1f);
  gl.glClearColor(0.f,0.f,0.f,0.1f);
  gl.glClear( GL.GL_COLOR_BUFFER_BIT | GL.GL_DEPTH_BUFFER_BIT);
  gl.glDepthMask(false);

  gl.glDisable( GL.GL_DEPTH_TEST ) ;
  //  gl.glEnable( GL.GL_BLEND ) ;
  //  gl.glBlendFunc(GL.GL_ONE_MINUS_SRC_ALPHA,GL.GL_SRC_ALPHA); 
  //
  gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE);
  gl.glEnable( GL.GL_BLEND ) ;


    
    
    //noStroke();
  
    for(int i=0;i<p.length;i++){
      p[i].render(); 
    }

  }

  pgl.endGL();
  
  
  /// update
  
  float vx=0,vy=0;
  
  for(int i=0; i<flob.getNumBlobs();i++){
     trackedBlob ab = flob.getTrackedBlob(i);
     
     
//     fill(0,0,255,100);
//     rect(ab.cx, ab.cy, ab.dimx, ab.dimy);
//     stroke(255);
     float m = 10000f;
//     line(ab.cx,ab.cy, ab.cx + ab.velx*m ,ab.cy + ab.vely*m); 
     vx+=ab.velx*m;
     vy+=ab.vely*m;
  }
  
  float fdown = 0.052;
  float fup = 0.172;
  float f=0;
  
  if(velx < vx)
    f = fdown;
  else
    f = fup;
  velx = velx * (1f-f) + vx * f;
  if(vely < vy)
    f = fdown;
  else
    f = fup;
  
  vely = vely * (1f-f) + vy * f;
  
  stroke(255,100);
  float cx = width/2; float cy = height/2;
  line(cx,cy,cx+vx,cy+vy);
  stroke(100,255,100,150);
  line(cx,cy,cx+velx,cy+vely);

  float dev = (abs(vx)+abs(vy)) * 0.01;
  
    for(int i=0;i<p.length;i++){
      if(p[i].y<2600)
      p[i].setAcc(velx,vely, dev); 
      else
        p[i].setAcc(velx*0.01,vely*0.255,dev*0.1);//(0,0, 0); 
    }


}



void keyPressed(){
  if (key=='s'){
    saveFrame("timerain2-#####.jpg");
  }  
}


