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

public class bolas_e_obstaculos_arraylist7_casa extends PApplet {

/*

exercicio:

- modificar o draw de cada bola de maneira a inserir imagens de pessoas vistas de cima


*/



ArrayList bolas = new ArrayList();
ArrayList obstaculos = new ArrayList();
ArrayList tiros = new ArrayList();
ArrayList explosions = new ArrayList();
float spring=0.12f;
float friccao = 0.9991f;
Destino dst;
Bola ze;
PImage Obstaculo;
PImage fundo;
int count=0;
PFont font;


public void setup(){
  size (800,600); 
    // load images
  loadImages();
  Obstaculo = loadImage("marques.png");
  fundo = loadImage("lx.jpg");
  imageMode(CENTER);
  ze = new Bola(width/2,height/2);
  dst = new Destino();
  init_scene();
  font = createFont("sans-serif",10);
  textFont(font,50);
  init_explosoes();
}

public void draw(){

  //background(0);
  tint(255,100);
  image(fundo,width/2,height/2,width,height);

  logic();

//  noStroke();
  fill(255);
  text(count,2,height-20);

  dst.draw();

  ze_go();  
tint(255,255);
  for(int i=0; i<obstaculos.size(); i++){
    Obstaculo o = (Obstaculo) obstaculos.get(i);
    o.render();
  } 

  for(int i=0; i<bolas.size(); i++){
    Bola b = (Bola) bolas.get(i);
    if(!b.live){
      bolas.remove(i); 
      count++;
    }
    else{
      b.render(i);
      ze.colide(i-1); //-1 para aceder a todas as bolas...
    }
  } 

  ze.draw();

  stroke(1);
  stroke(255);

  for(int i=0; i<tiros.size(); i++){
    Tiro t = (Tiro) tiros.get(i);
    if(t.energy<0){
      tiros.remove(i); 
      //count++;
    }
    else{
      t.render();
      //      ze.colide(i-1); //-1 para aceder a todas as bolas...
    }
  } 


  for(int i=0; i<explosions.size(); i++){
    Explo e = (Explo) explosions.get(i);
    if(e.energy<0){
      explosions.remove(i); 
    }
    else{
      e.render();
    }
  } 


}


public void ze_go(){
  //update da posi\u00e7\u00e3o
  ze.x+=ze.vx;
  ze.y+=ze.vy;
  //update da velocidade em direc\u00e7\u00e3o ao rato
  ze.vx = (mouseX-ze.x)*0.1f;
  ze.vy = (mouseY-ze.y)*0.1f; 

  if(mousePressed&&frameCount%10==0){
    Tiro t = new Tiro(ze.x,ze.y,atan2(ze.vy,ze.vx)); 
    tiros.add(t);
  }


  // outro m\u00e9todo
  //  ze.x = 0.9*ze.x + 0.1*mouseX;
  //  ze.y = 0.9*ze.y + 0.1*mouseY;
  //  ze.vx = mouseX-pmouseX;
  //  ze.vy = mouseY-pmouseY; 
}

/*

 void mouseReleased(){
 Bola b = new Bola(mouseX,mouseY);
 bolas.add(b);
 }
 */

public void logic(){
  if(frameCount%30!=0) 
    return;
  
  if(bolas.size()==0){
     delay(500);
     delay(2000);
     init_scene();
  }
}


public void init_scene(){
  
   bolas = new ArrayList();
 obstaculos = new ArrayList();
 tiros = new ArrayList();
 explosions = new ArrayList();
  
  int num_ob = (int) random(5,11);
  int num_bolas = (int) random(10,20);

  for(int i = 0; i < num_ob; i++) {
    Obstaculo o = new Obstaculo();
    obstaculos.add(o);   
  }
  for(int i = 0; i < num_bolas; i++) {
    Bola b = new Bola();
    bolas.add(b);   
  }

}

public void keyPressed(){
  if(key=='s')
    saveFrame("bolasobstaculos5-#####.jpg");
    
  
}

class Bola{
  float x,y,r,d, vx,vy;
  boolean live=true;
  PImage img;

  Bola(){
    x = random(width);
    y = random(height);
    r = random(30,4);
    d = r*2.f;
    vx = random(-5,5);
    vy = random(-5,5);
    
    img = h[(int)random(1,8)];
  }
  Bola(float _x, float _y){
   this();
   x=_x; y = _y; 
  }

  public void render(int i){
    colide(i);
    update();
    draw(); 
  }

  public void colide(int num){
    //colis\u00e3o apenas com os obst\u00e1culos
    for(int i=0; i<obstaculos.size(); i++){
      Obstaculo o = (Obstaculo) obstaculos.get(i);

      float dx = o.x - x;
      float dy = o.y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = o.r + r;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - o.x) * spring;
        float ay = (targetY - o.y) * spring;
        vx -= ax;
        vy -= ay;
  //obstaculo n\u00e3o se move
//        o.vx += ax;
//        o.vy += ay;
      }
    } 

