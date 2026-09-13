import processing.core.*; 
import processing.xml.*; 

import com.sun.opengl.util.*; 
import com.sun.opengl.util.texture.*; 
import javax.media.opengl.*; 
import javax.media.opengl.glu.*; 
import java.nio.*; 
import processing.opengl.*; 

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

public class wargames022 extends PApplet {

// wargames // pieceattack.tk








PGraphicsOpenGL pgl; 
GL gl; 
GLU glu; 
GLUT glut; 
GLUquadric gquadric; 
Texture tex[]; 
int camom = 1; 
float cx,cy,cz=2000f;//220;//=500;
float dstx,dsty,dstz; 
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

public void setup(){
  size(screen.width,screen.height,OPENGL);
  frameRate(30);
  perspective( radians(50.0f), PApplet.parseFloat(width)/PApplet.parseFloat(height), 0.01f, 10000.0f   );  
  pgl = (PGraphicsOpenGL)g;
  glu = pgl.glu;
  glut = new GLUT();
  gquadric =  glu.gluNewQuadric();

  tex = new Texture[3];

  try { 
    tex[0]=TextureIO.newTexture(new File(dataPath("eee-pieceattack.png")),true);
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
  
  noCursor();
}


public void draw(){

  gl = pgl.beginGL();
  // glu =pgl.glu;
  gl.setSwapInterval(1); // vsync
  //  gl.glClearColor(0.1f,0.1f,0.1f,0.1f);
  gl.glClearColor(0.f,0.f,0.f,0.1f);
//  gl.glClear( GL.GL_COLOR_BUFFER_BIT | GL.GL_DEPTH_BUFFER_BIT);
   gl.glClear(  GL.GL_DEPTH_BUFFER_BIT);
  //  gl.glMatrixMode (GL.GL_MODELVIEW);
  //  gl.glLoadIdentity();

  gl.glDepthMask(false);


  float dx=0,dy=0;
  if(camom==0) {
    //cam mouse
    dx = mouseX-width/2;
    dy = mouseY-height/2;
    float d = abs(dx)+abs(dy);
    if(d>250){
      float f = 0.01f;
      cx = (1.0f-f)*cx + f*(cx+dx);
      cy = (1.0f-f)*cy + f*(cy+dy);
    }

    float Zf = 1.5f;
    if(mousePressed){
      if(mouseButton==LEFT)
        cz+=Zf;//0.1;
      else
        cz-=Zf;//0.1; 
    }
  }

  if(camom==1){

    if(wair < air.size()){
      airborn ab = (airborn) air.get(wair);
      dstx = ab.now.x;
      dsty = ab.now.y;
      dstz = ab.now.z*1.25f + 1700;
    }
    float f = 0.01f;
    cx = (1.0f-f)*cx + f*(dstx);
    cy = (1.0f-f)*cy + f*(dsty);   
    cz = (1.0f-f)*cz + f*(dstz);
//    println(cz);
    float Zf = 1.5f;
    if(mousePressed){
      if(mouseButton==LEFT)
        cz+=Zf;//0.1;
      else
        cz-=Zf;//0.1; 
    }

  }

  // cam bounds
  float zpct = map(cz,wmin20.z,wmax1000.z,0.f,1.f);
  boolean side = zpct > 0.5f ? true : false;
  PVector bmin = interp(wmin20,wmin1000,zpct);
  PVector bmax = interp(wmax20,wmax1000,zpct);

  if(cx <= bmin.x)   cx = bmin.x; 
  if(cy <= bmin.y)   cy = bmin.y; 
  if(cz <= bmin.z)   cz = bmin.z; 
  if(cx >= bmax.x)   cx = bmax.x; 
  if(cy >= bmax.y)   cy = bmax.y; 
  if(cz >= bmax.z)   cz = bmax.z; 


  //  camera(cx,cy,cz,cx-dx*0.52,cy+dy*0.52,-500,0,1,0);
   camera(cx,cy,cz,cx-dx*0.25f,cy+dy*0.25f,-500,0,1,0);
// pgl.glu.gluLookAt( cx,cy,cz,cx-dx*0.25,cy+dy*0.25,-500,0,1,0);


  c.pos.set(cx,cy,-495);

  //  gl.glEnable( GL.GL_DEPTH_TEST ) ;
  gl.glDisable( GL.GL_DEPTH_TEST ) ;
  //  gl.glEnable( GL.GL_BLEND ) ;
  //  gl.glBlendFunc(GL.GL_ONE_MINUS_SRC_ALPHA,GL.GL_SRC_ALPHA); 
  //
  gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE_MINUS_SRC_ALPHA);
  gl.glEnable( GL.GL_BLEND ) ;

  float qdx = 2000.0f;
  float qdy = 1000.0f;
  gl.glColor4f(0.0f,0.0f,0.0f, 0.37f);//0.43f);//0.27);//0.52f);
  gl.glBegin(GL.GL_QUADS);
  gl.glVertex3f(cx - qdx, cy - qdy , cz - 10.0f );  
  gl.glVertex3f(cx + qdx, cy - qdy , cz - 10.0f );  
  gl.glVertex3f(cx + qdx, cy + qdy , cz - 10.0f );  
  gl.glVertex3f(cx - qdx, cy + qdy , cz - 10.0f );  
  gl.glEnd();


//  gl.glEnable(GL.GL_ALPHA_TEST); 
////  gl.glAlphaFunc(GL.GL_LESS, 0.05);//0.77);//0.1);//0.5); 
//  gl.glAlphaFunc(GL.GL_LESS, 0.755);//0.77);//0.1);//0.5); 

  gl.glPushAttrib(GL.GL_COLOR_BUFFER_BIT | GL.GL_ENABLE_BIT);
  gl.glHint(GL.GL_LINE_SMOOTH_HINT, GL.GL_NICEST);
  gl.glEnable(GL.GL_LINE_SMOOTH);

  gl.glEnable( GL.GL_BLEND ) ;
    gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE); 
 // gl.glBlendFunc(GL.GL_ONE,GL.GL_SRC_ALPHA); 

//  lights();
  tex[0].bind();   
  tex[0].enable();   



