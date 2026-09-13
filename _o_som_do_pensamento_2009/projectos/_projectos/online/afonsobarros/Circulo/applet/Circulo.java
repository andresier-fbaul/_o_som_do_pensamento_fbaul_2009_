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

public class Circulo extends PApplet {

/*  circulo, som do pensamento + scribler */
// afonsobarros@gmail.com




float raio;
float angulo;

float ppx, ppy; //previous px, py
float px, py;

Scribler escrivas[];

public void setup(){
 size(800,600);
 frameRate(30);
 background(255);   
  //inicializar tudo no centro
 ppx = px = width/2;
 ppy = py = height/2;
escrivas = new Scribler[50];
  for(int i=0; i<escrivas.length;i++)
    escrivas[i] = new Scribler();



}


public void draw(){
 
 angulo = angulo + ( map (mouseX, 0 , width, -0.9f,0.9f) );
 raio = map(mouseY,0,height,0.f,250.f);
 for(int i=0; i<escrivas.length;i++)
    escrivas[i].draw();
 //guardar as posi\u00e7\u00f5es anteriores
 ppx = px;
 ppy = py;
 //calcular as novas posi\u00e7\u00f5es do circulo:
 // cos/sin(angulo) * raio + centro
 px = cos(angulo) * raio + width/2;
 py = sin(angulo) * raio + height/2;
 
 
   ///onde se activa o escriva..
   if(mousePressed)//if(random(1)<0.2)
      for(int i=0; i<escrivas.length;i++){
        if(escrivas[i].energy <= 0.f){
          escrivas[i] = new Scribler(px,py,(px-ppx),(py-ppy),20);
          break; // get out of the for loop if this condition is true
        }
      }
 
 stroke(255,255);
 line (px,py,ppx,ppy);
 
  
}

public void keyPressed(){
  if (key == 's')
    saveFrame("desenhar-2a-exe-####.jpg");//save();
  if (key == ' ')
    background(255);

}

class Scribler{

  float px,py; //pos x e y
  float ppx,ppy; //previous pos x e y
  float dx,dy; //vel x e y
  float energy;// energia

  float angle,magnitude;
  float curv = random(0.01f,0.77f);
  float side;

  Scribler(){
   //construtor vazio, tudo iniciado a zeros 
  }

  Scribler ( float posx, float posy, float velx, float vely, float energia){
    px = posx;
    py = posy;
    dx = velx;
    dy = vely;
    energy = energia;
    
    angle = atan2(dy,dx);
    magnitude = sqrt(dx*dx+dy*dy);
    side = ( abs(dx) > abs(dy) ) ? 1.f : -1.f;

  }

  public void draw(){
    if(energy>0.f){
      update();
      stroke(random(242),random(75),random(35),150); 
      line(ppx,ppy, px,py);
      strokeWeight(1);
      strokeCap(ROUND);
    }
  }

  public void update(){

      energy -= 0.5f; 

      //update angle
       angle += side * curv;
      
      // diminuir o raio do angulo
      magnitude *= 0.999f;
      
      // novas coordenadas do circulo
     float  cx = cos(angle)*magnitude;
     float  cy = sin(angle)*magnitude;


      ppx = px;
      ppy = py;

      px = px + cx;
      py = py + cy;

 

  }


}





  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#c0c0c0", "Circulo" });
  }
}
