

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
int TRESH = 10;       //adjust treshold value here or keys t/T!!
int videores=128;//64//256
boolean drawimg=true; // key 'i' toggles draw

int nmax = 100;//3;
sysPart sp[] = new sysPart[nmax];

/// program

void setup(){
  //bug 882 processing 1.0.1
  try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }

  size(1200,800,OPENGL);
  frameRate(25);
  rectMode(CENTER);
  //  colorMode(HSB);
    colorMode(HSB, 360, 255, 255);
  
  // init video data and stream
  video = new Capture(this, videores, videores, 25);  

  // init blob tracker
  //  flob = new Flob(this); // defaults to 128 videores, values change when image ins
//  flob = new Flob(this, video); // builds internally vars according to video.width
  
  /// tens de por o novo flob 001k
  // http://s373.net/code/flob 
  
  flob = new Flob(this, video,width,height); // builds internally vars according to video.width
  flob.mirrorX(true); //mirror the image around X axis
  flob.setTresh(TRESH); //set the new threshold to the binarize engine

  flob.setBackground(video); // zero background to contents of video
  
  for(int i=0; i < nmax; i++)   sp[i] = new sysPart();
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


 for(int i=0; i < nmax; i++) 
    sp[i].active=false;



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

      ABlob ab = (ABlob) flob.getABlob(i);
      
    
//    //center and dim are normalized values
//    center = flob.getCentroid(i); 
//    dim = flob.getDim(i);
//    //box = flob.getBox(i);
//
//    // put the normalized coords in this image context coords
//    center[0] = center[0] * width;
//    center[1] = center[1] * height;
//    dim[0] = dim[0] * width;
 

    //box
  
    fill(122,200,200,100);
//    ellipse(center[0],center[1],dim[0],dim[0]);
    ellipse(ab.cx,ab.cy,ab.dimx*0.5,ab.dimy*0.5);

    //centroid
    fill(250,110,222,100);
    ellipse(ab.cx,ab.cy, 20, 20);
    
    if(i<nmax){
      
      
        for(int j=0; j < nmax; j++) {
        
            if(sp[j].nblob == i) {
           //   println(""+j+" my sys"+i);
              sp[j].active = true;
              sp[j].update(ab.cx,ab.cy);  
            }
    
            }

    
    }

  }
  
   
  for(int i=0; i < nmax; i++) {
    
    if(!sp[i].active){
     sp[i].life-=0.1; 
    }
    
    
    sp[i].draw();

     if(i>1&&i<nmax-1)
       sp[i].drawtoSys(sp[i+1], numblobs);


//     if(i>1&&i<nmax-1){
//     //  println("linha");
//      stroke(0,255,255,200);
//      strokeWeight(2);
//
//     line( sp[i].x, sp[i].y, sp[i+1].x, sp[i+1].y   ); 
//    }
   
  }
  

}


void keyPressed(){
  if(key=='i')
    drawimg^=true;
  else if(key=='t'){
    TRESH-=2;
    flob.setTresh(TRESH);
    println("video tresh: "+TRESH);
  }
  else if(key=='y'){
    TRESH+=2;
    flob.setTresh(TRESH);
    println("video tresh: "+TRESH);
  }   
  else
    flob.setBackground(video);

    
}