  //  for(int i=0; i<cups.length; i++)
  //    cups[i].render();


  ////

  int divx = 4;
  int divy = 1;
  float dimx = 7500;
  float dimy = 3750;//2812;
  float zpos = -500;

  gl.glColor4f( 1.0f, 1.0f, 1.0f,0.55f);//0.91f);//1.0f);///0.71f);  
  gl.glBegin(GL.GL_QUAD_STRIP);  
  gl.glNormal3f( 0.0f, 0.0f, 1.0f); 

  for(int j=0; j<divy; j++){
    for(int i=0; i<divx; i++){
      float xx = ((float) i / (float) (divx-1) );//* 2.0) ;//% 1.0f;
      float y0 = (float) j / (float) (divy);
      float y1 = (float) (j+1) / (float) (divy);


      float tu = xx > 1.0f ? xx-1.0f : xx;

      gl.glNormal3f( 0.0f, 0.0f, 1.0f); 
      gl.glTexCoord2f(tu, y0);    
      gl.glVertex3f(xx*dimx, y0*dimy, zpos );  
      gl.glNormal3f( 0.0f, 0.0f, 1.0f); 
      gl.glTexCoord2f(tu, y1);    
      gl.glVertex3f(xx*dimx, y1*dimy, zpos);  

    }
  }  

  gl.glEnd();   


  tex[0].disable(); 


  for(int i=0; i<air.size();i++){
    airborn a = (airborn) air.get(i);
    a.fly(); 
    if(!a.active){

      int num = (int) random(10,100);
      explosoes.bang(a.fim, num);
      dstx = 0.3f*dstx + a.fim.x*0.7f;
      dsty = 0.3f*dsty + a.fim.y*0.7f;

      incendios.gas(a.cfim);     
      a.cfim.hitcount++;
      air.remove(i);
      i--;
      wx.citynum = wx.citytarget; 

      if(wair==i) ///dri: z<<
        wair = (int) random(air.size());


    }


  }

  //  c.draw();
  wx.draw();

  explosoes.explode();
  incendios.arde();

  float tal = 0.01f + (cos(frameCount*0.027f)*0.25f + 0.25f);
  float tal1 = tal + random(-0.02f, 0.02f);

