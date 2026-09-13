/*  som do pensamento, desenhar_0

    não apagar o fundo e desenhar linhas continuamente,
    se o rato estiver pressionado
    
    não há qq memória dos pontos das linhas, são apenas
    desenhadas no framebuffer sem serem apagadas 
 
     EXERCÍCIO: 
     
     1. alterar a opacidade da cor da linha dependente da velocidade do rato..
     2. alterar a forma que desenha (ie, em vez de line, usar rect, triangle, ellipse...)

2D Primitives
triangle()
line()
arc()
point()
quad()
ellipse()
rect()    
*/


void setup(){
  size (700,300);   
  frameRate(30);    
  background(150);
  
}


void draw(){
  
  if(mousePressed){
    // a dist entre rato anterior e o rato actual
    float d = abs(pmouseX-mouseX) +  abs(pmouseY-mouseY); 
    // a largura da linha proporcional à distância do rato
//    strokeWeight(d*0.1);

    noFill();
 //   stroke(255,255,255, d*5); // cor branca com alpha reduzido

    stroke(255,255,255, d*5); // cor branca com alpha reduzido
  
    // o comando que desenha a linha
//    line (mouseX,mouseY,pmouseX,pmouseY);
    ellipse (mouseX,mouseY,10,10);
  }

}


void keyPressed(){
 if (key == 's')
   saveFrame("desenhar-0-####.jpg");//save();
 if (key == ' ')
   background(150);
  
}
