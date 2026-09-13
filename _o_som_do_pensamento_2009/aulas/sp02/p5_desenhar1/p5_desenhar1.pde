/*  som do pensamento, desenhar_1

    não apagar o fundo e desenhar linhas continuamente,
    se o rato estiver pressionado
    
    não há qq memória dos pontos das linhas, são apenas
    desenhadas no framebuffer sem serem apagadas 
 
     
*/



Scribler escriva;


void setup(){
  size (700,300);   
  frameRate(30);    
  background(150);

  escriva = new Scribler();
}


void draw(){
   
  escriva.draw();
  
  if(mousePressed){
    // a dist entre rato anterior e o rato actual
    float d = abs(pmouseX-mouseX) +  abs(pmouseY-mouseY); 
    // a largura da linha proporcional à distância do rato
    strokeWeight(d*0.1);
    stroke(255,255,255, 50); // cor branca com alpha reduzido
 
    // o comando que desenha a linha
    line (mouseX,mouseY,pmouseX,pmouseY);
    
    ///onde se activa o escriva..
    if(random(1)<0.7)
      if(escriva.energy <= 0.){
        escriva = new Scribler(mouseX,mouseY,(mouseX-pmouseX),(mouseY-pmouseY),d);
        println("e: "+d);
      }
  }

}


void keyPressed(){
 if (key == 's')
   saveFrame("desenhar-1-####.jpg");//save();
 if (key == ' ')
   background(150);
  
}