  int txtx =-50;//-90;//-400;
  int txty = 221;//210;// +250;//-100; 
  gl.glColor4f(1f,1f,1f,tal);//0.01f);
  gl.glRasterPos3i(PApplet.parseInt(5+cx+txtx),PApplet.parseInt(10+cy+txty), PApplet.parseInt(cz-500));
  //  glut.glutBitmapString(glut.BITMAP_9_BY_15, "Hello tea "+frameRate+"\n \r f slowdown");
  //  glut.glutBitmapString(glut.BITMAP_9_BY_15, "Hello tea "+frameRate);
  glut.glutBitmapString(glut.BITMAP_HELVETICA_12, "W A R G A M E S  http://pieceattack.tk ");//+cx+" "+cy+" "+cz);
  gl.glRasterPos3i(PApplet.parseInt(6+cx+txtx),PApplet.parseInt(11+cy+txty), PApplet.parseInt(cz-500));
  gl.glColor4f(0f,0f,1.0f,tal1);//0.1f);
  glut.glutBitmapString(glut.BITMAP_HELVETICA_12, "W A R G A M E S  http://pieceattack.tk ");//+cx+" "+cy+" "+cz);
  //  gl.glRasterPos3i(int(5+cx+txtx),int(25+cy+txty), int(cz-500));
  //  glut.glutBitmapString(glut.BITMAP_9_BY_15, "slow "+slow);
  //  gl.glRasterPos3i(int(5+cx+txtx),int(40+cy+txty), int(cz-500));
  //  glut.glutBitmapString(glut.BITMAP_9_BY_15, ""+cx+" "+cy+" "+cz);

  atmos.helios();

  pgl.endGL();
 // gl.glFlush();
  
  if(RECORDING){
   
   saveFrame("wargames-"+frameCount+".png"); 
    
  }
}



public void keyPressed(){
  //  if(key=='f')
  //    slow^=true;

  if(key=='r')
    RECORDING^=true;

  if(key=='a'){
    wx.add(c);
  }
  if(key=='A'){
    wx.write();
  }


}



public PVector interp(PVector a, PVector b, float f){
  float f1 = 1.0f - f;
  PVector r = new PVector();
  r.x = a.x*f1 + b.x*f;
  r.y = a.y*f1 + b.y*f; 
  r.z = a.z*f1 + b.z*f;   
  return r;
}











class Explosoes{
  ArrayList e = new ArrayList();

  Explosoes(){
  };
  public void explode(){
    for(int i=0; i<e.size();i++){
      ExploPart ep = (ExploPart) e.get(i);
      ep.go();
      if(ep.life<0){
        e.remove(i);
        i--;
      }
    } 
  }

  public void bang(PVector p, int num){
    for(int i=0;i<num;i++){
      ExploPart ep = new ExploPart (p);
      e.add(ep);
    }
      
      ExploPart ep = new ExploPart (p);
      ep.grow=true;
      ep.maxal=random(0.5f,1.5f);
      e.add(ep);
   
  }


}


class ExploPart{

  PVector pos,vel;
  float s = random(2,11);
  float life = random(0.8f,1.1f), ld = random(0.001f,0.01f);
  float maxal = random(1,10);
  boolean grow = false;

  ExploPart(PVector p){
    pos = new PVector(p.x,p.y,p.z); 
    float m = 5.05f;
    vel = new PVector(random(-m,m),random(-m,m),0);
  }

  public void go(){
    pos.add(vel);
    vel.mult(0.921f);
    life-=ld;        
    float al = map(life,0,1,0,maxal) % 0.7f;//1.0f;
    if(grow){
      s+=al;
      if(s>50)
        s=50;
    }

    gl.glColor4f(1,1,1,al);//life);
    circle(pos.x,pos.y,pos.z,s); 
  }

}



class incendiario{
  ArrayList f = new ArrayList();
  incendiario(){};
  public void arde(){
    for(int i=0;i<f.size();i++){
      fogo f0 = (fogo) f.get(i);
      f0.arde(); 
      if(f0.life<0){
        f.remove(i);
        i--; 
      }
    }     
  }
  public void gas(city c){
    int v = (int)random(5,10);
    for(int i=0; i<v; i++){
    fogo f0 = new fogo(c);
    f.add(f0);
    }
  }

}


class fogo{
  PVector pos;
  float life = random(0.8f,1.1f), ld = random(0.0001f,0.00051f);
  float maxal = random(10,100);  
  float si = random(0.001f,0.09f);
  float s = random(2,10);
  float col[] = new float[4];

  fogo(city c){
    pos = new PVector(c.pos.x+random(-25,25),c.pos.y+random(-25,25),-495.0f);

    col[0] = random(0.7f,1.f);
    col[1] = col[0]*random(0.1f,0.7f) + random(-0.1f,0.1f);
    col[2] = 0.0f;
    col[3] = 0.0f;
  }