    //colis\u00e3o com as outras bolas
    for(int i=num+1; i<bolas.size(); i++){
      Bola o = (Bola) bolas.get(i);
      float dx = o.x - x;
      float dy = o.y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = o.r + r;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - o.x) * spring;
        float ay = (targetY - o.y) * spring;
        vx -= ax;
        vy -= ay;
        o.vx += ax;
        o.vy += ay;
      }
    } 
    
    
    //colis\u00e3o com o destino
      Destino d = dst;
      float dx = d.x - x;
      float dy = d.y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = d.r + r;
      if (distance < minDist) { 
        live=false;
        explode(x,y, (int) random(2,5), false);
      }


  }

  public void update(){
    x+=vx;
    y+=vy;
    vx*=friccao;
    vy*=friccao;
    
    //bounds
    if(x<0)  {
      x=0; 
      vx = -vx;
    }
    if(x>width)  {
      x=width; 
      vx = -vx;
    }
    if(y<0)  {
      y=0; 
      vy = -vy;
    }
    if(y>height)  {
      y=height; 
      vy = -vy;
    }
  }

  public void draw(){
        fill(0);
   // ellipse (x,y,d,d);
    float angulo = atan2(vy,vx)+PI/2;
    
    pushMatrix();

    translate(x,y);
    rotate(angulo);
    tint(255,150);
    image(img,0, 0,2*d,2*d);

//    beginShape();
//    vertex(0, -rad);
//    vertex(rad/2, rad);
//    vertex(-rad/2, rad);
//    endShape(CLOSE);    


    popMatrix();
        //ellipse (x,y,d,d);
  }

}


class Destino{
  float x,y,r,d;

  Destino(){
    x = random(width);
    y = random(height);
    r = random(2,10);
    d = r*2.f;
  }

  public void render(){
   draw(); 
  }
  
  public void draw(){
    fill(100,250,25,250);
    ellipse (x,y,d,d);
  }

}

PImage h[] = new PImage[8];
PImage m[] = new PImage[8]; // humanos e mascaras


public void loadImages(){
 
  // retirado do exemplo Alphamask
  
 for(int i=1; i < 8; i++) {
   h[i] = loadImage("humanmasks/h"+i+".jpg");
   m[i] = loadImage("humanmasks/m"+i+".jpg");
   h[i].mask(m[i]);
   println("acabei de ler "+"humanmasks/h"+i+".jpg e sua m\u00e1scara humanmasks/m"+i+".jpg");
 } 

  
}
class Obstaculo{
  float x,y,r,d;

  Obstaculo(){
    x = random(700);
    y = random(500);
    r = random(40,50);
    d = r*2.f;
  }

  public void render(){
   draw(); 
  }
  
  public void draw(){
   // fill(255,250);
    //ellipse (x,y,d,d);
    
    image(Obstaculo,x,y,d,d);
  }

}

class Tiro{

  float x,y,vx,vy,energy=100;

  Tiro(float px, float py, float angle){
    float s = 10;
    vx = cos(angle)*s;
    vy = sin(angle)*s;
    x = px;
    y = py;
  } 

  public void render(){
    colide();
    update();
    draw(); 
  }
  
  public void colide(){
    //colis\u00e3o apenas com os obst\u00e1culos
    for(int i=0; i<obstaculos.size(); i++){
      Obstaculo o = (Obstaculo) obstaculos.get(i);

      float dx = o.x - x;
      float dy = o.y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = o.r + 1;
      if (distance < minDist) { 
        energy=-1;
        explode(x,y,(int)random(2,5), false); 
      }
    } 

    //colis\u00e3o com as outras bolas
    for(int i=0; i<bolas.size(); i++){
      Bola o = (Bola) bolas.get(i);
      float dx = o.x - x;
      float dy = o.y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = o.r + 1;
      if (distance < minDist) { 
        o.live=false;
        energy = -1;
        explode(x,y,(int)random(5,10), true); 
      }
    } 
    
   
    
  }
  public void update(){
   x+=vx;
   y+=vy;
   energy-=5; 
  }
  public void draw(){
   line(x,y,x-vx,y-vy);
    
  }
  
  
}

PImage explosoes[];

public void init_explosoes(){
  explosoes = new PImage[8];
  for(int i=0; i<8;i++){
    String f = "e16-"+i+".png";
    explosoes[i] = loadImage(f); 
  }
}


public void explode(float x,float y, int num, boolean blood) {
  if(explosions.size()<500){
  for(int i=0; i<num;i++){
    Explo e = new Explo(x,y, blood);
    explosions.add(e);
  }
  }
}


class Explo{

  float x,y,vx,vy,energy,energy_dec;
  PImage img;
  boolean blood;

  Explo(float _x, float _y,boolean blood){
    x = _x;
    y = _y;
    vx = random(-2,2);
    vy = random(-2,2);
    energy = 255;
    energy_dec = random(1.5f, 5.f);
    img = explosoes[(int)random(explosoes.length)];
    this.blood = blood;
  } 

  public void render(){
    x+=vx;
    y+=vy; 
    vx*=0.96f;
    vy*=0.96f;
    energy-=energy_dec;
    if (this.blood)
      tint (255,0,0,energy);
    else
      tint(255,energy);
    image(img,x,y,16,16);
  }

}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#c0c0c0", "bolas_e_obstaculos_arraylist7_casa" });
  }
}
