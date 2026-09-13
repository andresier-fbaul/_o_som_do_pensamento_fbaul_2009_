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

public class p2_2009_02_27_blinkingCursor extends PApplet {

/* "blinkingCursor", by Tiago Craft. O Som do Pensamento, Feb 2009
this is where i set the basis for my PulsingCircle icon, later used
in applets like "multiAttraction/multiAtrac\u00e7\u00e3o" or "Mapping/Mapear".
It's also a first approach to gravity simulations.
*/

PulsingCircle rato[];
FloatingCircle corpo;

public void setup(){
  size(1024,576);
  frameRate(25);
  noCursor();
  //call cursor constructor
  rato = new PulsingCircle[4];
  for(int i=0; i<rato.length; i++){
    rato[i] = new PulsingCircle();
  }
  //call floating circle constructor
  corpo = new FloatingCircle();
  corpo.setup();
}

public void draw(){
  background(100);
  for (int i =0; i<rato.length; i++){
    rato[i].update();
  }
  corpo.update();
}
class PulsingCircle{
  float iRad= 50;  //preset radius
  float rad = iRad;  //mouse-modulated radius
  float rad2 = rad;  // pulsing radius
  float phase = random(2)-1;  //pulse phase
  float inc = random(0.02f, 0.075f);  //phase increment at each frame
  float weight = PApplet.parseInt(random(5));  //ellipse line-weight
  int col = color(15,210,200,80);

  public void update(){

    phase+=(inc+2*map(weight,0,5,0.075f,0.02f))/3; //pulsing is determined 1*by the inc. and 2* the line-weight
    if(phase>TWO_PI)
      phase-=TWO_PI;

    //modulate the circle radius with the mouse buttons
    if(mousePressed==true)
      rad = (9*rad+iRad*0.7f)/10;
    else
      rad = (9*rad+iRad)/10;
    
    draw(mouseX,mouseY, phase);
  }
  
  public void draw(float x,float y, float phase){
    noFill();
    smooth();
    stroke(col);
    

    
    //trace the circle
    
    for(float i=weight;i>0;i-=1){
      strokeWeight(i);
      rad2 = 2*rad+0.5f*rad*sin(phase);
      ellipse(x,y,rad2,rad2);
    }
    stroke (80,75);
    strokeWeight (5);
    ellipse (mouseX,mouseY,1.6f*rad,1.6f*rad);
  }
}
class FloatingCircle {
  int rad = 10;
  float px, py;
  float vx,vy;
   
  public void setup(){
    px = random(width-2*rad)+rad;
    py = random(height-2*rad)+rad;
    vx = random (2)-1;
    vy = random (2)-1;
    float normVel = sqrt(vx*vx+vy*vy);
    float force = random(5);
    vx = vx * force / normVel ;
    vy = vy * force / normVel ;
  }
  

  
  public void update(){
    float ax = px-mouseX;
    float ay = py-mouseY;
    float aNormAL = sqrt(sq(ax)+sq(ay));
    float gravity = sq(aNormAL)*0.1f;       // lol...
    ax /= gravity;
    ay /= gravity;
    vx-=ax;
    vy-=ay;
    px+=vx;
    py+=vy;
    bounce();

    draw();
  }
  
  public void bounce(){
    if(px<0){px=-px; vx=-vx;}
      else if (px>width){px=width-(px-width);vx=-vx;}
    if(py<0){py=-py; vy=-vy;}
      else if (py>height){py=height-(py-height);vy=-vy;}
  }
  
  public void draw(){
    fill(255,150);
    noStroke();
    ellipse(px , py, rad, rad);
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DCD9DF", "p2_2009_02_27_blinkingCursor" });
  }
}