  public void arde(){
    life-=ld;        
    col[3] = map(life,0,1,0,maxal) % 1.0f;

    float size = s + sin(frameCount*si);

    gl.glColor4f(col[0],col[1],col[2],col[3]);
    circle(pos.x,pos.y,pos.z,size); 


  }

}




class airborn{
  city cini,cfim;
  PVector ini,mid,fim,now;
  PVector dist0,dist1;
  float pct,speed;
  boolean go, active;
  PVector pts[] = null;
  float exponent = 0.82f;//random(2,8);
  int deadtime = 60;
  
  float al,ald=1,als=random(0.0025f,0.025f);//0.0025;

  airborn(city a, city b){
    cini = a; cfim = b;
    ini = new PVector(a.pos.x,a.pos.y,a.pos.z);
    fim = new PVector(b.pos.x,b.pos.y,b.pos.z);
    init();
  }
  airborn(PVector v[]){
    ini = new PVector(v[0].x,v[0].y,v[0].z);
    fim = new PVector(v[1].x,v[1].y,v[1].z);
    init();
  }
  public void init(){
    active = true;
    go = false;
//    ini = new PVector(random(wmin20.x,wmax20.x), random(wmin20.y,wmax20.y), -500);
//    fim = new PVector(random(wmin20.x,wmax20.x), random(wmin20.y,wmax20.y), -500);
    now = new PVector(ini.x,ini.y,ini.z);
    mid = interp(ini,fim,0.5f);
    mid.z = 0.0f;//250.0f;//top height

    dist0 = new PVector();
    dist1 = new PVector();
    dist0.set(mid);
    dist0.sub(ini);
    dist1.set(mid);
    dist1.sub(fim);

    pct = 0.0f;
    speed = 0.005f;//0.00051; 
    pts = new PVector[100];
    for(int i=0;i<pts.length;i++)
      pts[i] = new PVector(ini.x,ini.y,ini.z);
  }

  public void fly(){

    if(!active){
    //  init();      
      return;
    }

    if(!go){
      if(frameCount%10==0)
        if(random(1)<0.1f)
          go = true;
    }


    if(go){

      // fifo
      if(frameCount%4==0){
      for(int i=pts.length-2;i>=0;i--){
        pts[i+1].set(pts[i]);
      }
      pts[0].set(now);
      }


      pct += speed;

      if(pct > 1.0f){
        float pctdesce = 1.0f - (pct - 1.0f);//pct - 1.0;//1.0f - (pct - 1.0f);
        if(pctdesce < 0.0f){
          if(deadtime--<0)
            active = false;
          pctdesce = 0.0f;
        }          

        now.x = fim.x + (pctdesce * dist1.x);
        now.y = fim.y + (pctdesce * dist1.y);
//        now.z = fim.z + (pow(pctdesce,exponent) * dist1.z);
        now.z = fim.z + (sin(pctdesce*HALF_PI) * dist1.z);//(pow(pctdesce,exponent) * dist1.z);

      } 
      else {                
        now.x = ini.x + (pct * dist0.x);
        now.y = ini.y + (pct * dist0.y);
//        now.z = ini.z + (pow(pct,exponent) * dist0.z);                
        now.z = ini.z + (sin(pct*HALF_PI) * dist0.z);//(pow(pct,exponent) * dist0.z);                
      }   


      //draw// line

      gl.glBegin(GL.GL_LINE_STRIP);  
      for(int i=0;i<pts.length;i++){
        gl.glColor4f(1,1,1,constrain(((pts.length-i)*0.01f),0.f,0.5f));
        gl.glVertex3f(pts[i].x, pts[i].y, pts[i].z );  
      }
      gl.glEnd();

//      pushMatrix();
//      translate(now.x,now.y,now.z);
//      ellipse(0,0,50,50);
//      popMatrix();
      al+=als*ald;
      if(al<0.f||al>0.79f)
        ald=-ald;

      gl.glColor4f(1,1,1,al);
      circle(now.x,now.y,now.z,10);
      gl.glColor4f(1,1,1,0.05f);
      circle(now.x,now.y,-500.0f,5);


    } 




  }


}




