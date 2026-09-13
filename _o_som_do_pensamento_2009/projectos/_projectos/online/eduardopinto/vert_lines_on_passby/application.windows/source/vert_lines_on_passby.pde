/*
 
 vert_lines_on_pass_by //
 yet another neat piece to project on an entrance wall

 by // 
 Eduardo Pinto (eduardomcp@gmail.com)
 
 credits to // 
 andré sier and his monoflob ( http://s373.net )

 */

import processing.opengl.*;
import processing.video.*;
import s373.flob.*;

/// vars
Capture video;
Flob flob; 
ArrayList blobs;

/// video params
int tresh = 30; 
int fade = 30;
int om = 1;
int videores=64;
boolean drawimg=true, mostra=true;
String info="";
PFont font;
int videotex = 3;
float fps = 60;

Monoflob mono;

PImage ninja, fundo;
float filtro_lowpass;



void setup(){
  //bug 882 processing 1.0.1
  try { 
    quicktime.QTSession.open(); 
  } 
  catch (quicktime.QTException qte) { 
    qte.printStackTrace(); 
  }

  size(screen.width,screen.height,OPENGL);
  frameRate(fps);
  //smooth();
  rectMode(CENTER);
  String[] devices = Capture.list();
  println(devices);

  video = new Capture(this, videores, videores, devices[2], (int)fps);  
  flob = new Flob(this, video, width,height); 

  flob.setTresh(tresh); 
  flob.setImage(videotex);
  flob.setBlur(0); 
  flob.setMirror(false,false);
  flob.setOm(0); 
  flob.setOm(1); 
  flob.setFade(fade); 
  flob.setMinNumPixels(20); 
  flob.setMaxNumPixels(500); 
  font = createFont("monaco",9);
  textFont(font);

  mono = new Monoflob(50,50);
 

  ninja = loadImage("ninja.png");
  fundo = loadImage("fundo.bmp");
  filtro_lowpass = 0.05;
noCursor();
}



void draw(){

  if(video.available()) {
    video.read();
    blobs = flob.calc(flob.binarize(video));    
  }

  if(drawimg)
    image(flob.getSrcImage(), 0, 0, width, height);

  if(mostra)
  background(0);

  imageMode(CORNER);
 
  rectMode(CENTER);
  int numblobs = blobs.size();
  for(int i = 0; i < numblobs; i++) {
    ABlob ab = (ABlob)flob.getABlob(i);     
    mono.touch(ab.cx,ab.cy, ab.dimx, ab.dimy);
  }

  mono.render();

}

// some always useful key commands

void keyPressed(){
  if(key=='b')
    drawimg^=true;
  if (key=='S')
    video.settings();
  if (key=='s')
    saveFrame("monoflob-######.png");
  if (key=='i'){  
    videotex = (videotex+1)%4;
    flob.setImage(videotex);
  }
  if(key=='t'){
    tresh--;
    flob.setTresh(tresh);
  }
  if(key=='T'){
    tresh++;
    flob.setTresh(tresh);
  }   
  if(key=='f'){
    fade--;
    flob.setFade(fade);
  }
  if(key=='F'){
    fade++;
    flob.setFade(fade);
  }   
  if(key=='o'){
    om^=1;
    flob.setOm(om);
  }   
  if(key==' ') 
    flob.setBackground(video);

  if(key=='a')
    mostra^=true;

}





