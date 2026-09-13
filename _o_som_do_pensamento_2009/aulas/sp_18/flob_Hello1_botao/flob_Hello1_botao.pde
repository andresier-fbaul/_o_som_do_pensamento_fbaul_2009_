/*
 download flob @ http://s373.net/code/flob

 FLOB test program // andré sier // 20090216 
 updated for flob 0.0.1d
 
 gets blobs from camera capture stream
 and paints some shapes in place of centroids
 */

// speeding up stuff with OPENGL
import processing.opengl.*;
// import processing video lib to access camera
import processing.video.*;
// import flob lib
import s373.flob.*;

/// vars
Capture video;// a camera instance
Flob flob; // an instance of this blobs tracker
//ArrayList blobs; // an ArrayList to hold the gathered blobs

/// video params
int TRESH = 20;       //adjust treshold value here or keys t/T!!
int videores=128;//64//256
boolean drawimg=true; // key 'i' toggles draw


Botao b1,b2;
PFont font;



/// program

void setup(){
  //bug 882 processing 1.0.1
  try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }

  size(700,500,OPENGL);
  frameRate(25);
  rectMode(CENTER);
  // init video data and stream
  video = new Capture(this, videores, videores, 25);  

  // init blob tracker
  //  flob = new Flob(this); // defaults to 128 videores, values change when image ins
  flob = new Flob(this, video); // builds internally vars according to video.width
  flob.mirrorX(true); //mirror the image around X axis
  flob.setTresh(TRESH); //set the new threshold to the binarize engine

  flob.setBackground(video); // zero background to contents of video


  b1 = new Botao ( 400, 100, 100, 1   );
  b2 = new Botao ( 150, 300, 120, 1   );
  font = createFont("Andale Mono", 27);
  textFont(font,27);
}



void draw(){

  if(!drawimg)
    background(0);
    
    

  // main image loop
  if(video.available()) {

    video.read();

    flob.calc(  flob.binarize(video) );    

    // flob.calc calcs current blobs and returns an arraylist with the data
    //blobs = flob.calc(flob.binarize(video));    

  }

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
    


    //box
    fill(0,0,255,100);
    rect(center[0],center[1],dim[0],dim[1]);

    //centroid
    fill(0,255,0,100);
    rect(center[0],center[1], 20, 20);

  }
  
  
  
  
  b1.render();
  b2.render();
  
  
  

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

