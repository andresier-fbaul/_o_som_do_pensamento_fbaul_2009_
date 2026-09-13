import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 
import processing.video.*; 
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

public class sistemas_de_particulas03_video extends PApplet {

/*
    sistemas de part\u00edculas // o som do pensamento // 2009
 agora com for\u00e7as nos dois eixos, + a gravidade 
 */





MovieMaker mm;
boolean gravar = false;
Minim minim;
AudioInput in; // o objecto do input sonoro

SysPart sp;
Johny jMouse;

public void setup(){

  size (screen.width/2,screen.height/2, OPENGL);
  frameRate(30);

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  sp = new SysPart(100,random(width/4)+width/2,random(height/4)+height/2); //num parts, centerx, centery 
  jMouse = new Johny();
}


public void draw(){  
  // background(0);
  noStroke(); 
  fill(0,100);
  rect(0,0,width,height);

  sp.update();
  sp.draw(); 

  jMouse.draw();
  //ellipse(mouseX,mouseY,10,10); 

  if(gravar)
    mm.addFrame(); 

}

public void keyPressed(){
  if(key=='s')
    saveFrame("syspart3-######.jpg"); 


  if (key == 'g') {

    if(!gravar){
      mm = new MovieMaker(this, width, height, "video.mov", 30, 
      MovieMaker.JPEG, MovieMaker.HIGH);

      gravar = true;
    } 
    else {

      // Finish the movie if space bar is pressed
      mm.finish();
      // Quit running the sketch once the file is written
      exit();

    } 

  }



}


class Part{

  float px,py, ppx,ppy;
  float energy,energy_dec;
  float rad;

  float vx,vy; //vel
  float f; //friction

  float Xgravity, Ygravity; //gravidade, for\u00e7a no eixo dos y
  float fx,fy; //for\u00e7a nos eixos
  int col;

  Part(float x,float y){
    px = ppx = x;
    py = ppy = y;
    energy = 250.f; 
    energy_dec = random(5,10);//random(10.9,20.);
    rad = random(10,50);
    make_rnd_normalized_velocity(100.f);
    f = 0.95f;
    Xgravity = 0;
    Ygravity = 0;
    col = color( 232, random(100,152), 40); //reddishes
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
    // calculate attraction
    float dx= mouseX - px;
    float dy = mouseY - py;
    float normGrav = sqrt(dx*dx+dy*dy);
    Xgravity = dx / normGrav;
    Ygravity = dy / normGrav;
    Xgravity *= 30/normGrav;
    Ygravity *= 30/normGrav;
    
   //update velocity
   vx = vx + Xgravity ;
   vy = vy + Ygravity ;
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
   boolean a = sp.count(px,py,0,10);
   if (a== true)
       setPosForce(sp.cx+ random(-sp.cdev,sp.cdev),sp.cy+ random(-sp.cdev,sp.cdev),sp.fx,sp.fy);
     
  }

  public void draw(){
    stroke(col, (int)energy);
    line(ppx,ppy,px,py);
  }

}

class SysPart{

  Part  p[]; // a array de part\u00edculas
  float cx,cy; // o centro
  float vx,vy;
  float cdev = 20; //desvio do centro
  float fx,fy; // uma for\u00e7a
  float rad, b; //raio do emissor
  int points; //pontua\u00e7\u00e3o
  PFont ariale;
  

  
  SysPart(int num, float x, float y){
    p = new Part[num];
    ariale = loadFont("ArialMT-20.vlw");
    vx=0;
    vy=0;
    cx = x; 
    cy = y;
    points = 0;
    for(int i=0; i<p.length;i++){
      p[i] = new Part(x+ random(-cdev,cdev),y+ random(-cdev,cdev)); 
    }
  } 


  public void setPos(){
    vx+=random(1)-0.5f;
    vy+=random(1)-0.5f;
    cx+=vx;
    cy+=vy;
    if(cx<rad/2||cx>width-rad/2){
      vx*=-1;
    }
    if(cy<rad/2||cy>height-rad/2){
      vy*=-1;
    }
  }


  public void update(){
    //modificar o raio do emissor
    float av = in.mix.level();
    b = 300-map(av,0,.5f,5,300);
    rad=(5*rad+b)/6;
    
    setPos();
    count(cx,cy,rad/2,-100);
    
    for(int i = 0; i < p.length; i++) {
      p[i].update();
      if(p[i].energy < 0){
        p[i].setPosForce(cx+ random(-cdev,cdev),cy+ random(-cdev,cdev),fx,fy); //novo centro, nova for\u00e7a
        p[i].energy = 1000;  //energia a 255 de novo
        float force = 20;
        p[i].make_rnd_normalized_velocity(random(force));//random(2,5));
      } 
    }
  }

  public boolean count(float x, float y, float minDist, int value){
      boolean a = false;
      float distance= sqrt((x-mouseX)*(x-mouseX)+(y-mouseY)*(y-mouseY));
      if(distance<(minDist+15)){
        points += value;
        a = true;
      }
      textFont(ariale, 20);
      fill(255);
      text(points, 10, 30);
      noFill();
      return a;
    }
      
  
  public void draw(){
    stroke(23,175,190);
    ellipse(cx,cy,rad,rad);
    for(int i = 0; i < p.length; i++) 
      p[i].draw();
  }
  

}


class Johny {
public void draw(){
  fill(255, 100);
  stroke(255,255);
  pushMatrix();
  translate(mouseX,mouseY);
  ellipse(0,0,30,30);
  beginShape();
    vertex(-4,0);
    vertex(-8,0);
    vertex(0,-8);
    vertex(8,0);
    vertex(4,0);
    vertex(4,4);
    vertex(-4,4);
  endShape();
  popMatrix();
}
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#dcd9df", "sistemas_de_particulas03_video" });
  }
}
