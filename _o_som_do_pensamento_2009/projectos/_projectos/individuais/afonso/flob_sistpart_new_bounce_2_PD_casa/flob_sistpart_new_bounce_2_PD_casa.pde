/*
  multi touch camera draw sketch
 with particle systems
 */

import processing.opengl.*;
import processing.video.*;
import s373.flob.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

/// vars
Capture video;
Flob flob; 
int timeout=0;
/// video params
int TRESH = 10;//20;       //adjust treshold value here or keys t/T!!
int videores=128;
boolean drawimg=false; // key 'i' toggles draw
/// vars required pd-processing
float audio;
int b1,b2;
int numblobs;


SysPart sp;
int px,py,ppx,ppy;
PFont font;
//int numblobs;

String texto1[]; //= loadStrings("1.txt");
String texto2[];// = loadStrings("3.txt");
String texto3[] = {"olá_mundo","som_do_pensamento"}; 




/// program
void setup(){
  //bug 882 processing 1.0.1
  try { 
    quicktime.QTSession.open(); 
  } 
  catch (quicktime.QTException qte) { 
    qte.printStackTrace(); 
  }

  size(1200,800,OPENGL);
  frameRate(25);
 /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  /* write messages at port 12001 in self ip */
  myRemoteLocation = new NetAddress("127.0.0.1",12001);
 
  texto1= loadStrings("1.txt");
  texto2 = loadStrings("3.txt");

  println("texto1-----");
  println(texto1);
  println("texto2-----");
  println(texto2);
 
 
  // init video data and stream
  video = new Capture(this, videores, videores, 25);  

  // init blob tracker
  flob = new Flob(this, video); 
  //flob.mirrorX(true); 
  flob.setThresh(TRESH);

  flob.setOm(flob.CONTINUOUS_DIFFERENCE); 
  background(255);
  
  font = createFont(PFont.list()[22], 200);
  textFont(font,125);
  
  sp = new SysPart(10,width/2,height/2); //num parts, centerx, centery 

}
/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/audio")==true) {
    audio = theOscMessage.get(0).floatValue();
  }
  if(theOscMessage.checkAddrPattern("/b1")==true) {
    b1 = theOscMessage.get(0).intValue();
  }

  if(theOscMessage.checkAddrPattern("/b2")==true) {
    b2 = theOscMessage.get(0).intValue();
  }

}



void draw(){
  if(video.available()) {
    video.read();
    flob.calc(  flob.binarize(video) );    



    //write test image to frame
    if(drawimg)
       image(video, 0, 0, width, height);
//      image(flob.videotex, 0, 0, width, height);


    noStroke();
    fill(0,20);
    rect(0,0,width,height);

    sp.update();
    sp.draw(); 


    //get and use the data
    numblobs = flob.getNumBlobs(); 
    if(numblobs>0) { 
      int who=-1;
      float centermass[] = new float[3];
      //track biggest blob
      for(int i = 0; i < numblobs; i++) {
        float cm[] = flob.getCentroidPixelcount(i);
        if(cm[2] > centermass[2]){
          centermass = cm; 
          who = i;
          //          println(centermass[0]+" "+centermass[1]);
       //    println(cm);
        }
      }

      ppx = px;
      ppy = py;
      px = (int)(centermass[0]*width);
      py = (int)(centermass[1]*height);
      
      
      

     sp.setPosForce(px,py,ppx,ppy);
      //sp.reIginite();  



  println("numblobs "+numblobs);
    if(numblobs < 2)
      sp.setTexto(texto1);
     else if(numblobs >= 2 && numblobs < 4)
      sp.setTexto(texto2);
    else if(numblobs >=4) {
      sp.setTexto(texto3);
    }


    }

  }
//float tamanho = 10 + map(audio,0.,1.,0,200);

//  fill(255,155);
//  ellipse(width/2,height/2,tamanho,tamanho);


//  fill(255,125);
//  ellipse(px,py,400,400);
 
 
//audio entre 0. e 1. 
 // if(b1>0.959|b1<1){
 //   drawimg^=true;
//    int c = (int) random(255);
//    fill(c);
//    ellipse(random(width),random(height),random(10,25),random(10,25));    
 // }


//  if(b2>0){
//    fill(random(255),random(255),random(255));
//    ellipse(random(width),random(height),random(10,25),random(10,25));    
//  }


    //send 3-4 osc messages
    OscMessage myMessage = new OscMessage("/x");
    myMessage.add(px);
    oscP5.send(myMessage, myRemoteLocation); 
 
    myMessage = new OscMessage("/y");
    myMessage.add(py);
    oscP5.send(myMessage, myRemoteLocation); 

    myMessage = new OscMessage("/numblobs");
    myMessage.add(numblobs);
    oscP5.send(myMessage, myRemoteLocation); 

  if(random(1)<0.1){
    myMessage = new OscMessage("/colide");
    myMessage.add("bang");
    oscP5.send(myMessage, myRemoteLocation); 
  }
}

void keyPressed(){
  if(key=='q')
   video.settings();
  
  
  
  if(key=='i')
    drawimg^=true;
  else if(key=='t'){
    TRESH-=2;
    flob.setThresh(TRESH);
    println("video tresh: "+TRESH);
  }
  else if(key=='T'){
    TRESH+=2;
    flob.setThresh(TRESH);
    println("video tresh: "+TRESH);
  }  
  else if(key=='s'){
    saveFrame("videodraw-######.jpg");
  }  
  else
    init_video_bg(); //any key sets new background to test against

}


void init_video_bg(){
  background(0);
  flob.setBackground(video);
}





