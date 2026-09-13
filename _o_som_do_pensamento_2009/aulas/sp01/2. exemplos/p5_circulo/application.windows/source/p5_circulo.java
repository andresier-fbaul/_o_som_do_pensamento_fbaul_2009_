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

public class p5_circulo extends PApplet {

/// circulo , processing, som do pensamento


Circulo circulo;


public void setup(){
  size(500,281);  // criar uma janela
  circulo = new Circulo(); // criar um novo circulo

  //overwrite dos valores das vari\ufffdveis mouse e mousePressed
  mouseX = width/2;
  mouseY = width/2;
  mousePressed = true;
}


public void draw(){

  background (58,95,83);
  go_mouse();
  circulo.draw();

}

public void go_mouse(){

  if(mousePressed){
    // um filtro low pass ao movimento com destino ao rato
    float filter = 0.01f;			
    circulo.posx = circulo.posx * (1.0f-filter) + mouseX * filter;
    circulo.posy = circulo.posy * (1.0f-filter) + mouseY * filter;
  } else {
    //se o rato n\ufffdo premido, afastamo-nos
    float filter = 0.01f;	
    // calcular um vector com origem no rato at\ufffd ao circulo
    float dx = circulo.posx - mouseX;
    float dy = circulo.posy - mouseY;
    // as coordenadas de destino s\ufffdo a posi\ufffd\ufffdo do c\ufffdrculo + o vector
    circulo.posx = circulo.posx * (1.0f-filter) + (circulo.posx +dx) * filter;
    circulo.posy = circulo.posy * (1.0f-filter) + (circulo.posy +dy) * filter;	


  }

}


class Circulo {
  
  float posx, posy, rad;  
  
  Circulo(){
    rad = random(10,30);
    posx = random(rad,width-rad);
    posy = random(rad,height-rad);
  }
  
  public void draw(){

    stroke(0);
    fill(82,247,195);
    
    ellipse(posx,posy,rad,rad);
    
  }
  
  public void reset(){
     posx = random(rad,width-rad);
     posy = random(rad,height-rad);
  
  }
  
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#c0c0c0", "p5_circulo" });
  }
}
