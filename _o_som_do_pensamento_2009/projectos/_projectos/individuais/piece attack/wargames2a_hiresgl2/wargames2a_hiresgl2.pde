// wargames // pieceattack.tk

import com.sun.opengl.util.*;
import com.sun.opengl.util.texture.*;
import javax.media.opengl.*;
import javax.media.opengl.glu.*;
import java.nio.*;
import processing.opengl.*;

PGraphicsOpenGL pgl; 
GL gl; 
GLU glu; 
GLUT glut; 
GLUquadric gquadric; 
Texture tex[]; 
int camom = 1; 
float cx,cy,cz=2000f;//220;//=500;
float cdx,cdy;
float dstx,dsty; 
int wair = 0;
//cam bounds at dif zooms
PVector wmin20 = new PVector( 750.0f , 670.0f ,-20.0f   );
PVector wmax20 = new PVector( 7000.0f, 3000.0f ,-20.0f   );
PVector wmin1000 = new PVector( 1500.0f, 1000.0f ,1280.0f   );
PVector wmax1000 = new PVector( 5820.0f, 2600.0f ,1280.0f   );

worldcities wx; 
city c;
PVector citypos= new PVector(2500,1000,-500);
ArrayList air = new ArrayList();
atmosphere atmos = new atmosphere();
Explosoes explosoes; 
incendiario incendios;

boolean RECORDING = false;

void setup(){
  size(screen.width,screen.height,OPENGL);
//  size(3840,2160,OPENGL);
//  size(2560,1440,OPENGL);
//  size(2048,1024,OPENGL);
//  size(2048,2048,OPENGL);
//  size(4096,2048,OPENGL);
//  size(4096,2048,OPENGL);
//  size(2048,1024,OPENGL);
//  size(4096,1024,OPENGL);
  perspective( radians(50.0f), float(width)/float(height), 0.01, 10000.0f   );
  pgl = (PGraphicsOpenGL)g;
  glu = pgl.glu;
  glut = new GLUT();
  gquadric =  glu.gluNewQuadric();

  tex = new Texture[3];

  try { 
    tex[0]=TextureIO.newTexture(new File(dataPath("eee2048a.png")),true);
  }  
  catch(Exception e) { 
    println(e); 
  }  

  String dta[] = new String[3];
  dta[0] = "lisboa";
  dta[1] = "pt";
  dta[2] = "eu";
  citypos = new PVector(2500,1000,-495);
  c = new city(citypos,dta);

  wx = new worldcities();
  explosoes = new Explosoes();  
  incendios = new incendiario();
}


