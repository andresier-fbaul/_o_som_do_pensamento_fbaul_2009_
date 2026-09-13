/*
SONS DO PENSAMENTO
browser de projectos
andré sier
090630
 */

import processing.opengl.*;
//import processing.video.*;
//import s373.flob.*;
//import ddf.minim.*;

Monoflob mono;


PFont font,fontbig, fontsmall;
PImage bgimage;

String  projectos[];
String path = "/O_SOM_DO_PENSAMENTO_2009/"; // criar uma pasta na raiz do disco com este nome para ter os exes

String stat="";

//fullscreen window
public void init(){
  frame.dispose();
  frame.setUndecorated(true);
  //frame.set
//  GraphicsDevice myGraphicsDevice = GraphicsEnvironment.getLocalGraphicsEnvironment().getDefaultScreenDevice();
//  myGraphicsDevice.setFullScreenWindow(frame);
  super.init();
}


void setup(){

  size(screen.width ,screen.height,OPENGL);
  frame.setLocation(0,0);
  frameRate(10);
  rectMode(CENTER);

  font = createFont("monaco",12);
  fontbig = createFont("monaco",25);
  fontsmall = createFont("monaco",9);
  textFont(font);

  bgimage = loadImage("sonspensamento2048512.jpg");

  projectos = loadStrings("proj_database.txt");
  println("--SP-mono-browser");
  println("--projectos:");
  println();
  println(projectos);
  
  
  mono = new Monoflob(3,3);//(2,2);


}



void draw(){


    background(0,0,100);
    
    tint(255,100);
    image(bgimage, 250, 0, width-247, (float)height*0.25);//512);
    fill(0,200);
    rect(125,height/2,250,height);

  if(mousePressed)
     mono.touch(mouseX,mouseY,20,20);


  mono.render();


    fill(255,170);
    textFont(font);
    text(stat, 5, height*0.2);


}


void keyPressed(){
 if(key==ESC){//intercept esc
   key=0;
   println("esc"+frameCount); 
 }
}




