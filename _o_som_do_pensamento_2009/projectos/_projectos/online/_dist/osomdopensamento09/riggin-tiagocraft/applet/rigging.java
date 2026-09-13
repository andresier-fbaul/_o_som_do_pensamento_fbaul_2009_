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

public class rigging extends PApplet {

Corpo corpo;
Aste asteFrente1, asteFrente2, asteMeio, asteTras;
Roda rodaFrente, rodaMeio, rodaTras;

public void setup(){
  size(800,200);
  frameRate(30);
  corpo = new Corpo(100,40);
  asteFrente1 = new Aste(40);
  asteFrente2 = new Aste(30);
  asteMeio = new Aste(25);
  rodaMeio = new Roda(10);
  rodaFrente = new Roda(10);
  asteTras = new Aste(40);
  rodaTras = new Roda(10);
}

public void draw(){
  update();
  background(255);
  pushMatrix();
    translate(width*0.5f, height*0.8f);
    line(-width/2, 0, width/2, 0);
    translate(corpo.px, corpo.py);
    scale(-1,1);
    pushMatrix();
      rotate(asteTras.rot);
      asteTras.draw();
      translate(0, asteTras.x);
      rotate(rodaTras.rot);
      rodaTras.draw();
    popMatrix();
    pushMatrix();
      rotate(asteFrente1.rot);
      asteFrente1.draw();
      translate(0, asteFrente1.x);
      pushMatrix();
        rotate(asteFrente2.rot);
        asteFrente2.draw();
        translate(0,asteFrente2.x);
        rotate(rodaFrente.rot);
        rodaFrente.draw();
      popMatrix();
      pushMatrix();
        rotate(asteMeio.rot);
        asteMeio.draw();
        translate(0,asteMeio.x);
        rotate(rodaMeio.rot);
        rodaMeio.draw();
      popMatrix();
    popMatrix();
    translate(-corpo.x/7,0);
    corpo.draw();
    translate(-corpo.x/2+rodaFrente.rad*2,-corpo.y/2);
    rotate(PI);
    rodaFrente.draw();
  popMatrix();
}

class Corpo{
  int x, y;
  float px, py;
  
  Corpo(int in_x, int in_y){
    x = in_x;
    y = in_y;
    px = py = 0;
  }
  public void update(){
    px = mouseX-PApplet.parseInt(width*0.5f);
    py = constrain(mouseY-PApplet.parseInt(height*0.75f),-100,-20);
  }
  public void draw(){
    stroke(0);
    strokeWeight(1);
    fill(255);
    rectMode(CORNERS);
    rect(-x/2, 0, x/2, -y);
}}


class Aste{
  float x;
  float rot;

  Aste(int in_x){
    x = in_x;
    rot = 0;
  }
  public void draw(){
    stroke(0);
    strokeWeight(1);
    fill(255);
    rectMode(CORNERS);
    rect(5, 0, -5, x);
}}


class Roda{
  float rad, sides;
  float rot;
  int contacto;

  Roda(int in_rad){
    rad = in_rad;
    sides=3;
    rot=0;
    contacto=1;
  }
 public void draw(){
    beginShape();
      for(int a=0; a<=sides; a++){
        float ang = a*TWO_PI/sides;
        vertex(rad*cos(ang), rad*sin(ang));
      }
    endShape();
}}
public void update(){
  corpo.update();
  
  /* aste frente 1 */ {
  if(corpo.py*0.6f >= -rodaFrente.rad*0.6f) asteFrente1.rot = HALF_PI;  // corpo a altura <= raio da roda: aste bate no corpo e n\u00e3o roda mais.
  else{
    if(corpo.py*0.6f <= -asteFrente1.x-rodaFrente.rad*0.6f) asteFrente1.rot = 0;  // corpo a altura >= comprimento da aste: aste pendurada na vertical
    else{
      float rotSin = (corpo.py+rodaFrente.rad)*0.6f/asteFrente1.x; // corpo a altura interm\u00e9dia: rota\u00e7\u00e3o da aste depende da altura
      asteFrente1.rot = HALF_PI+asin(rotSin);
  }}}
  
  /* aste frente 2 */ {
  if(corpo.py*0.4f >=-rodaFrente.rad*0.4f){
    asteFrente2.rot = HALF_PI-asteFrente1.rot;
    rodaFrente.contacto=1;
  }
  else{
    if(corpo.py < -asteFrente1.x-asteFrente2.x-rodaFrente.rad*0.4f){
      asteFrente2.rot = 0;
      rodaFrente.contacto=0;
    }else{
      float rotSin = (corpo.py+rodaFrente.rad)*0.4f/asteFrente2.x;
      asteFrente2.rot = HALF_PI+asin(rotSin)-asteFrente1.rot;
      rodaFrente.contacto=1;
  }}}

  /* aste meio */ {
  if(corpo.py*0.4f >=-rodaMeio.rad*0.4f){
    asteMeio.rot = HALF_PI+asteFrente1.rot;
    rodaMeio.contacto=1;
  }else{
    if(corpo.py < -asteFrente1.x-asteMeio.x-rodaMeio.rad*0.4f){
      asteMeio.rot = -asteFrente1.rot;
      rodaMeio.contacto = 0;
    }else{
      float rotSin = (corpo.py+rodaMeio.rad)*0.4f/asteMeio.x;
      asteMeio.rot =-HALF_PI-asin(rotSin)-asteFrente1.rot;
      rodaMeio.contacto = 1;
  }}}

  /* aste tr\u00e1s */{
  if(corpo.py >= -rodaTras.rad){
    asteTras.rot = -HALF_PI;
    rodaTras.contacto = 1;
  }else{
    if(corpo.py < -asteTras.x-rodaTras.rad){
      asteTras.rot=0;
      rodaTras.contacto = 0;
    }else{
      float rotSin = (corpo.py + rodaTras.rad)/asteTras.x;
      asteTras.rot = -HALF_PI-asin(rotSin);
      rodaTras.contacto = 1;
  }}}

  // roda frente
  if(rodaFrente.contacto==1) rodaFrente.rot -= PApplet.parseFloat(mouseX - pmouseX)/rodaFrente.rad;
  // roda meio
  if(rodaMeio.contacto==1) rodaMeio.rot -= PApplet.parseFloat(mouseX - pmouseX)/rodaMeio.rad;
  // roda tras
  if(rodaTras.contacto ==1) rodaTras.rot -= PApplet.parseFloat(mouseX - pmouseX)/rodaTras.rad;
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DCD9DF", "rigging" });
  }
}