void draw(){

  draw_hires();
  
//  
//  gl = pgl.beginGL();
//  // glu =pgl.glu;
//  gl.setSwapInterval(1); // vsync
//  //  gl.glClearColor(0.1f,0.1f,0.1f,0.1f);
//  gl.glClearColor(0.f,0.f,0.f,0.1f);
////  gl.glClear( GL.GL_COLOR_BUFFER_BIT | GL.GL_DEPTH_BUFFER_BIT);
//   gl.glClear(  GL.GL_DEPTH_BUFFER_BIT);
//  //  gl.glMatrixMode (GL.GL_MODELVIEW);
//  //  gl.glLoadIdentity();
//
//  gl.glDepthMask(false);
//
//
//  float dx=0,dy=0;
//  if(camom==0) {
//    //cam mouse
//    dx = mouseX-width/2;
//    dy = mouseY-height/2;
//    float d = abs(dx)+abs(dy);
//    if(d>250){
//      float f = 0.01;
//      cx = (1.0f-f)*cx + f*(cx+dx);
//      cy = (1.0f-f)*cy + f*(cy+dy);
//    }
//
//    float Zf = 1.5f;
//    if(mousePressed){
//      if(mouseButton==LEFT)
//        cz+=Zf;//0.1;
//      else
//        cz-=Zf;//0.1; 
//    }
//  }
//
//  if(camom==1){
//
//    if(wair < air.size()){
//      airborn ab = (airborn) air.get(wair);
//      dstx = ab.now.x;
//      dsty = ab.now.y;
//    }
//    float f = 0.01;
//    cx = (1.0f-f)*cx + f*(dstx);
//    cy = (1.0f-f)*cy + f*(dsty);   
//    float Zf = 1.5f;
//    if(mousePressed){
//      if(mouseButton==LEFT)
//        cz+=Zf;//0.1;
//      else
//        cz-=Zf;//0.1; 
//    }
//
//  }
//
//  // cam bounds
//  float zpct = map(cz,wmin20.z,wmax1000.z,0.,1.);
//  boolean side = zpct > 0.5 ? true : false;
//  PVector bmin = interp(wmin20,wmin1000,zpct);
//  PVector bmax = interp(wmax20,wmax1000,zpct);
//
//  if(cx <= bmin.x)   cx = bmin.x; 
//  if(cy <= bmin.y)   cy = bmin.y; 
//  if(cz <= bmin.z)   cz = bmin.z; 
//  if(cx >= bmax.x)   cx = bmax.x; 
//  if(cy >= bmax.y)   cy = bmax.y; 
//  if(cz >= bmax.z)   cz = bmax.z; 
//
//
//  //  camera(cx,cy,cz,cx-dx*0.52,cy+dy*0.52,-500,0,1,0);
//  camera(cx,cy,cz,cx-dx*0.25,cy+dy*0.25,-500,0,1,0);
//
//
//  c.pos.set(cx,cy,-495);
//
//  //  gl.glEnable( GL.GL_DEPTH_TEST ) ;
//  gl.glDisable( GL.GL_DEPTH_TEST ) ;
//  //  gl.glEnable( GL.GL_BLEND ) ;
//  //  gl.glBlendFunc(GL.GL_ONE_MINUS_SRC_ALPHA,GL.GL_SRC_ALPHA); 
//  //
//  gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE_MINUS_SRC_ALPHA);
//  gl.glEnable( GL.GL_BLEND ) ;
//
//  float qdx = 2000.0f;
//  float qdy = 1000.0f;
//  gl.glColor4f(0.0,0.0,0.0, 0.37f);//0.43f);//0.27);//0.52f);
//  gl.glBegin(GL.GL_QUADS);
//  gl.glVertex3f(cx - qdx, cy - qdy , cz - 10.0f );  
//  gl.glVertex3f(cx + qdx, cy - qdy , cz - 10.0f );  
//  gl.glVertex3f(cx + qdx, cy + qdy , cz - 10.0f );  
//  gl.glVertex3f(cx - qdx, cy + qdy , cz - 10.0f );  
//  gl.glEnd();
//
//
////  gl.glEnable(GL.GL_ALPHA_TEST); 
//////  gl.glAlphaFunc(GL.GL_LESS, 0.05);//0.77);//0.1);//0.5); 
////  gl.glAlphaFunc(GL.GL_LESS, 0.755);//0.77);//0.1);//0.5); 
//
//  gl.glPushAttrib(GL.GL_COLOR_BUFFER_BIT | GL.GL_ENABLE_BIT);
//  gl.glHint(GL.GL_LINE_SMOOTH_HINT, GL.GL_NICEST);
//  gl.glEnable(GL.GL_LINE_SMOOTH);
//
//  gl.glEnable( GL.GL_BLEND ) ;
//    gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE); 
// // gl.glBlendFunc(GL.GL_ONE,GL.GL_SRC_ALPHA); 
//
////  lights();
//  tex[0].bind();   
//  tex[0].enable();   
//
//
//
//  //  for(int i=0; i<cups.length; i++)
//  //    cups[i].render();
//
//
//  ////
//
//  int divx = 4;
//  int divy = 1;
//  float dimx = 7500;
//  float dimy = 3750;//2812;
//  float zpos = -500;
//
//  gl.glColor4f( 1.0f, 1.0f, 1.0f,0.75f);//0.91f);//1.0f);///0.71f);  
//  gl.glBegin(GL.GL_QUAD_STRIP);  
//  gl.glNormal3f( 0.0f, 0.0f, 1.0f); 
//
//  for(int j=0; j<divy; j++){
//    for(int i=0; i<divx; i++){
//      float xx = ((float) i / (float) (divx-1) );//* 2.0) ;//% 1.0f;
//      float y0 = (float) j / (float) (divy);
//      float y1 = (float) (j+1) / (float) (divy);
//
//
//      float tu = xx > 1.0f ? xx-1.0 : xx;
//
//      gl.glNormal3f( 0.0f, 0.0f, 1.0f); 
//      gl.glTexCoord2f(tu, y0);    
//      gl.glVertex3f(xx*dimx, y0*dimy, zpos );  
//      gl.glNormal3f( 0.0f, 0.0f, 1.0f); 
//      gl.glTexCoord2f(tu, y1);    
//      gl.glVertex3f(xx*dimx, y1*dimy, zpos);  
//
//    }
//  }  
//
//  gl.glEnd();   
//
//
//  tex[0].disable(); 
//
//
//  for(int i=0; i<air.size();i++){
//    airborn a = (airborn) air.get(i);
//    a.fly(); 
//    a.justdraw();
//    if(!a.active){
//
//      int num = (int) random(10,100);
//      explosoes.bang(a.fim, num);
//      dstx = 0.3*dstx + a.fim.x*0.7;
//      dsty = 0.3*dsty + a.fim.y*0.7;
//
//      incendios.gas(a.cfim);     
//      a.cfim.hitcount++;
//      air.remove(i);
//      i--;
//      wx.citynum = wx.citytarget; 
//
//      if(wair==i) ///dri: z<<
//        wair = (int) random(air.size());
//
//
//    }
//
//
//  }
//
//  //  c.draw();
//  wx.draw();
//
//  explosoes.explode();
//  incendios.arde();
//
//  float tal = 0.01f + (cos(frameCount*0.027)*0.25 + 0.25);
//  float tal1 = tal + random(-0.02, 0.02);
//
//  int txtx =-50;//-90;//-400;
//  int txty = 221;//210;// +250;//-100; 
//  gl.glColor4f(1f,1f,1f,tal);//0.01f);
//  gl.glRasterPos3i(int(5+cx+txtx),int(10+cy+txty), int(cz-500));
//  //  glut.glutBitmapString(glut.BITMAP_9_BY_15, "Hello tea "+frameRate+"\n \r f slowdown");
//  //  glut.glutBitmapString(glut.BITMAP_9_BY_15, "Hello tea "+frameRate);
//  glut.glutBitmapString(glut.BITMAP_HELVETICA_12, "W A R G A M E S  http://pieceattack.tk ");//+cx+" "+cy+" "+cz);
//  gl.glRasterPos3i(int(6+cx+txtx),int(11+cy+txty), int(cz-500));
//  gl.glColor4f(0f,0f,1.0f,tal1);//0.1f);
//  glut.glutBitmapString(glut.BITMAP_HELVETICA_12, "W A R G A M E S  http://pieceattack.tk ");//+cx+" "+cy+" "+cz);
//  //  gl.glRasterPos3i(int(5+cx+txtx),int(25+cy+txty), int(cz-500));
//  //  glut.glutBitmapString(glut.BITMAP_9_BY_15, "slow "+slow);
//  //  gl.glRasterPos3i(int(5+cx+txtx),int(40+cy+txty), int(cz-500));
//  //  glut.glutBitmapString(glut.BITMAP_9_BY_15, ""+cx+" "+cy+" "+cz);
//
//  atmos.helios();
//
//  pgl.endGL();
//  gl.glFlush();
//  
//  if(RECORDING){
//   
//   saveFrame("wargames-"+frameCount+".png"); 
//    
//  }
}



void keyPressed(){
  //  if(key=='f')
  //    slow^=true;


  if(key=='R')
    HIRESSAVE = true;

  if(key=='r')
    RECORDING^=true;

  if(key=='a'){
    wx.add(c);
  }
  if(key=='A'){
    wx.write();
  }


}



PVector interp(PVector a, PVector b, float f){
  float f1 = 1.0f - f;
  PVector r = new PVector();
  r.x = a.x*f1 + b.x*f;
  r.y = a.y*f1 + b.y*f; 
  r.z = a.z*f1 + b.z*f;   
  return r;
}











