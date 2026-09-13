import processing.core.*; 
import processing.xml.*; 

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

public class particulas_som_03_reage_a_som extends PApplet {

/*
    sistemas de part\u00edculas // o som do pensamento // 2009
 agora com for\u00e7as nos dois eixos, + a gravidade 
 e com cores diferentes, uma array de sistemas de part\u00edculas
 e agora eles decaem quando s\u00e3o criados
 e
o som cria sistemas de part\u00edculas, com for\u00e7as dependentes do som
e posi\u00e7\u00f5es aleat\u00f3rias
 */


// som

Minim minim;
AudioInput in;
//definir valores minimos e maximos de reac\u00e7\u00e3o para input de som; 
float MINSOUND = 0.0015f;///0.0007//0.05;//0.01; // o valor de som que despoleta a cria\u00e7\u00e3o de sistemas
float MAXSOUND = 0.22f; // o valor m\u00e1ximo de som para calibrar a for\u00e7a dos sistemas

// sistemas de part\u00edculas
SysPart sp[];
int head=0;
int cores[] = { 0xffE86528, 0xff08FFF9, 0xff0885FF, 0xff4408FF, 0xffFF087B ,
                  0xff40FF08, 0xff08FFD4, 0xff51607C, 0xffB7DCE3, 0xffC6FFC1};


public void setup(){
  size (1024,768);
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, 512);
    
  frameRate(30);

  sp = new SysPart[10];
  for(int i=0; i < sp.length; i++){    
    int c = cores[(int)random(cores.length)]; // escolher uma cor aleat\u00f3ria da array de cores    
    sp[i] = new SysPart((int)random(50,200),width/2,height/2, c); //num parts, centerx, centery, cor
  }

}


public void draw(){  
  noStroke();fill(0,100);
  rect(0,0,width,height);

  float rms = in.mix.level();
//  println(rms); //escrever os valores de som
  
  if(rms > MINSOUND){ //criar um novo sistema; ou seja se o volume audio for acima do MINSOUND, surge mais um sistema no array de particulas
     call_new_sys(rms); //ver mais abaixo valor fff (que \u00e9 este rms)
   }


  for(int i=0; i < sp.length; i++) {
    sp[i].update();
    sp[i].draw(); 
  }

}


public void keyPressed(){
  if(key=='s')
    saveFrame("syspart5s-######.png"); 
}



public void mousePressed(){
  head= (head+1)%sp.length;
  sp[head].setPosForce(mouseX,mouseY,pmouseX,pmouseY);  
  sp[head].reIgnite();
}

public void mouseDragged(){
  sp[head].setPosForce(mouseX,mouseY,pmouseX,pmouseY);  
  sp[head].reIgnite();
}

//criar sistema de particulas dependente do volume de som

public void call_new_sys(float fff){ //recebe valor de rms
    head= (head+1)%sp.length;
    sp[head].setPos(random(200,width-200),random(200,height-200));
    //vector aleat\u00f3rio normalizado de for\u00e7a
    float fx = random(-1,1);  
    float fy = random(-1,1);
    float len = sqrt(fx*fx+fy*fy);
    fx/=len; fy/=len;
    // multiplicar o vector por intensidade sonora
    float inten = map (fff, MINSOUND,MAXSOUND, 0.05f,10.f);
    fx*=inten; fy*=inten;
    sp[head].fx = fx; sp[head].fy = fy;
    
    sp[head].reIgnite(fff);   //adiciona-se fff ao parentesis para usar valor de som para mapear os raios (na segunda funcao reignite no syspart que recebe floats)
 
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
    energy_dec = random(5,10);//random(10.9,20.);
    rad = random(10,50);
    make_rnd_normalized_velocity(50.f);
    f = 0.9f;
    gravity = 0.15f;
    col = color( 232, random(100,150), 40); //reddishes
  }

  Part(float x,float y,int c){
    this(x,y);
    col = c; // esta variavel, chamada aqui, sobrepoe \u00e0 cor definida o array de cores hexadecimal definido no sketch principal
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
 // tirar estes comentarios para usar linhas e nao elipses
 //    stroke(col, (int)energy);
//    line(ppx,ppy,px,py);
    stroke(255, constrain(energy,0,100));
    fill(col,energy);
//esta variavel rad nao \u00e9 a declarada no inicio da class; \u00e9 uma VARIAVEL LOCAL, pq \u00e9 chamada dentro da elipse
//comentar leva a que particulas n alterem tamanho ao longo do percurso
//    float rad = abs(px-ppx*random (0.5, 1))+abs(py-ppy*random (0.5, 1)); 
    ellipse(px,py,rad,rad);
  }

}


class SysPart{

  Part  p[]; // a array de part\u00edculas
  float cx,cy; // o centro
  float cdev = 10; //desvio do centro
  float fx,fy; // uma for\u00e7a

  SysPart(int num, float x, float y){
    p = new Part[num];
    cx = x; 
    cy = y;
    for(int i=0; i<p.length;i++){
      p[i] = new Part(x+ random(-cdev,cdev),y+ random(-cdev,cdev)); 
    }
  } 

  SysPart(int num, float x, float y, int c){
    p = new Part[num];
    cx = x; 
    cy = y;
    for(int i=0; i<p.length;i++){
      p[i] = new Part(x+ random(-cdev,cdev),y+ random(-cdev,cdev), c); 
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


  public void reIgnite(){
    for(int i = 0; i < p.length; i++) {
      if(p[i].energy < 0){
        p[i].energy = 255;
        p[i].setPosForce(cx+ random(-cdev,cdev),cy+ random(-cdev,cdev),fx,fy);
        float force = (abs(fx)+abs(fy)) * 10.f;
        p[i].make_rnd_normalized_velocity(random(force));
 //       p[i].rad = random(10,200);
      }
    }    
  }
//recebe valores fff / rms (som) do sketch principal, na funcao call_new_sys
  public void reIgnite(float s){
    for(int i = 0; i < p.length; i++) {
      if(p[i].energy < 0){
        p[i].energy = 255;
        p[i].setPosForce(cx+ random(-cdev,cdev),cy+ random(-cdev,cdev),fx,fy);
        float force = (abs(fx)+abs(fy)) * 10.f;
        p[i].make_rnd_normalized_velocity(random(force));
        p[i].rad = map(s,MINSOUND,MAXSOUND, 10,200);
      }
    }    
  }


  public void update(){

    for(int i = 0; i < p.length; i++) {
      if(p[i].energy > 0)
        p[i].update();

      //      if(p[i].energy < 0){
      //        p[i].setPosForce(cx+ random(-cdev,cdev),cy+ random(-cdev,cdev),fx,fy); //novo centro, nova for\u00e7a
      //        p[i].energy = 255;  //energia a 255 de novo
      //        float force = ( (frameCount*0.1) % 100);
      //        p[i].make_rnd_normalized_velocity(random(force));//random(2,5));
      //      } 

    }

  }


  public void draw(){

    for(int i = 0; i < p.length; i++) {
      if(p[i].energy>0)
        p[i].draw();
    }
  }


}





  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#c0c0c0", "particulas_som_03_reage_a_som" });
  }
}
