/*
    sistemas de partículas // o som do pensamento // 2009
 agora com forças nos dois eixos, + a gravidade 
 e este sketch desenha formas com sistemas de partículas
 agora centros autónomos
 */

import processing.opengl.*;

SysPart sp[];
Centro centro[];

void setup(){

  size (1200,700,OPENGL);
  frameRate(30);

  sp = new SysPart[10];
  centro = new Centro[10];
  for(int i=0; i< 10; i++) {
    sp[i] = new SysPart(100,width/2,height/2); //num parts, centerx, centery 
    centro[i] = new Centro(mouseX,mouseY);
  }
  background(0);
}


void draw(){  
  // background(0);
  noStroke(); 
  fill(0,10);
  rect(0,0,width,height);

  for(int i=0; i < 10; i++) {

    sp[i].update();
    sp[i].draw(); 

    if(mousePressed){
      centro[i].update(mouseX,mouseY);
    }
    centro[i].dwell();
     centro[i].draw();
    sp[i].setPosForce(centro[i].x,centro[i].y,centro[i].px,centro[i].py);
    sp[i].reIginite();  
  }


}

void keyPressed(){
  if(key=='s')
    saveFrame("syspart3-######.jpg"); 
}





