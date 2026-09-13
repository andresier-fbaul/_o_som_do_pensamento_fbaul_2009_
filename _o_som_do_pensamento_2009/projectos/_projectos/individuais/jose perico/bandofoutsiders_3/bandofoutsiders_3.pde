
import processing.opengl.*;

import processing.video.*;


import s373.flob.*;


Capture video;
Flob flob;

int TRESH = 20;
int videores=128;
boolean drawimg=true;

Botao b1, b2, b3; //tantos quantos forem precisos para funcionar adequadamente

PFont font;


Movie myMovie;
float movieDur;

void setup() {
  
   try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }
  
  
  size(640, 480, P2D);
  background(0);
  rectMode(CENTER);
  
  video = new Capture(this, videores, videores, 25);
  
  flob= new Flob(this, video);
  flob.mirrorX(true);
  flob.setTresh(TRESH);
  
  flob.setBackground(video);
  // Load and play the video in a loop
  myMovie = new Movie(this, "bandofoutsiders1.mov" );
  myMovie.loop();
  movieDur = myMovie.duration();
  
b1 = new Botao (320, 80, 640, 160 ,0);
b2 = new Botao (320, 240, 640, 160,0);
b3 = new Botao (320, 400, 640, 160, 0);
font = createFont("monaco",10);
textFont(font);
}



void movieEvent(Movie myMovie) {
  myMovie.read();
}

void draw() {
  
  if(video.available()){
    video.read();
  
    flob.calc( flob.binarize(video) );
  }
 
 if(frameCount%30==0) {
  float pos = constrain( map(mouseX,0,width,0.,1.), 0.,1.);
  pos = pos * movieDur;
  
  myMovie.jump(pos);
   
 }
//  myMovie.read();
//if (myMovie!=null){
  tint(255, 120);
  image(myMovie,0,0,myMovie.width*2,myMovie.height*2);
//}

 //write test image to frame
  if(drawimg)
    image(flob.videotex, 0, 0, width, height);
    
  

  //report presence graphically
  fill(255,152,255);
  rect(0,0,flob.getPresencef()*width,10);


  //get and use the data
  int numblobs = flob.getNumBlobs();  
  // or blobs.size() if using the local arraylist...

  float center[] = new float[2];
  float dim[] = new float[2];


  for(int i = 0; i < numblobs; i++) {

    //center and dim are normalized values
    center = flob.getCentroid(i); 
    dim = flob.getDim(i);
    //box = flob.getBox(i);

    // put the normalized coords in this image context coords
    center[0] = center[0] * width;
    center[1] = center[1] * height;
    dim[0] = dim[0] * width;
    dim[1] = dim[1] * height;


    // inserir teste espacial

    b1.test(center[0],center[1]);
    b2.test(center[0],center[1]);
    b3.test(center[0],center[1]);
    


    //box
    fill(0,0,255,100);
    rect(center[0],center[1],dim[0],dim[1]);

    //centroid
    fill(0,255,0,100);
    rect(center[0],center[1], 20, 20);

  }
  
  
  
  
  b1.render();
  b2.render();
  b3.render();
  
  
  

}


void keyPressed(){
  if(key=='i')
    drawimg^=true;
  else if (key=='s')
    video.settings();
  else if(key=='t'){
    TRESH-=2;
    flob.setTresh(TRESH);
    println("video tresh: "+TRESH);
  }
  else if(key=='T'){
    TRESH+=2;
    flob.setTresh(TRESH);
    println("video tresh: "+TRESH);
  }  
  
  else
    init_video_bg(); //any key sets new background to test against

    
}


void init_video_bg(){
  flob.setBackground(video);
  // the same as ..
  //  video.loadPixels();
  //  arraycopy(video.pixels, flob.backgroundPixels);
}

//}
