/*
    sistemas de partículas // o som do pensamento // 2009
    agora com forças nos dois eixos, + a gravidade 
*/

SysPart sp;

void setup(){
 
 size (700,700);
  frameRate(30);

 sp = new SysPart(100,width/2,height/2); //num parts, centerx, centery 
  
}


void draw(){  
// background(0);
  noStroke(); fill(0,100);
  rect(0,0,width,height);

 sp.update();
 sp.draw(); 
  
}

void mousePressed(){
  sp.setPosForce(mouseX,mouseY,pmouseX,pmouseY);  
}
void keyPressed(){
  if(key=='s')
    saveFrame("syspart2-######.jpg"); 
}

