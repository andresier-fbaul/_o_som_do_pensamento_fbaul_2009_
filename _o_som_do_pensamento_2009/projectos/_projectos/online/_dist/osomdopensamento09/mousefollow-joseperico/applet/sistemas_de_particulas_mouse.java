import processing.core.*; 
import processing.xml.*; 

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

public class sistemas_de_particulas_mouse extends PApplet {

/*
    sistemas de part\u00edculas // o som do pensamento // 2009
    Jos\u00e9 Perico
*/

SysPart sp;

public void setup(){
 
size(800,600);////screen.width,screen.height);
  frameRate(30);

 sp = new SysPart(100,width/2,height/2); //num parts, centerx, centery 
  
}


public void draw(){
  
 background(0);
 sp.update();
 sp.draw(); 
  
}

public void mousePressed(){
 
  sp.setPos(mouseX,mouseY);
  
}

public void keyPressed(){
  if(key=='s')
    saveFrame("syspart1-######.jpg"); 
}

class Part{

  float px,py, ppx,ppy;
  float energy,energy_dec;
  float rad;

  float vx,vy; //vel
  float f; //friction

  float gravity; //gravidade, for\u00e7a no eixo dos y
  int col;

  Part(float x,float y){
    px = ppx = x;
    py = ppy = y;
    energy = 255.f; 
    energy_dec = random(5,7);//random(10.9,20.);
    rad = random(10,40);
    make_rnd_normalized_velocity(50.f);
    f = 0.9f;
    gravity = 0.7f;
    col = color( random(41,200),200, random(20,100)); //reddishes
  }

  public void make_rnd_normalized_velocity(float force){
    vx = random(-1,1);
    vy = random(-1,1);
    //normalizar, dividir cada componente pelo comprimento do vector
    float len = sqrt(vx*vx+vy*vy);
    if(len>0.f){
     vx = vx / len;
     vy = vy / len; 
     vx *= force/0.7f;
     vy *= force/0.7f;
    }
    
  }
  
  public void setPos(float x, float y){
   px = ppx = x;
   py = ppy = y; 
  }
  
  public void update(){
    //store pos
    ppx = px;
    ppy = py;
   //update velocity
   vy = vy + gravity ;
  
  float dx = mouseX - px;
  float dy = mouseY - py;
  float len = sqrt(dx*dx+dy*dy);
  dx = dx/len;
  dy = dy/len;
  
  dx*=7.2f;
  dy*=7.2f;
  
  vx = vx+dx;
  vy = vy+dy;
  
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


  public void update(){

    for(int i = 0; i < p.length; i++) {
      p[i].update();
      
      if(p[i].energy < 0){
        p[i].setPos(cx,cy); //novo centro
        p[i].energy = 255;  //energia a 255 de novo
        float force = ( (frameCount*0.1f) % 100);
        p[i].make_rnd_normalized_velocity(random(force));//random(2,5));
      } 

    }

  }
  
  
  public void draw(){

    for(int i = 0; i < p.length; i++) 
      p[i].draw();
   
  }
  

}



  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#ffffff", "sistemas_de_particulas_mouse" });
  }
}
