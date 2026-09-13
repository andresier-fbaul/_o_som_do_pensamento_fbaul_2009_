import processing.core.*; 
import processing.xml.*; 

import javax.media.opengl.*; 
import processing.opengl.*; 
import saito.objloader.*; 

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

public class fullflight extends PApplet {


// fullflight by piece attack 
// march 09 @ osomdopensamento.wordpress.com
// models by craft, thanks! 
// merci as!!





OBJModel modelboeing,
         modelf16,
         model;
         
PGraphicsOpenGL pgl; 
GL gl; 

int bgcolor=255,
    next=(int)random(10,50),
    bgset=0;


Aviao[]  av;
Sky sky;

public void setup(){ 
  size(1000, 500, OPENGL);
  perspective(PI/3.0f, PApplet.parseFloat(width)/PApplet.parseFloat(height),0.001f, 1000000.0f);  

  av = new Aviao[10];
  for(int i=0;i<av.length;i++)  av[i] = new Aviao();

  sky = new Sky();   

  modelboeing = new OBJModel(this, "boeing_CRAFT_pieceattack.obj");
  modelf16 = new OBJModel(this, "f-16_CRAFT_pieceattack.obj");
  model = modelf16;    

  pgl = (PGraphicsOpenGL)g;
}

public void draw(){
  background(bgcolor);

  gl = pgl.beginGL();
  gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE_MINUS_SRC_ALPHA);
  gl.glEnable(GL.GL_BLEND);
  gl.glDisable(GL.GL_DEPTH_TEST);

  sky.draw();

  fill(0);
  for(int i=0;i<av.length;i++)  av[i].voa();

  pushMatrix();
  translate(width,height,-2000+sin(frameCount*0.01f)*2000.f);
  scale(55);
  model.drawMode(mode);
  model.draw();    
  popMatrix();    
  
  if(frameCount%next==0){
   // println("!");
    if(bgset<1){
       next = (int)random(1,8);
       bgset = 50; 
       bgcolor^=255;
    }
    
    bgset--;
    if(bgset<100)
      bgcolor^=255;
      
    if(bgset==1){
        bgcolor=255;
        next = frameCount + (int) random(50,10);
        bgset = (int) random(50,85);
    }
  }
}

int mode = TRIANGLES;
int mm = 0;
boolean tex = false;

public void keyPressed(){
  if(key=='m'){
    mm++;
    if(mm>4)
      mm=0;
    switch(mm) {
    case 0: 
      mode = QUADS; 
      break;
    case 1: 
      mode = TRIANGLES; 
      break;
    case 2: 
      mode = POLYGON; 
      break;
    case 4: 
      mode = QUADS; 
      break;

    } 
  }

  if(key=='s')
    saveFrame("f16-##.png");

  if(key=='t'){
    tex^=true;
    if(tex)
      model.enableTexture();
    else
      model.disableTexture(); 
  }

}

public void mouse(){
 if(!(frameCount%2==0))
   return;
 bgcolor^=255;
 sky.lhead = (sky.lhead + 1) % sky.linhas.length;
 sky.linhas[sky.lhead].x = mouseX+width/2;
 sky.linhas[sky.lhead].y = mouseY+height/2;
 sky.linhas[sky.lhead].z = 1000; 
}

public void mousePressed(){ mouse();  }
public void mouseDragged(){ mouse();  }

public PVector interp(PVector a, PVector b, float f){
    float f1 = 1.0f - f;
    PVector r = new PVector();
    r.x = a.x*f1 + b.x*f;
    r.y = a.y*f1 + b.y*f; 
    r.z = a.z*f1 + b.z*f;   
    return r;
}



class Aviao{

  PVector pos, vel, acc, rot;
  PVector ini, target;
  float t,dt=0.0151f;
  int modo = (int)random(2); 

  Aviao(){
     constroi();
  }

  public void constroi(){
     ini = pos = new PVector(  random(width/2,2*width), random(-250,250), random(-1550,-200)     ); 
     target = new PVector(  random(width-width/5,width+width/5), height-100, random(550,1000)     ); 
     vel = new PVector();
     acc = new PVector();
     dt=random(0.001f,0.00751f);
  }
  
  public void voa(){

    t+=dt;
    if(t>1.5f){
      t=0;
      constroi();
    }
      
    PVector desired = interp(ini,target,t);
    vel.set(pos);
    pos = interp(pos,desired,0.05f);           
    vel.sub(pos);
    vel.mult(-1);
    
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    //model.draw();
    fill(0,255,0);
    if(modo<1)
      modelboeing.draw();
    else
      modelf16.draw();
    popMatrix();
  }



}


class Sky{
  
  Linha linhas[] = new Linha[1000];
  Bola nuvens[] = new Bola[100];
  int lhead=0;
  
  Sky(){
    for(int i=0;i<linhas.length;i++)
      linhas[i] = new Linha();    
    for(int i=0;i<nuvens.length;i++)
      nuvens[i] = new Bola();    
  }
  public void draw(){
    stroke(70,200);
    for(int i=0;i<linhas.length;i++)
      linhas[i].go();    
    noStroke();//stroke(255,200);
    for(int i=0;i<nuvens.length;i++)
      nuvens[i].go();    
  }
}


class Bola extends Linha{

  float dimx = random(700,2500),dimy = dimx*3.0f/4.0f;
  int cor;
  float alfa = random(10,150);

  Bola(){
    super(); 
    y = random(250,5000); 
    int m = random(1)<0.5f ? (int) random(50) : (int)random(5,10)*25; 
    cor = color(m,m,m);
  }
  
  public void go(){
    super.update();
    fill(cor,alfa);
    pushMatrix();
    translate(x,y,z);
    ellipse(0,0,dimx,dimy);
    popMatrix();
  }

}

class Linha{

  float x,y,z,vz;

  Linha(){
    x = random(-25000,25000); 
    y = random(-5000,5000); 
    z = random(-15000,1000);
    vz = -25 - random(10);
  }

  public void update(){
    z+=vz;     
    if(z<-15000)
      z=1000;    
  }

  public void go(){
    update();
    line(x,y,z,x,y,z+vz);
  }
}



  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--hide-stop", "fullflight" });
  }
}
