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
boolean drawimg=true; // key 'i' toggles draw
/// vars required pd-processing
float audio;
int b1,b2;
int numblobs;

int state;


SysPart sys[];
//SysPart sp;


int px,py,ppx,ppy;
PFont font;
//int numblobs;

String texto1[]={"caos", "caos"}; //= loadStrings("1.txt");//
String texto2[]={"quiet", "quiet"};// = loadStrings("3.txt");
String texto3[] = {"safespot","safespot"}; 




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
  frameRate(15);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  /* write messages at port 12001 in self ip */
  myRemoteLocation = new NetAddress("127.0.0.1",12001);

  texto1=  loadStrings("3.txt");
//  texto1 ={"t1", "t1"};
 texto2 =loadStrings("1.txt");
//  texto2+="t2";

  println("texto1-----");
  println(texto1);
  println("texto2-----");
  println(texto2);


  // init sysparts

  //     sp = new SysPart(10,width/2,height/2); //num parts, centerx, centery 

  sys = new SysPart[3];
  for(int i=0; i<sys.length;i++){
    //      SysPart(int _id, int num, float x, float y, String[] txtraw)
    String txt[] = (i==0?texto1:(i==1?texto2:texto3));
    sys[i] = new SysPart ( i, 10, width/2f, height/2f,  txt   ) ;
  }


  // init video data and stream
  video = new Capture(this, videores, videores, 25);  

  // init blob tracker;
//  tem de ser o novo flob
  flob = new Flob(this, video, width, height); 
  //flob.mirrorX(true); 
  flob.setThresh(TRESH);

  flob.setOm(flob.CONTINUOUS_DIFFERENCE); 
  background(255);

  font = createFont(PFont.list()[22], 200);
  textFont(font,125);


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
  }


    //write test image to frame
    if(drawimg)
      image(video, 0, 0, width, height);
    //      image(flob.videotex, 0, 0, width, height);


    noStroke();
    fill(0,20);
    rect(0,0,width,height);


    // isto deve ser feito depois do calculo das  blobs
    //    sp.update();
    //    sp.draw(); 


    // largest blob tracking code----------------

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
      px = (int)(centermass[0]);//*width);
      py = (int)(centermass[1]);//*height);
      
    }

        // calcular o systema a apresentar, dependendo do num blobs----------------

       state = 0;

      if(numblobs < 2)
        state = 2;//sp.setTexto(texto1);
      else if(numblobs >= 2 && numblobs < 4)
        state = 1;//sp.setTexto(texto2);
      else if(numblobs >=4) 
        state = 0; //sp.setTexto(texto3);


       // calcular este syspart

      if(state==2){
        int n = (frameCount*2)%width;
      sys[state].setPosForce(n,height/2,n,height/2, random(0.05,0.5) );
        
      }else
      sys[state].setPosForce(px,py,ppx,ppy, random(0.05,0.5) ); // força alea
      sys[state].update();
      sys[state].draw();


//        // ou
//        // pass points as forces to sysparts----------------
//        // update & draw alll sys----------------
//
//        for(int i=0; i<sys.length; i++) {        
//          sys[i].setPosForce (px,py,ppx,ppy, random(0.05,0.5));//inclui a força a incrementar como parâmetro
//          sys[i].update();
//          sys[i].draw();
//        }
//
     



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






