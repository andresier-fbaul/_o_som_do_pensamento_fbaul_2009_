// alice in wonderland, andré sier, o som do pensamento, 2009

import processing.opengl.*;

Wonderland land; 
Alice alice;

PFont font;
float camx;

void setup(){
  size(1000,500,OPENGL); 
  frameRate(30);

  font = loadFont("ArialMT-47.vlw");
  textFont(font,47);

  alice = new Alice();
  land = new Wonderland(); 


  background(0);
  rectMode(CENTER);
}



void draw(){
  background(255);
//fill(255,175);noStroke();
//rect(0,0,width*10,height*10);

  float f = 0.1;
  camx = camx*(1.-f) + alice.x*f; //ease
  camera(camx,0,1000,camx,0,-100,0,1,0);

  land.draw();
  alice.move();
  alice.draw();
}


void keyReleased(){
  if(keyCode==UP||key=='w')
    alice.up=false;
  if(keyCode==LEFT||key=='a')
    alice.left=false;
  if(keyCode==RIGHT||key=='d')
    alice.right=false;
    
    if(key=='s')
      saveFrame("alice-in-wonderland-#####.jpg");
}
