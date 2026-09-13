import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 
import processing.video.*; 
import s373.flob.*; 
import ddf.minim.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class monoflob_noise3a extends PApplet {

/*
  flob mono_me
  
  as, 20090621
 
 */






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



public void setup(){
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



public void draw(){

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
    ellipse(ab.cx,ab.cy,ab.dimx*0.5f,ab.dimy*0.5f);

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


public void keyPressed(){
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





class Monoflob{
  //Botao b[];
  BotaoAudio b[];
  int cores[];
  int gx,gy,num;
  float dimx,dimy;
  float sizex,sizey;//1.0 max
  
  Monoflob(int _gx, int _gy){
    gx = _gx;
    gy = _gy;
    sizex = 0.75f;
    sizey = 1.0f;//0.55;
    float stridex = (float)width / (float)gx;
    float stridey = (float)height / (float)gy;
    dimx = stridex * sizex ;
    dimy = stridey * sizey ;
    
    num = gx * gy;    
    //b = new Botao[num];   
    b = new BotaoAudio[num];
    
    cores = new int[num];
    cores[0] = color (255);
    cores[1] = color (250,86,176);
    cores[2] = color (234,7,7);
    cores[3] = color (49,19,0);
    cores[4] = color (0,5,227);
    cores[5] = color (196,0,227);
    cores[6] = color (81,2,108);
    cores[7] = color (170,170,170);
    

    for(int i=0; i<num;i++){
      //RAIO DEPENDE DA ORDEM DOS BOTOES - 0 para 7 (varia entre 20 a width-40)
       float size = map(i,0,num-1, 125, 768);//i*(width-40)/(num-1) +200;
       
       //TODOS os botoes sao desenhados a partir do centro
       
       
       //float x =  ((float)(i % gx) +0.5) * stridex  ;
       //float y = ((float)(i / gx) +0.5) *stridey ;
       //b[i] = new Botao(i, x,y,dimx,dimy,cores[i] );  
       b[i] = new BotaoAudio(i, width/2, height/2, size, size, cores[i]);    
    }        
        
  }
  
  public int touch(float x, float y,float w, float h){    
    int who = -1;
    
    for(int i=0; i<num; i++){
      
      if(b[i].test(x,y,w,h)){
        who = i;
        break;
      }    
    }
    
    return who;
  }

  public void render(){
    println("render");
    for(int i=num-1; i>=0; i--)
        b[i].render();
    //for(int i=0; i<num; i++)
      //b[i].render();   
  }


}

class Botao {
  int id;
  float x, y, w, h,w2,h2;
  int coroff,coron;
  int gain; 
  boolean on = false;
  boolean touch = false;
  

  Botao(int i,  float _x, float _y, float _w , float _h , int c) {
    id = i;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    w2 = w*0.5f;
    h2 = h*0.5f;    
    coroff = color(255);
    coron = c;//color(255);2
    //println("--new botao "+i+" "+_x+" "+_y+" "+_w+" "+coron);
  } 


  public boolean test(float _x, float _y, float dimx, float dimy) {
    float dx = x - _x;
    float dy = y - _y;
    if(abs(dx) <= (w2+dimx*0.25f) && abs(dy) <= (h2+dimy*0.25f)){
      gain++;  
      touch = true;
    }
    return touch;
  }

  public void state(){
    if(touch)
      touch=false;
    else
      gain--;
      
     if(gain == 99) {
      on = false;
      gain = 49;
     }
      
    if(gain>50){
      gain = 100;
      on = true; 
    }
    /*
    if(gain<50)
      on = false;*/
    if(gain<0)
      gain=0;
  }
  
  public void render(){
    state();
    noFill();
    int c0 = on ? coron : coroff;
  //  int c1 = on ? coroff : coron;
    //stroke(c0,map(gain,0,100,10,255));
    fill(c0,0);  
    stroke(41,41,41);  
    ellipse(x,y,w,h);
    fill(255);
    text(""+gain,x,y);
    text(""+id,x,y+h2-2);

//  void render(){
//    state();
//    //int c0 = on ? coron : coroff;
//  //  int c1 = on ? coroff : coron;
//  int c0 = coron;
//    stroke(41,41,41);
//    //tirar a cor dos botoes:
//    fill(c0,0/*map(gain,0,100,10,255)*/);    
//    ellipse(x,y,w,h);
//    fill(255);
//    text(""+gain,x,y);
//    text(""+id,x,y+50);
  }

}


// o botao audio tem tudo o q o botao normal tem, 
// mas vai ter mais a parte de gerir audio

class BotaoAudio extends Botao{

  float vol;
  AudioPlayer  sndplayer;


  BotaoAudio(int i,  float _x, float _y, float _w , float _h, int _c){
    super(i,_x,_y,_w,_h, _c); //construtor botao normal
    //carregar audio, converter o id para nome do ficheiro
    sndplayer= minim.loadFile(audiofiles[i], 2048);
    sndplayer.pause();
    sndplayer.setGain(0);
  }



  public boolean test(float _x, float _y, float dimx, float dimy) {
    float dx = x - _x;
    float dy = y - _y;
    
    float d = sqrt(dx*dx+dy*dy);
    
    if( d < ( w2 )) {     //abs(dx) <= (w2+dimx*0.25) && abs(dy) <= (h2+dimy*0.25)){
      gain++;  
      touch = true;
    }
    return touch;
  }


  // overloading state to handle sound here
  public void state(){
  //   float newvol = map(gain, 0, 100, -100, 0);//map(gain, 0, 100, -50, 10); // os vols minim est\u00e3o em dbs de -100 a 0
    float f = 0.12f;//0.12; //lowpass para suavizar..
    //println("newvol="+newvol);
    if(touch && !sndplayer.isPlaying() && gain > 1) {
//      vol = 0;//newvol;//f*newvol+(1f-f)*vol;
//      sndplayer.setGain(vol);   //\u00e9 s\u00f3 isto!
  //    println(vol);
    sndplayer.rewind();
      sndplayer.play();
      
    }
    
    if (!touch && !sndplayer.isPlaying() ) {
      sndplayer.rewind();
      sndplayer.pause();
      
      //estes if's definem o modo como o sons tocam: dura\u00e7\u00e3o, play quando .. 
    }
    
       super.state();// first calc state from botao, then use vars to scale audio amp


  }

}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--hide-stop", "monoflob_noise3a" });
  }
}
