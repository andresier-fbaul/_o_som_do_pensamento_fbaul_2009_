import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 
import ddf.minim.*; 
import processing.video.*; 
import s373.flob.*; 
import processing.video.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class projecto_pedrovilela extends PApplet {

/*
 starfield / um campo de estrelas, o som do pensamento 2009
 mouseX controla a velocidade
 mouseY controla a rota\u00e7\u00e3o
 */
PImage img;






Minim minim;
AudioInput in; // o objecto do input sonoro
AudioPlayer jingle;

star s[]; // as estrelas
plane p[]; // os planos

float speed = 5; // a velocidade
float rotspeed = 1e-7f; // a velocidade de rota\u00e7\u00e3o
float rot; //
float angle;
float volfinal;
float av;

Capture video;
Flob flob;


public void setup(){
  
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
  float fov = PI/3.0f;
  float cameraZ = (height/2.0f) / tan(PI * fov / 360.0f);
  perspective(fov, PApplet.parseFloat(width)/PApplet.parseFloat(height), 
  0.001f, 1000000.0f);//cameraZ/10.0, cameraZ*10.0);

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

public void draw(){
  
  if(video.available()) {

  video.read();

  flob.calc(  flob.binarize(video) );    

  }

  float f0 = 0.16f;
  float f1 = 0.00525f;
  float f = av > flob.getPresencef() ? f1 : f0;
  av = flob.getPresencef() * f + (1.f-f)*av;//in.mix.level();   
  speed = map(av, 0.f, 0.1f,0.f,100.f);//map(mouseX, 0, width,0.,100.);
  rotspeed = 0.f;//map(mouseY, 0, height, -1e-2, 1e-2);
  rot = rot + rotspeed; //aculumar as rota\u00e7\u00f5es
  
  
  float newvol = map (av, 0.f, 0.1f,-100.f,0.f);
  
  if(newvol>volfinal)
     volfinal = map (av, 0.f, 0.1f,-100.f,0.f);
  else
    volfinal = volfinal - 2.5f; //fade out
  
//  if (volfinal < -50)
//    volfinal = map (av, 0., 0.1,-100.,0.);
//  else
//      if(frameCount%20==0)
//        volfinal = map (av, 0., 0.1,-100.,0.);

 
  jingle.setGain(  volfinal );


  rotspeed = random(0.001f, 0.01f);//map(mouseY, 0, height, -1e-2, 1e-2);
  rot = --rot + rotspeed; //aculumar as rota\u00e7\u00f5es


  background(190,231,231);
  stroke(100,250,20,150);
  fill(112,0,227,100);
  strokeWeight(2);
  angle += 0.01f;
  
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



MovieMaker mm;
boolean gravar = false;


public void keyPressed() {

  if (key == 'g') {

    if(!gravar){
      mm = new MovieMaker(this, width, height, "video.mov", 30, 
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


class plane{
  float x,y,z,s;
  float dimx=100;
  float dimy=50;
  float dir = (random(1)<0.5f? -1f : 1f);

  plane(){
    field();
  }  
  public void field(){
    float w = width*10; 
    float h = height*10; 
    x = random(w)-w/2;
    y = random(h)-h/2;
    z = -10000;
    //z = noise(minute() +random(100))*-10000;
    s = noise(year()+random(22009))*10.f;   
 //   println("z "+z);
// println(dir);
  }  

  public void zz(){
    z = random(0,-20000);
  }

  public void render(){

    if(z>5000)
      z = -20000;
      
    if(z<-20000)
       z = 500;
      //zz();
      
     {

      pushMatrix();
      translate(x,y,z);
      beginShape();
      vertex(-dimx,-dimy);
      vertex( dimx,-dimy);
      vertex( dimx, dimy);
      vertex(-dimx, dimy);
      endShape(CLOSE);
      popMatrix();     
      // line(x,y,z,x,y, z - speed*s);
    }

//    z += ((s+speed) * dir);
    z  = z + ((s+speed) * dir);

  }
}



class star{
  float x,y,z,s; 
  
  star(){
    field();
  }  
  
  public void field(){
    float w = width*10; 
    float h = height*10; 
    x = noise(millis())*w-w/2;
    y = noise(second()+random(1000))*h-h/2;
    z = noise(minute() +random(100))*-10000;
    s = noise(year()+random(22009))*10.f;   
    println("z "+z);
  }  

  public void zz(){
    z = noise(minute() +random(100)) * -10000;      
  }

  public void render(){

    if(z>1000)
      zz();
    else
      line(x,y,z,x,y, z - speed*s);

    z+=(s+speed);


  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--hide-stop", "projecto_pedrovilela" });
  }
}
