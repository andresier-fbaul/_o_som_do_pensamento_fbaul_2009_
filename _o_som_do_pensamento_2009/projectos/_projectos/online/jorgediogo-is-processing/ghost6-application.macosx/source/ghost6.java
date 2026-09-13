import processing.core.*; 
import processing.xml.*; 

import ddf.minim.*; 

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

public class ghost6 extends PApplet {

/**
Ghost<br/>
<br/>
Photo credits:<br/>
<a href="http://www.flickr.com/photos/theecotone/2056145066/">http://www.flickr.com/photos/theecotone/2056145066/</a><br/>
<a href="http://www.flickr.com/photos/ninara/2865577606/">http://www.flickr.com/photos/ninara/2865577606/</a><br/>
<a href="http://www.flickr.com/photos/faisalsaeed/212339449/"/>http://www.flickr.com/photos/faisalsaeed/212339449/</a><br/>
<a href="http://www.flickr.com/photos/pat1921/3141038442/">http://www.flickr.com/photos/pat1921/3141038442/</a><br/>
<a href="http://www.flickr.com/photos/ninara/2533230389/">http://www.flickr.com/photos/ninara/2533230389/</a><br/>
<a href="http://www.flickr.com/photos/gandalf_grey/138716336/">http://www.flickr.com/photos/gandalf_grey/138716336/</a><br/>
<a href="http://www.flickr.com/photos/domhuk/198645000/">http://www.flickr.com/photos/domhuk/198645000/</a><br/>
<a href="http://www.flickr.com/photos/townendphotography/2365241628/">http://www.flickr.com/photos/townendphotography/2365241628/</a><br/>
<a href="http://www.flickr.com/photos/mehrshadmansouri/2831154459/">http://www.flickr.com/photos/mehrshadmansouri/2831154459/</a><br/>
<a href="http://www.flickr.com/photos/eugeni_dodonov/2258050920/">http://www.flickr.com/photos/eugeni_dodonov/2258050920/</a><br/>
<br/>
Music credits:<br/>
Schumann - Scenes from Childhood Opus 15, Pleading Child by Bernd Krueger: <a href="http://www.piano-midi.de/copy.htm">http://www.piano-midi.de/copy.htm</a><br/>
*/




int slideCount = 10;

float slideDur = 12;
float slideFadeDur = 3;
float fps = 15.0f; // 30

boolean expandToWindow = false;
boolean fullScreenWindow = false;


PImage pointer;
PImage thisSlide;
PImage nextSlide;

boolean nextSlideLoaded;
boolean nextSlideSetBlack;

Minim minim;
AudioPlayer audioLoop;




public void setup(){

  if(fullScreenWindow)
    size(screen.width, screen.height);
  else
    size(1024, 768);

  smooth();  
  frameRate(fps);
  noCursor();
  
  background(0);
  
  pointer = loadImage("pointer-32x32.png"); // pointer first, of course

  nextSlide = loadImage("f0.jpg");
  thisSlide = createImage(nextSlide.width, nextSlide.height, RGB);
  setBlack(thisSlide);
  
  nextSlideLoaded = false;
  nextSlideSetBlack = false;
  
  minim = new Minim(this);
  audioLoop = minim.loadFile("scn15_4a.mp3", 2048);
  audioLoop.play();
  audioLoop.loop();
}





public void drawSlide(PImage slide, float fadeFactor){
  if(slide == null)
    return;
    
  int w,h;
  if(expandToWindow){
    w=width;
    h=height;
  }
  else {
    w=slide.width;
    h=slide.height;
  }
  int x = width/2 - w/2;
  int y = height/2 - h/2;

  tint(255, fadeFactor * 255);
  image(slide, x,y, w,h);
}


public void drawPointer(){
  tint(255,255);    
  image(pointer, width/2-pointer.width/2, height/2-pointer.height/2);
}


public void setBlack(PImage slide){
  int size = slide.width*slide.height;
  slide.loadPixels();
  for(int i=0; i<size; i++)
    slide.pixels[i] = 0;
  slide.updatePixels();
}


public void draw(){
  
  float time = frameCount / fps;
  float inSlideTime = time % slideDur;
  
  if(inSlideTime <= slideFadeDur){ // do draw something
  
// will the impossible
    if(random(0,1) < 0.00005f) translate(0,random(0,1) * height/8);
// error happen?
  
    float inFadeFactor = inSlideTime / slideFadeDur;
    drawSlide(thisSlide, 1.0f-inFadeFactor);
    drawSlide(nextSlide, inFadeFactor);

    drawPointer();
    
    nextSlideLoaded=false;
    
  }
  else {
    if(!nextSlideLoaded){
    
      thisSlide=nextSlide;
      nextSlide=null;  
      
      int currentSlide = (int)(time / slideDur) % slideCount;
      int next = (currentSlide+1) % slideCount; 
      
println("current slide " + currentSlide);
println("loading " + next);
      nextSlide = loadImage("f" + next + ".jpg");
println("loaded " + next);

      nextSlideLoaded=true;
      
      if(nextSlideSetBlack){
println("next is black");        
        setBlack(nextSlide);
        nextSlideSetBlack = false;
      }
      
    }
  }

}



public void keyPressed(){
  if(key == ' '){
    nextSlideSetBlack = true;
  }
}



  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#000000", "--hide-stop", "ghost6" });
  }
}
