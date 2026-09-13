/*
    sistemas de partículas // o som do pensamento // 2009
 agora com forças nos dois eixos, + a gravidade 
 e este sketch desenha formas com sistemas de partículas
 agora centros autónomos
 */


SysPart sp;
Centro centro;

void setup(){

  size (700,700);
  frameRate(30);

  sp = new SysPart(100,width/2,height/2); //num parts, centerx, centery 
  centro = new Centro(mouseX,mouseY);
  //criar o sys particulas fora da tela para não ser visivel
 // sp = new SysPart(100,-500,-500); //num parts, centerx, centery 
  background(0);
}


void draw(){  
  // background(0);
  noStroke(); 
  fill(0,1);
  rect(0,0,width,height);

  sp.update();
  sp.draw(); 

  if(mousePressed){
    centro.update(mouseX,mouseY);
  }
    centro.dwell();
//    centro.draw();
    sp.setPosForce(centro.x,centro.y,centro.px,centro.py);
    sp.reIginite();  


}

void keyPressed(){
  if(key=='s')
    saveFrame("syspartd2-######.jpg"); 
}



