/*
  flob mono_me
  
  as, 20090621
 
 */

import processing.opengl.*;
import processing.video.*;
import s373.flob.*;
import ddf.minim.*;

/// vars
Capture video;
Flob flob; 
ArrayList blobs;
Minim minim;

String audiofiles[] = {"White_noise.wav","Pink_noise.wav","Brown_noise.wav","Brown_noise.wav","Blue_noise.wav","Purple_noise.wav","Purple_noise.wav","Gray_noise.wav"};

/// video params
int tresh = 10;
int fade = 120;
int om = 1;
int videores=128;
boolean drawimg=true;
String info="";
PFont font;
int videotex = 3;//0;
float fps = 60;

Monoflob mono;



void setup(){
  //bug 882 processing 1.0.1
  try { 
    quicktime.QTSession.open(); 
  } 
  catch (quicktime.QTException qte) { 
    qte.printStackTrace(); 
  }

  //size(700,700,OPENGL);
  size(1024,768,OPENGL);
  background (0);
  frameRate(fps);
  rectMode(CENTER);
  
  minim = new Minim(this);//iniciar o audio
  
  String dev[] = Capture.list();
  println(dev);

  // init video data and stream
  video = new Capture(this, videores, videores, (int)fps);  
  noCursor ();

  // init blob tracker

  // flob = new Flob(this, video); // builds internally vars according to video dims
  flob = new Flob(this, video, width,height); // new: pass world coords, get values in those ranges

  flob.setTresh(tresh); //set the new threshold to the binarize engine
  flob.setThresh(tresh); //typo
  flob.setSrcImage(videotex);
  flob.setImage(videotex); //  pimage i = flob.get(Src)Image();

  flob.setBackground(video); // zero background to contents of video
  flob.setBlur(0); //new : fastblur filter inside binarize
  flob.setMirror(true,false);
  flob.setOm(0); //flob.setOm(flob.STATIC_DIFFERENCE);
  flob.setOm(1); //flob.setOm(flob.CONTINUOUS_DIFFERENCE);
  flob.setFade(fade); //only in continuous difference

  font = createFont("monaco",9);
  textFont(font);

  mono = new Monoflob(8,1);//(5,4);
}



void draw(){

//  if(!drawimg)
//    background(0);
  noStroke(); fill(0,3);
  rect(0,0,width,height);
  // main image loop
  if(video.available()) {
    video.read();

    //  flob.calc(  flob.binarize(video) );    
    //  blobs = flob.track(  flob.binarize(video) );    // blobs is now 
    // arraylist of <trackedBlob> type
    // and method is track, so getnumtrackedblobs + flob.getTrackedBlob(i)

    // flob.calc calcs current blobs and returns an arraylist with the data
    blobs = flob.calc(flob.binarize(video));    

  }

  //write test image to frame
//  if(drawimg)
//    image(flob.getSrcImage(), 0, 0, width, height);

   rectMode(CENTER);

  //get and use the data
  int numblobs = blobs.size();//flob.getNumBlobs();  

  // no need
  //  float center[] = new float[2];
  //  float dim[] = new float[2];


  for(int i = 0; i < numblobs; i++) {

    ABlob ab = (ABlob)flob.getABlob(i); 
    
    int whichbutton = mono.touch(ab.cx,ab.cy, ab.dimx, ab.dimy);


    if( whichbutton > -1 ){
      //println(" em cima do "+whichbutton);
      float alp = map( mono.b[whichbutton].gain, 0, 150, 50, 200);
      fill(mono.b[whichbutton].coron,alp);
      //sndfile = minim.loadFile(mono.b[whichbutton].noize, 2048);
      //mono.b[whichbutton].noize --> tocar este som
    } else {
      //fill(255);
    }

    // desenhar as blobs

    //box
//    fill(255);
    stroke(0,0,0,0);
    ellipse(ab.cx,ab.cy,ab.dimx*0.5,ab.dimy*0.5);

    //centroid
    fill(0);
    rect(ab.cx,ab.cy, 5, 5);

    info = ""+ab.id+" "+ab.cx+" "+ab.cy;

    text(info,ab.cx,ab.cy+20);
    //   println(info);

  }

  mono.render();

 //report presence graphically
  fill(0);
  rectMode(CORNER);
  rect(5,5,flob.getPresencef()*width,5);

  String stats = ""+frameRate+"\nflob.numblobs: "+numblobs+"\nflob.thresh:"+tresh+
                 "   <t/T>"+"\nflob.fade:"+fade+"   <f/F>"+"\nflob.om:"+flob.getOm()+
                 "\nflob.image:"+videotex+"\nflob.presence:"+flob.getPresencef();
  fill(0);
  text(stats,5,25);

}


void keyPressed(){
  if(key=='b')
    drawimg^=true;
  if (key=='S')
    video.settings();
  if (key=='s')
    saveFrame("flob001k-######.png");
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

  if(key==' ') //space clear flob.background
    flob.setBackground(video);


}



