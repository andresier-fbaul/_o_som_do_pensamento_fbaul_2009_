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

public class p5_desenhar2a_exercicio extends PApplet {

/*  som do pensamento, desenhar_2
 
 n\u00e3o apagar o fundo e desenhar linhas continuamente,
 se o rato estiver pressionado
 
 n\u00e3o h\u00e1 qq mem\u00f3ria dos pontos das linhas, s\u00e3o apenas
 desenhadas no framebuffer sem serem apagadas 
 

exerc\u00edcio:

1. alterar as cores de fundo e homogeneizar(sem serem iguais)
as cores das formas que desenham

2. alterar os par\u00e2metros da curvatura dos escrivas, fazendo a 
curvatura depender da velocidade

3. gravar 2 imagens boas para o disco (nota, se quiserem melhor
qualidade, substituir '.jpg' por '.tiff')
 
 */



Scribler escrivas[];




public void setup(){
  size (700,700);   
  frameRate(30);    
  background(165,229,240);

  escrivas = new Scribler[10];
  for(int i=0; i<escrivas.length;i++)
    escrivas[i] = new Scribler();
}


public void draw(){

  for(int i=0; i<escrivas.length;i++)
    escrivas[i].draw();

  if(mousePressed){
    // a dist entre rato anterior e o rato actual
    float d = abs(pmouseX-mouseX) +  abs(pmouseY-mouseY); 
    // a largura da linha proporcional \u00e0 dist\u00e2ncia do rato
    strokeWeight(d*0.1f);
    stroke(196,56,0, 50); // cor branca com alpha reduzido

    // o comando que desenha a linha
    line (mouseX,mouseY,pmouseX,pmouseY);

    ///onde se activa o escriva..
 //   if(frameCount%10==0)//if(random(1)<0.2)
      for(int i=0; i<escrivas.length;i++){
        if(escrivas[i].energy <= 0.f){
          escrivas[i] = new Scribler(mouseX,mouseY,(mouseX-pmouseX),(mouseY-pmouseY),d);
          break; // get out of the for loop if this condition is true
        }

      }

   }

}


public void keyPressed(){
  if (key == 's')
    saveFrame("desenhar-2a-exe-####.tiff");//save();
  if (key == ' ')
    background(165,229,240);

}


class Scribler{

  float px,py; //pos x e y
  float ppx,ppy; //previous pos x e y
  float dx,dy; //vel x e y
  float energy;// energia

  float angle,magnitude;
  float curv = random(0.01f,0.8f);
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
      stroke(0,196,191,energy*10 + 20); 
      line(ppx,ppy, px,py);
    }
  }

  public void update(){

      energy -= 1;//0.5; 

      //update angle
       angle += side * curv;
      
      // diminuir o raio do angulo
      magnitude *= 0.9f;
      
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
    PApplet.main(new String[] { "--bgcolor=#c0c0c0", "p5_desenhar2a_exercicio" });
  }
}
