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

public class ajetsetwilly3 extends PApplet {

/** 
A Jet Set Willy<br/>
<br/>
Graphics and audio from Manic Miner and Jet Set Willy by Matthew Smith - 
<a href="http://en.wikipedia.org/wiki/Matthew_Smith_(games_programmer)">http://en.wikipedia.org/wiki/Matthew_Smith_(games_programmer)</a>

*/





int magnifyFactor = 3;
float fps = 12.0f;
float jumpFactor = 1.1f;


PImage[] images;
int nextImage;
int willyWidth;
int willyHeight;
int willyY;

PImage groundImage;
PImage movingGroundImage;
int groundY;
int groundSize;
int groundCount;
int[] groundState;

PImage theKeyImage;
int xKey;
int yKey;
int keyColorIndex;
int keyColors[] = {0xff2ed32e, 0xffd4d437, 0xffd228d2, 0xff32d3d3};

int xPos;
int yPos;

int jumpCycle;
int jumpCycleSize;

int stoppedCycle;
float lastStoppedMs;

int roomNumber;
int roomBackColor;

Minim minim;
AudioSnippet soundOfJump;
AudioSnippet soundOfDying;



public void setup(){

  size(780,600);
  frameRate(fps);
  noSmooth();
 
  minim = new Minim(this);
  // load a file into an AudioSnippet
  // it must be in this sketches data folder
  soundOfJump = minim.loadSnippet("jump.mp3");
  soundOfDying = null; // minim.loadSnippet("jetsetdiesinside.mp3");
 
  images = new PImage[4];
  for(int i=0; i<images.length; i++){
    images[i] = loadImage("ajetsetwilly-" + i + "-10x16.png");
  }
  
  willyWidth = images[0].width * magnifyFactor;
  willyHeight = images[0].height * magnifyFactor;
  groundImage = loadImage("ajetsetwilly-ground-8x8.png");
  movingGroundImage = loadImage("ajetsetwilly-moving-ground-8x8.png");
  groundSize = groundImage.width * magnifyFactor;
  groundCount = (width+groundSize-1) / groundSize;
  groundState = new int[groundCount];
  
  theKeyImage = loadImage("thekey-8x8.png");
  
//  willyY = height/2 - (willyHeight + groundSize) / 2;
  willyY = (int)(height/2 - 3.5f * magnifyFactor); // the eye is the vertical center
  groundY = willyY + willyHeight;
  yPos = willyY;

  jumpCycleSize = (int)(willyHeight * jumpFactor) * 2;
  jumpCycle=0;

  yKey = willyY - jumpCycleSize/2 - (theKeyImage.height-1)*magnifyFactor;  
  keyColorIndex=0;

  roomNumber = 0;
  
  stoppedCycle=0;
  lastStoppedMs = millis();
  
  groundState[groundCount-1] = -1; // solid ground to start
  newRoom();
}



public void draw(){
// control 
   if((jumpCycle <= 0) &&
      (stoppedCycle == 0) &&
      (keyPressed || mousePressed)){ // start a jumpCycle
     jumpCycle = jumpCycleSize;
     soundOfJump.pause();
     soundOfJump.rewind();
     soundOfJump.play();
   }
  
   if(jumpCycle > 0){ //jumpCycleSize .. jumpCycleSize/2 -> up, then down
     if(jumpCycle > jumpCycleSize/2)
       yPos = willyY - (jumpCycleSize - jumpCycle);
     else
       yPos = willyY - (jumpCycle);
      
     jumpCycle -= (int)(magnifyFactor*2);
   }
   else
     yPos = willyY;
  
   int groundIndex = (xPos + willyWidth/6) / groundSize;
   if((yPos == willyY) && 
      (groundState[groundIndex] >= 0) && (groundState[groundIndex] < groundSize))
     groundState[groundIndex] += magnifyFactor;
 
 
   if((jumpCycle <= 0) && 
      (stoppedCycle == 0) &&
      (millis() - lastStoppedMs > 10 * 2 * 1000)
      ){
     if((groundIndex <= groundCount-2) && 
        (groundState[groundIndex] == -1) &&
        (groundState[groundIndex+1] == -1)){
       if(random(0,1) < 0.005f){
         stoppedCycle = (int)(fps * 10); // stop to ponder
         nextImage = 0;
         lastStoppedMs = millis();
         
         if(soundOfDying != null){
           soundOfDying.pause();
           soundOfDying.rewind();
           soundOfDying.play();
         }
         
       }
     }
   }
   
   
   
   
 
// draw:
  background(roomBackColor);
 
  int y;
  y = groundY;
  
  int dx = groundImage.width * magnifyFactor;
  
  int x=0;
  for(int i=0; i<groundCount; i++){
    if(groundState[i] < 0){ // fixed ground
      tint(0xffff2b2b, 255);
      image(groundImage, x,y, 
            groundSize,groundSize);
    }
    else{ // moving ground
      tint(0xffd12323, 255);
      image(movingGroundImage, x,y+groundState[i], 
            groundSize,groundSize);
      fill(roomBackColor);
      noStroke();
      rect(x,y+groundSize, groundSize,groundSize);
    }
            
    x+=groundSize;
  } 
 
  
  tint(0xffd4d4d4, 255);
  image(images[nextImage], xPos, yPos, 
        images[nextImage].width * magnifyFactor,
        images[nextImage].height * magnifyFactor);

  if(xKey >= 0){
    tint(keyColors[keyColorIndex], 255);
    image(theKeyImage, xKey, yKey, 
                       theKeyImage.width * magnifyFactor,
                       theKeyImage.height * magnifyFactor);
    keyColorIndex = (keyColorIndex+1) % keyColors.length;
  }

  if(stoppedCycle == 0){
    xPos += magnifyFactor;
    nextImage = (nextImage+1) % images.length;
    if(xPos + willyWidth > width){
      newRoom();
    }
  }
  else
    stoppedCycle--;
  
}



public void newRoom(){
  groundState[0] = groundState[groundCount-1]; // the last will be first

  int type;
  int count;
  for(int i=1; i<groundCount-1;){
    if(random(0,1) <= 0.6f) 
      type = 0;
    else
      type = -1;
      
    count = (int)random(2,6);
    if(i + count > groundCount-1)
      count = groundCount-1-i;
      
    for(int p=i; p<i+count; p++)
      groundState[p] = type;
      
    i+=count;      
    
//    groundState[i] = 0;
  }  

  groundState[groundCount-1] = -1; 

  xPos = 0;
  
  if(random(0,1) <= 0.5f)
    roomBackColor = 0xff1717d0;
  else
    roomBackColor = 0xff000000;
    
  if(roomNumber % 2 == 1)
    xKey = (int)random(0, width-theKeyImage.width*magnifyFactor);
  else
    xKey = -1;
  
  roomNumber++;
}





  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#000000", "--hide-stop", "ajetsetwilly3" });
  }
}
