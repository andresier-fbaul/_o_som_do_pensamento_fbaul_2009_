/*
  multi touch camera draw sketch in 3d!
 */

import processing.opengl.*;
import processing.video.*;
import s373.flob.*;

/// vars
Capture video;
Flob flob; 
int timeout=0;
/// video params
int TRESH = 30;       //adjust treshold value here or keys t/T!!
int videores=128;
boolean drawimg=false; // key 'i' toggles draw

float z=-10000;
float zmid = -5000; //look here
float zmax = -10000;
// 3d camera rotates like a circle
float camspeed=0.01;
float campx,campz,camangle,camradius=7000;
float camheight = -500;

//3dplanes
plane p[];
int np = 1000;
int headplane=0;

/// program
void setup(){
  //bug 882 processing 1.0.1
  try { 
    quicktime.QTSession.open(); 
  } 
  catch (quicktime.QTException qte) { 
    qte.printStackTrace(); 
  }

  size(1000,700,OPENGL);
  frameRate(25);
  // init video data and stream
  video = new Capture(this, videores, videores, 25);  

  // init blob tracker
  flob = new Flob(this, video); 
  flob.mirrorX(true); 
  flob.setTresh(TRESH);

  flob.setBackground(video); 
  background(0);

  // init planes
  p = new plane[np];
  for(int i=0;i<p.length;i++){
    p[i] = new plane(); 
  }


  // a perspectiva defeito do opengl
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(PI * fov / 360.0);
  perspective(fov, float(width)/float(height), 
  0.001, 20000.0);//cameraZ/10.0, cameraZ*10.0);


}



void draw(){
  if(video.available()) {
    video.read();
    flob.calc(  flob.binarize(video) );    

    //get and use the data
    int numblobs = flob.getNumBlobs();  
    float centermass[] = new float[3];
    float dim[] = new float[2];

    for(int i = 0; i < numblobs; i++) {
      centermass = flob.getCentroidPixelcount(i); 
      dim = flob.getDim(i); 
      // put the normalized coords in this image context coords
      centermass[0] = map(centermass[0],0,1,-5000,5000);//centermass[0] * width;
      centermass[1] = map(centermass[1],0,1,-2000,2000);//centermass[1] * height;
      dim[0] *= 320;//160;//width;
      dim[1] *= 180;//90;//height;

      // z = map(centermass[2],0,2500,-20,-1000);
      z = z + 10;
      if(z > 0)
        z = zmax;

      p[headplane].set(centermass[0],centermass[1],z,dim[0],dim[1]);
      headplane = (headplane+1)%p.length; //next

    }


    //mouse touch radius & speed
    if(mousePressed){
      camradius += map(mouseY,0,height,-100,100);
      camradius = constrain(camradius, 200, 10000);
      camspeed += map(mouseX,0,width,0.005,-0.005);
      camspeed = constrain(camspeed, -0.01, 0.01);
    }

    //render 3d

    background(0);

    // camera
    camangle+=camspeed;
    campx = cos(camangle)*camradius + 0;
    campz = sin(camangle)*camradius + zmid;    
    // pos, look, up
    camera(campx,camheight,campz, 0, 0, zmid, 0,1,0);

    fill(255,150);        
    for(int i = 0; i < p.length; i++) {
      p[i].render();
    }
 
     //write test image to frame
    if(drawimg){
      camera();
      image(flob.videotex, width-flob.videotex.width, height-flob.videotex.height);
    }
   

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
  else if(key=='T'){
    TRESH+=2;
    flob.setTresh(TRESH);
    println("video tresh: "+TRESH);
  }  
  else if(key=='s'){
    saveFrame("videodraw-######.jpg");
  }  
  else
    init_video_bg(); //any key sets new background to test against

}


void init_video_bg(){
  zero_p();
  background(0);
  flob.setBackground(video);
}


void zero_p(){
  for(int i=0; i<p.length;i++){
    p[i].x = p[i].z = -1;
  } 
}