float circlepts0[] = new float[66];
FloatBuffer circlepts1 ;
boolean initcircle=false;
public void init_circle(){
  int k=0;
  for(int i=0;i<22;i++){
    circlepts0[i*3+0] = cos(i/21.0f*TWO_PI);
    circlepts0[i*3+1] = sin(i/21.0f*TWO_PI);
    circlepts0[i*3+2] = 0.0f;
  }


    int numberElements = 22*3;
    circlepts1 = ByteBuffer.allocateDirect(4 * numberElements).order(ByteOrder.nativeOrder()).asFloatBuffer();
    circlepts1.limit(numberElements);
    circlepts1.rewind();
  
  
//  for(int i=0;i<66;i++)
//    circlepts1.put(i, circlepts0[i]);
    
  initcircle = true;
}


public void circle(float x, float y, float z, float radius) {

    if(!initcircle)  init_circle();
  
	int k = 0;
	for(int i = 0; i < 22; i++){
		circlepts1.put(k,  x + circlepts0[k] * radius);
		circlepts1.put(k+1,  y + circlepts0[k+1] * radius);
		circlepts1.put(k+2, z + circlepts0[k+2] * radius);
		k+=3;
	}

	gl.glEnableClientState(GL.GL_VERTEX_ARRAY);
	gl.glVertexPointer(3, GL.GL_FLOAT, 0, circlepts1);
//        gl.glDrawArrays( GL.GL_LINE_LOOP, 0, 22);
        gl.glDrawArrays( GL.GL_TRIANGLE_FAN, 0, 22);
	//glDrawArrays( (drawMode == OF_FILLED) ? GL_TRIANGLE_FAN : GL_LINE_LOOP, 0, numCirclePts);

}








class atmosphere{

  ArrayList nuvens = new ArrayList();
  PVector vento = new PVector(random(-0.1f,0.1f),random(-0.1f,0.1f),0);

  atmosphere(){
    int num = (int) random(100,250);
    for(int i=0;i<num;i++){
     nuvem n = new nuvem(); 
     nuvens.add(n);
    }
  }

  public void helios(){
    PVector rnd = new PVector(random(-0.01f,0.01f),random(-0.01f,0.01f),0);
    vento.add(rnd);

    for(int i=0; i<nuvens.size(); i++){
      nuvem n = (nuvem)nuvens.get(i); 
      n.d();
 

    }

  }

}


class nuvem{
  PVector pos = new PVector(); 
  float s = random(50,400);//random(50,500);
  float speed = random(0.9f,1.1f);
  float op = random(1)<0.01f? random(0,0.1f):random(0.001f,0.055f);
  int num = (int)random(2,10);
  PVector spos[];
  float c[] = new float[3];
  
  nuvem(){
   pos.set(random(wmin20.x,wmax20.x),random(wmin20.y,wmax20.y),random(-100,300)); //random(100,500)); 
   spos = new PVector[num];
   for(int i=0;i<spos.length;i++){
    spos[i] = new PVector();
    spos[i].set(pos);
    spos[i].add(random(-100,100),random(-100,100),pos.z); 
   }
   if(random(1)<0.5f){
   c[0] = 0.0f;
   c[1] = 0.0f;
   c[2] = random(0.5f);
   } else {
     c[0] = c[1] = c[2] = 1.0f;
   }
  }
  public void d(){
    PVector vv = new PVector();
    vv.set(atmos.vento);
    vv.mult(speed);
    pos.add(vv);
    if(pos.x > wmax20.x) pos.x = wmin20.x;
    if(pos.y > wmax20.y) pos.y = wmin20.y;
    if(pos.x < wmin20.x) pos.x = wmax20.x;
    if(pos.y < wmin20.y) pos.y = wmin20.y;

    gl.glColor4f(c[0],c[1],c[2],op);
    //gl.glColor4f(1,1,1,op);
    circle(pos.x,pos.y,pos.z,s);
    for(int i=0;i<num;i++){
      circle(spos[i].x,spos[i].y,spos[i].z,s*0.33f);
    }
  }
}

class worldcities{

  ArrayList cities = new ArrayList();
  int citynum=-1;
  int citytarget=-1;

  worldcities(){
    read();
  }

  public void add(city c){
    city ct = new city(c);
    cities.add(ct); 
  }

  public void read(){
    String data[] = loadStrings("cities.txt");
    for(int i=1;i<data.length;i++){
      String info[] = split(data[i]," ");
      PVector pos = new PVector(PApplet.parseFloat(info[4]),PApplet.parseFloat(info[5]),-495); 
      String dta[] = new String[3];
      dta[0] = info[1];
      dta[1] = info[2];
      dta[2] = info[3];
      city c = new city(pos,dta);
      add(c);
    }
  }

