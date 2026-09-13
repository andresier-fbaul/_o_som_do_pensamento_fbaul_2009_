// flob simple 001k+ version



import processing.opengl.*;
import processing.video.*;
import s373.flob.*;


Capture video;
Flob flob; 

/// flob video params
int thresh = 16;           //adjust treshold value <keys t/T>
int fade = 5;              //adjust fade value (in om 1) <keys f/F>
int videores=128;          //adjust camera & tracker image size
int videotex = 0;          //(0=videoimg,1=videotexbin,2=videotexmotion,3=videoteximgmotion)

String info="";
PFont font;




void setup(){
  //bug 882 processing 1.0.1
  try { 
    quicktime.QTSession.open();  
  } 
  catch (quicktime.QTException qte) {  
    qte.printStackTrace();  
  }


  size(700,500,OPENGL);

  frameRate(30);
  rectMode(CENTER);


  String dev[] = Capture.list();
  println(dev);

  // init video data and stream
  video = new Capture(this, videores, videores,dev[5], 30);  

  // init blob tracker
  // flob = new Flob(this, video); 
  flob = new Flob(this, video, width,height); // new: pass in width and height of scene, get values in those ranges

  flob.setThresh(thresh);
  flob.setSrcImage(videotex);

  //new:
  flob.setBlur(2);
  flob.setMirror(true,false);
  flob.setOm(0);//static
  //flob.setOm(1);//continuous

  font = createFont("arial",16);
  textFont(font);
}



void draw(){

  // main image loop
  if(video.available()) {
    video.read();
    flob.track(flob.binarize(video));   //o metodo é track e não calc   
  }

  //  background(0);
  image(flob.updateVideoTex(), 0, 0, width, height);


  int nb = flob.getNumTrackedBlobs();

  for(int i=0; i<nb;i+=2){

    trackedBlob tb1 = flob.getTrackedBlob(i); 
    trackedBlob tb2 = flob.getTrackedBlob(i+1); 

    // now access all these fields. 
    // pos & vel & dim results are local world coords
    // int tb.id; // float tb.cx; // float tb.cy;// float tb.velx;
    // float tb.vely;// float tb.prevelx;// float tb.prevely;// int tb.presencetime;
    // float tb.dimx;// float tb.dimy;// int tb.birthtime;


    float din1, din2=0;

    din1 = tb1.velx*tb1.velx + tb1.vely*tb1.vely;

    if(tb2!=null){

      line (tb1.cx, tb1.cy, tb2.cx, tb2.cy); 

      din2 = tb2.velx*tb2.velx + tb2.vely*tb2.vely;

    }

 
     println("blob "+i+" din1: "+din1);
    println("blob "+i+1+" din2: "+din2);


  }




}

