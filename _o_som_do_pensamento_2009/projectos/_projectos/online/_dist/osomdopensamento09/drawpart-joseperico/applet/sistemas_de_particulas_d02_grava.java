import processing.core.*; 
import processing.xml.*; 

import processing.video.*; 

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

public class sistemas_de_particulas_d02_grava extends PApplet {

/*
    sistemas de part\u00edculas // o som do pensamento // 2009
 agora com for\u00e7as nos dois eixos, + a gravidade 
 e este sketch desenha formas com sistemas de part\u00edculas
 agora centros aut\u00f3nomos
 */


SysPart sp;
Centro centro;



MovieMaker mm;
boolean gravar = false;

public void setup(){

  size (800,600);
  frameRate(30);

  sp = new SysPart(100,width/2,height/2); //num parts, centerx, centery 
  centro = new Centro(mouseX,mouseY);


  //criar o sys particulas fora da tela para n\u00e3o ser visivel
 // sp = new SysPart(100,-500,-500); //num parts, centerx, centery 
  background(0);
}


public void draw(){  
  // background(0);
  noStroke(); 
  fill(0,1);
  rect(0,0,width,height);

  sp.update();
  sp.draw(); 
  
  if (gravar)
  mm.addFrame();

  if(mousePressed){
    centro.update(mouseX,mouseY);
  }
  //  centro.dwell();
    centro.draw();
    sp.setPosForce(centro.x,centro.y,centro.px,centro.py);
    sp.reIginite();  


}

public void keyPressed(){
  
  if(key=='g'){
    
    if(!gravar){
    mm = new MovieMaker(this, width, height, "ze.mov", 30,
    MovieMaker.JPEG, MovieMaker.HIGH);
    gravar = true;
  }
  
  else {
    mm.finish();
    exit();
    
    //saveFrame("syspart2-######.jpg"); 
}

  }

}
class Centro {

  float x,y;
  float px,py;
  float xamount = 20;
  float yamount = 20;

  //2 construtores
  Centro() { 
  };
  Centro(float _x, float _y) { 
    set(_x,_y);
  }

  public void set (float _x, float _y) {
    px = x = _x;
    py = y = _y;
  }

  public void update( float _x, float _y){
    px = x; 
    py = y; //primeiro copiar valores anteriores
    x = _x; 
    y = _y; //depois actualizar
    bounds();
  }
  
  public void bounds(){
    if(x<0||x>width||y<0||y>height) {
     x = width/2;
     y = height/2; 
    }
  }

  public void dwell(){
    // brownian motion
    // pos = lastpos + random(-offset,offset);
    update( (random(-xamount,xamount)+x), (random(-yamount,yamount)+y)  ); 
  }


  public void draw(){
    fill(random(40,120),random(100,255),100);
    ellipse(x,y,20,20); 
  }

}



class Part{

  float px,py, ppx,ppy;
  float energy,energy_dec;
  float rad;

  float vx,vy; //vel
  float f; //friction

  float gravity; //gravidade, for\u00e7a no eixo dos y
  float fx,fy; //for\u00e7a nos eixos
  int col;

  Part(float x,float y){
    px = ppx = x;
    py = ppy = y;
    energy = 255.f; 
    energy_dec = random(5,20);//random(10.9,20.);
    rad = random(10,50);
    make_rnd_velocity(50.f);
    f = 0.8f;//0.9;
    gravity = 0.9f;
    col = color( random(0,230) , random(100,152), random(40,180) ); //reddishes
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
    stroke(col, (int)energy);
    line(ppx,ppy,px,py);
  }

}

class SysPart{

  Part  p[]; // a array de part\u00edculas
  float cx,cy; // o centro
  float fx,fy; // uma for\u00e7a

  SysPart(int num, float x, float y){
    p = new Part[num];
    cx = x; 
    cy = y;
    for(int i=0; i<p.length;i++){
      p[i] = new Part(x,y); 
    }
  } 


  public void setPos(float x, float y){
    cx = x;
    cy = y; 
  }

  public void setPosForce(float x, float y, float px, float py){
    cx = x;
    cy = y; 
    this.fx = (x - px)*0.1f;
    this.fy = (y - py)*0.1f;
  }


  public void update(){

    for(int i = 0; i < p.length; i++) {
      if(p[i].energy>0)
        p[i].update();
    }

  }


  public void draw(){

    for(int i = 0; i < p.length; i++) 
      if(p[i].energy>0)
        p[i].draw();

  }


  public void reIginite(){

    for(int i = 0; i < p.length; i++) {
      if(p[i].energy < 0){
        p[i].setPosForce(cx,cy,fx,fy); //novo centro, nova for\u00e7a
        p[i].energy = 255;  //energia a 255 de novo
        float force = (abs(fx)+abs(fy) * 10) + 10;
        p[i].make_rnd_velocity(force);//random(2,5));
      } 
    }

  }


}





  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#ffffff", "sistemas_de_particulas_d02_grava" });
  }
}
