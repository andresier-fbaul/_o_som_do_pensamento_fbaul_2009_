/*  som do pensamento, desenhar_0

    não apagar o fundo e desenhar linhas continuamente,
    se o rato estiver pressionado
    
    não há qq memória dos pontos das linhas, são apenas
    desenhadas no framebuffer sem serem apagadas    
*/


void setup(){
  size (700,300);   
  frameRate(30);    
  background(150);
}


void draw(){
  /// reparem que não há função background aqui no draw
  
  stroke(255,255,255, 50); // cor branca com alpha reduzido
  
  if(mousePressed){
    // a dist entre rato anterior e o rato actual
    float d = abs(pmouseX-mouseX) +  abs(pmouseY-mouseY); 
    // a largura da linha proporcional à distância do rato
    strokeWeight(d*0.1);
    // o comando que desenha a linha
    line (mouseX,mouseY,pmouseX,pmouseY);
  }

}


void keyPressed(){
 if (key == 's')
   saveFrame("desenhar-0-####.jpg");//save();
 if (key == ' ')
   background(150);
  
}
