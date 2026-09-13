/*
 starfield / um campo de estrelas, o som do pensamento 2009
 mouseX controla a velocidade
 mouseY controla a rotação
 */
PImage img;

import processing.opengl.*;
import ddf.minim.*;
import processing.video.*;
import s373.flob.*;

Minim minim;
AudioInput in; // o objecto do input sonoro
AudioPlayer jingle;

star s[]; // as estrelas
plane p[]; // os planos

float speed = 5; // a velocidade
float rotspeed = 1e-7; // a velocidade de rotação
float rot; //
float angle;
float volfinal;
float av;

Capture video;
Flob flob;


void setup(){
  
    //bug 882 processing 1.0.1
  try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }

   
   size(screen.width,screen.height,OPENGL);//  size(1280,720,OPENGL);
//   size(1024,768,OPENGL);//  size(1280,720,OPENGL);
//  size(914,514,OPENGL); // 720p / 1.4
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  jingle = minim.loadFile("8bp060-01-david_sugar-bang.mp3", 2048);
  jingle.loop();

  // a perspectiva defeito do opengl
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(PI * fov / 360.0);
  perspective(fov, float(width)/float(height), 
  0.001, 1000000.0);//cameraZ/10.0, cameraZ*10.0);

  s = new star[1000];
  for(int i=0; i<s.length;i++)
    s[i]=new star();

  p = new plane[500];
  for(int i=0; i<p.length;i++)
    p[i]=new plane();
    
    
  // init video data and stream
  video = new Capture(this, 64, 64, 25);  

  flob = new Flob(this, video); // builds internally vars according to video.width
  flob.mirrorX(true); //mirror the image around X axis
  flob.setThresh(20); //set the new threshold to the binarize engine
  flob.setOm(1); // dif continua
  flob.setFade(5);

  flob.setBackground(video); // zero background to contents of video

  noCursor();
  
}

void draw(){
  
  if(video.available()) {

  video.read();

  flob.calc(  flob.binarize(video) );    

  }

  float f0 = 0.16;
  float f1 = 0.00525;
  float f = av > flob.getPresencef() ? f1 : f0;
  av = flob.getPresencef() * f + (1.f-f)*av;//in.mix.level();   
  speed = map(av, 0., 0.1,0.,100.);//map(mouseX, 0, width,0.,100.);
  rotspeed = 0.;//map(mouseY, 0, height, -1e-2, 1e-2);
  rot = rot + rotspeed; //aculumar as rotações
  
  
  float newvol = map (av, 0., 0.1,-100.,0.);
  
  if(newvol>volfinal)
     volfinal = map (av, 0., 0.1,-100.,0.);
  else
    volfinal = volfinal - 2.5; //fade out
  
//  if (volfinal < -50)
//    volfinal = map (av, 0., 0.1,-100.,0.);
//  else
//      if(frameCount%20==0)
//        volfinal = map (av, 0., 0.1,-100.,0.);

 
  jingle.setGain(  volfinal );


  rotspeed = random(0.001, 0.01);//map(mouseY, 0, height, -1e-2, 1e-2);
  rot = --rot + rotspeed; //aculumar as rotações


  background(190,231,231);
  stroke(100,250,20,150);
  fill(112,0,227,100);
  strokeWeight(2);
  angle += 0.01;
  
  pushMatrix();
	  translate(25,50);
	  rotateZ(angle);
	  rotateY(angle);
	  
	  popMatrix();
	  translate(75,50,-25);
	  rotateX(angle);

 
//  stroke(255,250);
//  fill(255,50);
//
//  translate(width/2,height/2);

  rotate(sin(rot)*TWO_PI);

  for(int i=0; i<s.length;i++)
    s[i].render();

  for(int i=0; i<p.length;i++)
    p[i].render();
    
  if(gravar)// Add window's pixels to movie
  mm.addFrame();
    
}


//void keyPressed(){
  //if(key==' ')
  //flob.setBackground(video);

    
//}

