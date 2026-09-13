import processing.opengl.*;

import processing.video.*;


import s373.flob.*;

Capture cam;

Capture video;
Flob flob;

int TRESH = 20;
int videores=64;//128;
boolean drawimg=true;

Botao b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16; //tantos quantos forem precisos para funcionar adequadamente

PFont font;


Movie myMovie;
float movieDur;

void setup() {
  
   try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }
  
  
  size(640, 480, P2D);
  frameRate(25);
  background(0);
  rectMode(CENTER);
   
  String[] devices = Capture.list();
  println(devices);

  
  video = new Capture(this, videores, videores,devices[5], 25);
//   new Capture(this, width, height, devices[5]);
  
  flob= new Flob(this, video);
  flob.mirrorX(true);
  flob.setTresh(TRESH);
  
  flob.setBackground(video);
  flob.setOm(1);
  // Load and play the video in a loop
  myMovie = new Movie(this, "bandofoutsiders.avi" );
  myMovie.loop();
  movieDur = myMovie.duration();
  
b1 = new Botao (80, 60, 60, 60 ,0);
b2 = new Botao (240, 60, 60, 60,0);
b3 = new Botao (400, 60, 60, 60, 0);
b4 = new Botao (560, 60, 60, 60,0);
b5 = new Botao (80, 180, 60, 60, 0);
b6 = new Botao (240, 180, 60, 60 ,0);
b7 = new Botao (400, 180, 60, 60,0);
b8 = new Botao (560, 180, 60, 60, 0);
b9 = new Botao (80, 300, 60, 60 ,0);
b10 = new Botao (240, 300, 60, 60,0);
b11 = new Botao (400, 300, 60, 60, 0);
b12 = new Botao (560, 300, 60, 60, 0);
b13 = new Botao (80, 420, 60, 60 ,0);
b14 = new Botao (240, 420, 60, 60,0);
b15 = new Botao (400, 420, 60, 60, 0);
b16 = new Botao (560, 420, 60, 60 ,0);
font = createFont("monaco",10);
textFont(font);

}



void movieEvent(Movie myMovie) {
  myMovie.read();
   println("movie at: "+ myMovie.time());
   
}

void draw() {
  
  if(video.available()){
    video.read();
  
    flob.calc( flob.binarize(video) );
  }
    
  
  
  
  
   
  
 
// if(frameCount%30==0) {
//  float pos = constrain( map(mouseX,0,width,0.,1.), 0.,1.);
//  pos = pos * movieDur;
//  
//  myMovie.jump(pos);
//  
//  println("movie at: "+pos);
//   
// }
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
    b4.test(center[0],center[1]);
    b5.test(center[0],center[1]);
    b6.test(center[0],center[1]);
    b7.test(center[0],center[1]);
    b8.test(center[0],center[1]);
    b9.test(center[0],center[1]);
    b10.test(center[0],center[1]);
    b11.test(center[0],center[1]);
    b12.test(center[0],center[1]);
    b13.test(center[0],center[1]);
    b14.test(center[0],center[1]);
    b15.test(center[0],center[1]);
    b16.test(center[0],center[1]);
    


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
  b4.render();
  b5.render();
  b6.render();
  b7.render();
  b8.render();
  b9.render();
  b10.render();
  b11.render();
  b12.render();
  b13.render();
  b14.render();
  b15.render();
  b16.render();
  
  
  

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