  public void write(){

    String data[] = new String[0];
    data = append(data,"worldcities>pieceattack");
    for(int i=0;i<cities.size();i++){
      city c = (city)cities.get(i);
      data = append(data, ""+i+" "+c.name+" "+c.country+" "+c.federation+" "+c.pos.x+" "+c.pos.y); 
    }

    saveStrings("cities-"+minute()+"-"+second()+".txt",data);
  }


  public void draw(){
    
    if(random(1)<0.01f){
      spawn();
    }

    for(int i=0;i<cities.size();i++){
      city c = (city) cities.get(i);
      c.update();
      c.draw();

//      gl.glColor4f(0f,0f,1f,0.91f);
//      circle(c.pos.x,c.pos.y,c.pos.z, 5);      
//      gl.glColor4f(1f,1f,1f,0.1f);
//      gl.glRasterPos3i(int(c.pos.x),int(c.pos.y+10), int(c.pos.z));
//      glut.glutBitmapString(glut.BITMAP_9_BY_15, c.name+","+c.country);

    } 

//    if(cities.size()>0){
//      int citynum = (frameCount/480)%cities.size();
      drawblink(citynum);
//    }

  }


  public void drawblink(int i){
    if(i==-1)
      return;
    i = (int)constrain(i,0,cities.size()-1);
    city c = (city) cities.get(i);
    if(frameCount%10==0)
      gl.glColor4f(0f,0f,1f,0.91f);
    else
      gl.glColor4f(1f,0.5f,0f,0.91f);

    circle(c.pos.x,c.pos.y,c.pos.z, 10+sin(frameCount*0.07f)*10.0f);      //50+sin(frameCount*0.11)*25.0);      
    gl.glColor4f(1f,1f,1f,0.1f);
    gl.glRasterPos3i(PApplet.parseInt(c.pos.x),PApplet.parseInt(c.pos.y+10), PApplet.parseInt(c.pos.z));
    glut.glutBitmapString(glut.BITMAP_9_BY_15, c.name+" "+i);

  }


  public void spawn(){
   
     int c0 = (int) random(cities.size()); 
     int c1 = (int) random(cities.size()); 
     while(c1==c0){
         c1 = (int) random(cities.size()); 
     }
     
     citynum = c0;
     citytarget = c1;
     PVector v[] = new PVector[2];
     city ca,cb;
     ca = (city)cities.get(c0);
     cb = (city)cities.get(c1);
//     v[0] = new PVector(  ca.pos.x,ca.pos.y,ca.pos.z    );
//     v[1] = new PVector(  cb.pos.x,cb.pos.y,cb.pos.z    );
     airborn ab = new airborn(ca,cb);//new airborn(v);
     air.add(ab);
    
  }
  
  public void explode(){
     int num = (int) random(10,100);
     city ca;
     ca = (city)cities.get(citynum);
     explosoes.bang(ca.pos, num);
      
  }

}



class city{

  PVector pos;
  String name = "lisboa";
  String country = "pt";
  String federation = "eu";
  
  // 
  float life = 1.0f;
  float explo = 0.0f;
  int hitcount = 0;
  int missilecount = 5;
   

  city(city c){
    pos = new PVector(c.pos.x,c.pos.y,c.pos.z);
    name = c.name;
    country = c.country;
    federation = c.federation;
  }
  city(PVector _p, String data[]){
    pos = new PVector(_p.x,_p.y,_p.z);
    name = data[0];
    country = data[1];
    federation = data[2];    
  }


  public void update(){
      
    
  }

  public void draw(){

    gl.glColor4f(0f,0f,1f,0.21f);
    circle(pos.x,pos.y,pos.z, 5);//25);      
    gl.glColor4f(1f,1f,1f,0.1f);
    gl.glRasterPos3i(PApplet.parseInt(pos.x),PApplet.parseInt(pos.y+10), PApplet.parseInt(pos.z));
//    glut.glutBitmapString(glut.BITMAP_9_BY_15, name+" "+hitcount);
    glut.glutBitmapString(glut.BITMAP_HELVETICA_10, name+" "+hitcount);
        
    

  }

}








  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--hide-stop", "wargames022" });
  }
}
