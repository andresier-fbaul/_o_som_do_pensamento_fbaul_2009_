import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 
import processing.video.*; 
import s373.flob.*; 

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

public class video_flob_draw_5_syspart_exe1 extends PApplet {

/*

pedro jesus 
pedrohcj89@hotmail.com

  multi touch camera draw sketch
 with particle systems
 
 exerc\u00edcio_criar uma composi\u00e7\u00e3o gr\u00e1fica \u00e0 base
 de sistemas de part\u00edculas, reconhecimento de imagem,
 usando em cada part\u00edcula a imagem do video,
 fazendo a vida da particula crescer as dims do video,
 ou rodando as imagens nos eixos x y. dessa composi\u00e7\u00e3o
 devem gravar umas frames que depositam na \u00e1rea p\u00fablica
 de transfer\u00eancia
 
 */





/// vars
Capture video;
Flob flob; 
int timeout=0;
/// video params
int TRESH = 5;       //adjust treshold value here or keys t/T!!
int videores=128;
boolean drawimg=false; // key 'i' toggles draw


//cada sistema de particulas agora mantem posi\u00e7\u00f5es actuais e anteriores
SysPart sp[];
int cores[] = { 0xffE86528, 0xff08FFF9, 0xff0885FF, 0xff4408FF, 0xffFF087B ,
                  0xff40FF08, 0xff08FFD4, 0xff51607C, 0xffB7DCE3, 0xffC6FFC1};



/// program
public void setup(){
  //bug 882 processing 1.0.1
  try { 
    quicktime.QTSession.open(); 
  } 
  catch (quicktime.QTException qte) { 
    qte.printStackTrace(); 
  }

  size(1200,700,OPENGL);
  frameRate(25);
  // init video data and stream
  video = new Capture(this, videores, videores, 25);  

  // init blob tracker
  flob = new Flob(this, video); 
  flob.mirrorX(true); 
  flob.setTresh(TRESH);

  flob.setOm(flob.CONTINUOUS_DIFFERENCE); 
  background(0);

  sp = new SysPart[10];
  for(int i=0; i < sp.length; i++){    
    int c = cores[(int)random(cores.length)]; // escolher uma cor aleat\u00f3ria da array de cores    
    sp[i] = new SysPart((int)random(50,200),width/2,height/2, c); //num parts, centerx, centery, cor
  }

}



public void draw(){
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

  for(int i=0; i < sp.length; i++) {
    sp[i].update();
    sp[i].draw(); 
  }

    //get and use the data
    int numblobs = flob.getNumBlobs(); 
    if(numblobs>0) { 
      float centermass[] = new float[3];
 
      for(int i = 0; i < numblobs; i++) {
        centermass = flob.getCentroidPixelcount(i);
        int numsys = (int)constrain(i,0,sp.length);
        println(""+centermass[0]+" "+centermass[1]);
        sp[numsys].setPosForce(centermass[0],centermass[1]);
        sp[numsys].reIgnite();  

      }







    }

  }

}

public void keyPressed(){
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


public void init_video_bg(){
  background(0);
  flob.setBackground(video);
}





class Part{

  float px,py, ppx,ppy;
  float energy,energy_dec;
  float rad;

  float vx,vy; //vel
  float f; //friction
float rdm = random (0.5f,6);
  float gravity; //gravidade, for\u00e7a no eixo dos y
  float fx,fy; //for\u00e7a nos eixos
  int col;

  Part(float x,float y){
    px = ppx = x;
    py = ppy = y;
    energy = 255.f; 
    energy_dec = random(20,30);//random(10.9,20.);
    rad = random(10,20);
    make_rnd_normalized_velocity(1.f);
    f = 0.9f;
    gravity = 0.9f;
    col = color( 232, random(100,152), 40); //reddishes
  }

  Part(float x,float y,int c){
    this(x,y);
    col = c;
  }

 public void make_rnd_velocity(float force){
    
     vx = random(-force,force);  
     vy = random(-force,force);  
    
  }


  public void make_rnd_normalized_velocity(float force){
    vx = random(-1,1);
    vy = random(-1,1);
    //normalizar, dividir cada componente pelo comprimento do vector
    float len = sqrt(vx*vx+vy*vy);
    if(len>0.f){
     vx = vx / len;
     vy = vy / len; 
     vx *= force;
     vy *= force;
    }
    
  }
  
  public void setPos(float x, float y){
   px = ppx = x;
   py = ppy = y; 
  }

  public void setPosForce(float x, float y, float fx, float fy){
   px = ppx = x;
   py = ppy = y; 
   this.fx = fx;
   this.fy = fy;
  }
  
  public void update(){
    //store pos
    ppx = px;
    ppy = py;
   //update velocity
   vy = vy + gravity ;
   vx = vx + fx;
   vy = vy + fy;
   //friction = vel * friction
   vx = vx * f;
   vy = vy * f;
   // position = pos + vel
   px = px + vx;
   py = py + vy;
   // energy
   energy = energy - energy_dec;
  }

  public void draw(){
    
//    stroke(col, (int)energy);
//    line(ppx,ppy,px,py);
    
int t = (int)(energy * 0.5f*rdm);
int tt = (int)(energy * 0.2f*rdm);
      
      rotate(0.5f);
      
      fill (243,44,44,255);
      stroke (255,255,255);
    image(video,px,py,t,tt);

  }

}

class SysPart{

  Part  p[]; // a array de part\u00edculas
  float cx,cy; // o centro
  float prevx,prevy;
  float cdev = 20; //desvio do centro
  float fx,fy; // uma for\u00e7a

  SysPart(int num, float x, float y){
    p = new Part[num];
    cx = x; 
    cy = y;
    for(int i=0; i<p.length;i++){
      p[i] = new Part(x+ random(-cdev,cdev),y+ random(-cdev,cdev)); 
    }
  } 

  SysPart(int num, float x, float y, int c){
    p = new Part[num];
    cx = x; 
    cy = y;
    for(int i=0; i<p.length;i++){
      p[i] = new Part(x+ random(-cdev,cdev),y+ random(-cdev,cdev), c); 
    }

  }

  public void setPos(float x, float y){
    cx = x;
    cy = y; 
  }

  public void setPosForce(float x, float y){

    prevx = cx;
    prevy = cy;
    cx = x;
    cy = y; 
    this.fx = (x - prevx)*0.05f;
    this.fy = (y - prevy)*0.05f;
  }

  public void reIgnite(){

    for(int i = 0; i < p.length; i++) {
      if(p[i].energy < 0){
        p[i].setPosForce(cx,cy,fx,fy); //novo centro, nova for\u00e7a
        p[i].energy = 255;  //energia a 255 de novo
        float force = (abs(fx)+abs(fy) * 10) + 10;
        p[i].make_rnd_velocity(force);//random(2,5));
      } 
    }

  }

  public void update(){

    for(int i = 0; i < p.length; i++) {
      if(p[i].energy > 0)
        p[i].update();

    }

  }


  public void draw(){

    for(int i = 0; i < p.length; i++) 
      if(p[i].energy > 0)
        p[i].draw();

  }


}





  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#c0c0c0", "video_flob_draw_5_syspart_exe1" });
  }
}
