
/// time rain, andré sier
/// som do pensamento 2009

import processing.video.*;
import processing.opengl.*;
import javax.media.opengl.*;
import javax.media.opengl.glu.*;
import java.nio.*;
import processing.opengl.*;
import s373.flob.*;
import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddress netziggy7,netziggy3,netself;

// cam vars
PImage frames[];
Capture cam;
int time = 250;//50;///10*30;//10seg@30pfs frames
int timehead;

Flob flob;

// planes vars
plane p[];
int np = 100;

PGraphicsOpenGL pgl; 
GL gl; 
GLU glu; 

float velx=0,vely=0;
float globalvx=0,globalvy=0;
float globalvelx=0,globalvely=0;



// comented for 0135a compile
static public void main(String args[]) {
  PApplet.main(new String[] { 
    "--present", 
    "--bgcolor=#000000",
//    "--stop-color=#000000",   
//    "--exclusive",
    "ziggy_time_rain_2a_sender_a"   }
  );
}





void setup(){
  //bug 882 processing 1.0.1
//  try { 
//    quicktime.QTSession.open(); 
//  } 
//  catch (quicktime.QTException qte) { 
//    qte.printStackTrace(); 
//  }

  size(1024,768);//,OPENGL);
  frameRate(25);
  // init video buffer
  frames = new PImage[time];
  for(int i=0;i<frames.length;i++){
    frames[i] = new PImage(128,128); 
  }
  // init cam
  cam = new Capture(this,128,128,25);
  flob = new Flob(this,cam,width,height);
  flob.setMirror(true,false);
  flob.setOm(1);
  flob.setTresh(10);
  flob.setFade(16);//25);


  // init planes
  p = new plane[np];
  for(int i=0;i<p.length;i++){
    p[i] = new plane(); 
    if(random(1)<0.5)
      p[i].respawn=true;
    if(random(1)<0.5)//0.01)
      p[i].active=true;
  }

  // a perspectiva defeito do opengl
  //  float fov = PI/3.0;
  //  float cameraZ = (height/2.0) / tan(PI * fov / 360.0);
  //  perspective(fov, float(width)/float(height), 
  //  0.001, 10000.0);//cameraZ/10.0, cameraZ*10.0);

  perspective( radians(50.0f), float(width)/float(height), 0.01, 50000.0f   );  
  pgl = (PGraphicsOpenGL)g;
  glu = pgl.glu;

  rectMode(CENTER);


  /// networks

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,7777);
  /* write messages at port 12001 in self ip */
  netself = new NetAddress("127.0.0.1",7777);
  netziggy7 = new NetAddress("10.0.10.7",7777);//("192.168.0.7",7777);
  netziggy3 = new NetAddress("10.0.10.3",7777);


}


//////////////////////////////////////////////////////



void draw(){

  if(cam.available()){

    background(0);
    cam.read(); 
    flob.calcsimple(flob.binarize(cam));

    if(frameCount%30==0){//mousePressed) {
      timehead = (timehead + 1) % frames.length;
      //      frames[timehead].copy(cam,0,0,320,240,0,0,320,240);
      frames[timehead].copy(cam,0,0,128,128,0,0,128,128);
    }


    gl = pgl.beginGL();
    glu =pgl.glu;
    //  gl.setSwapInterval(1); // vsync
    //  gl.glClearColor(0.1f,0.1f,0.1f,0.1f);
    gl.glClearColor(0.f,0.f,0.f,0.1f);
    gl.glClear( GL.GL_COLOR_BUFFER_BIT | GL.GL_DEPTH_BUFFER_BIT);
    gl.glDepthMask(false);

    gl.glDisable( GL.GL_DEPTH_TEST ) ;
    //  gl.glEnable( GL.GL_BLEND ) ;
    //  gl.glBlendFunc(GL.GL_ONE_MINUS_SRC_ALPHA,GL.GL_SRC_ALPHA); 
    //
    gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE);
    gl.glEnable( GL.GL_BLEND ) ;

    tint(255,50);
    image(flob.getSrcImage(),190,120,1700,1300);


    //noStroke();

    for(int i=0;i<p.length;i++){
      p[i].render(); 
    }

  }

  pgl.endGL();


  /// update

  float vx=0,vy=0;

  for(int i=0; i<flob.getNumBlobs();i++){
    trackedBlob ab = flob.getTrackedBlob(i);
    fill(0,70);
    stroke(255,10);
    rect(ab.cx, ab.cy, ab.dimx, ab.dimy);
    float m = 10000f;
    vx+=ab.velx*m;
    vy+=ab.vely*m;
  }


  globalvx=vx;
  globalvy=vy;


  float fdown = 0.052;
  float fup = 0.172;
  float f=0;

  if(velx < vx)
    f = fdown;
  else
    f = fup;
  velx = velx * (1f-f) + vx * f;
  if(vely < vy)
    f = fdown;
  else
    f = fup;

  vely = vely * (1f-f) + vy * f;

  globalvelx=velx;
  globalvely=vely;



  stroke(255,100);
  float cx = width/2; 
  float cy = height/2;
  line(cx,cy,cx+vx,cy+vy);
  stroke(100,170,100,150);
  line(cx,cy,cx+velx,cy+vely);



  float dev = (abs(vx)+abs(vy)) * 0.1;

  for(int i=0;i<p.length;i++){
    if(p[i].y<2400)
      p[i].setAcc(dev);//(velx,vely, dev); 
    else
      p[i].setAccUp(velx*0.021,vely*0.055,dev*2.1);//(0,0, 0); 
  }


}


//////////////////////////////////////////////////////


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/")==true) {
    
    float data[] = new float[7];
    for(int i=0; i<7; i++)       
      data[i] = theOscMessage.get(i).floatValue();
      
    println("received network");    
    println(data);
    
    // generating new plane
    for(int i=0; i<p.length;i++)
      if(!p[i].active){
        p[i].generate(data);
        break;
      }
   
  }

}


//////////////////////////////////////////////////////


void keyPressed(){
  if (key=='s'){
    saveFrame("timerain2-#####.jpg");
  }  
}



