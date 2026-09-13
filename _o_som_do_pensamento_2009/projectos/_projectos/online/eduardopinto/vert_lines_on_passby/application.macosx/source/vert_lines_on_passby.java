import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 
import processing.video.*; 
import s373.flob.*; 

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

public class vert_lines_on_passby extends PApplet {

/*
 
 vert_lines_on_pass_by //
 yet another neat piece to project on an entrance wall

 by // 
 Eduardo Pinto (eduardomcp@gmail.com)
 
 credits to // 
 andr\u00e9 sier and his monoflob ( http://s373.net )

 */





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



public void setup(){
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
  filtro_lowpass = 0.05f;
noCursor();
}



public void draw(){

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

public void keyPressed(){
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






class Monoflob{
  Botao b[];
  int gx,gy,num;
  float dimx,dimy;
  float sizex,sizey;//1.0 max
  
  Monoflob(int _gx, int _gy){
    gx = _gx;
    gy = _gy;
    sizex = 0.75f;
    sizey = 0.55f;
    float stridex = (float)width / (float)gx;
    float stridey = (float)height / (float)gy;
    dimx = stridex * sizex ;
    dimy = stridey * sizey ;
    
    num = gx * gy;    
    b = new Botao[num];

    for(int i=0; i<num;i++){
       float x =  ((float)(i % gx) +0.5f) * stridex  ;
       float y = ((float)(i / gx) +0.5f) *stridey ;
       if (i >= 1200 && i <= 1249)
       b[i] = new Botao(i, x,y,dimx,dimy);      
    }        
        
  }
  
  public void touch(float x, float y,float w, float h){    
    for(int i=0; i<num; i++)
           if (i >= 1200 && i <= 1249)
      b[i].test(x,y,w,h);    
  }

  public void render(){
    for(int i=0; i<num; i++)
           if (i >= 1200 && i <= 1249)
      b[i].render();   
  }


}

class Botao {
  int id;
  float x, y, w, h,w2,h2, lowpassing;
  int coroff,coron;
  int gain; 
  boolean on = false;
  boolean touch = false;

  Botao(int i,  float _x, float _y, float _w , float _h  ) {
    id = i;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    w2 = w*0.5f;
    h2 = h*0.5f;    
    coroff = color(50);
    coron = color(0,250,0);
  } 


  public void test(float _x, float _y, float dimx, float dimy) {
    float dx = x - _x;
    float dy = y - _y;
    if(abs(dx) <= (w2+dimx*0.5f) && abs(dy) <= (h2+dimy*0.5f)){
     gain = 100; // gain++;  
      touch = true;
    }
  }

  public void state(){    
    if(touch)
      touch=false;
    else
      gain--;
      
    if(gain>100){
      gain = 100;
      on = true; 
    }
    if(gain<50)
      on = false;
    if(gain<0)
      gain=0;
  }

  public void render(){
    state();
 /*   fill(on ? coron : coroff,map(gain,0,100,10,255));    
    rect(x,y,w,h);
    fill(255);
*/

  //  text(""+gain,x,y);
    //text(""+id,x,y+h2-2);
        pushMatrix();
        translate(x, y);
        // Rotation formula based on brightness
        // rotate((2 * PI * brightness(c) / 255.0));
        lowpassing = lowpassing * (1.f-filtro_lowpass) + (gain) * filtro_lowpass;
        // println(brightness(c));
       // scale((2 * PI * lowpassing / 255.0)*0.9);         
        imageMode(CENTER);
     //  image(ninja, 0, 0 ); //, 100/4, 132/4); //, cellSize/2, cellSize/2);
fill(255, 255, 255, 100);
noStroke();
rotateY(lowpassing/20);
//rotate(PI/3);
box(5, lowpassing*9, 20);
        popMatrix();
        }
  
  }





  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--hide-stop", "vert_lines_on_passby" });
  }
}
