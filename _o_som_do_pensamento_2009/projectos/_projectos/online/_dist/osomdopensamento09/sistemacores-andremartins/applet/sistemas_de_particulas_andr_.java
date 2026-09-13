import processing.core.*; 
import processing.xml.*; 

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

public class sistemas_de_particulas_andr_ extends PApplet {

/*
    sistemas de part\u00edculas // o som do pensamento // 2009
 agora com for\u00e7as nos dois eixos, + a gravidade 
 e este sketch desenha formas com sistemas de part\u00edculas
 agora centros aut\u00f3nomos
 */



SysPart sp[];
Centro centro[];

public void setup(){

  size (1200,700,OPENGL);
  frameRate(30);

  sp = new SysPart[10];
  centro = new Centro[10];
  for(int i=0; i< 10; i++) {
    sp[i] = new SysPart(100,width/2,height/2); //num parts, centerx, centery 
    centro[i] = new Centro(mouseX,mouseY);
  }
  background(0);
}


public void draw(){  
  // background(0);
  noStroke(); 
  fill(0,10);
  rect(0,0,width,height);

  for(int i=0; i < 10; i++) {

    sp[i].update();
    sp[i].draw(); 

    if(mousePressed){
      centro[i].update(mouseX,mouseY);
    }
    centro[i].dwell();
    //    centro.draw();
    sp[i].setPosForce(centro[i].x,centro[i].y,centro[i].px,centro[i].py);
    sp[i].reIginite();  
  }


}

public void keyPressed(){
  if(key=='s')
    saveFrame("syspart2-######.jpg"); 
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
    fill(255,100);
    ellipse(x,y,200,200); 
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
    energy = 755.f; 
    energy_dec = random(10,30);//random(10.9,20.);
    rad = random(10,50);
    make_rnd_velocity(50.f);
    f = 0.8f;//0.9;
    gravity = 0.9f;
    col = color( random(0,255), random(0,255), random(0,255)); //reddishes
  }


  public void make_rnd_velocity(float force){
    
     vx = random(-force,force);  
     vy = random(-force,force);  
    
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
    strokeWeight(px);
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
    this.fx = (x - px)*0.2f;
    this.fy = (y - py)*0.2f;
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
    PApplet.main(new String[] { "--bgcolor=#c0c0c0", "sistemas_de_particulas_andr_" });
  }
}
