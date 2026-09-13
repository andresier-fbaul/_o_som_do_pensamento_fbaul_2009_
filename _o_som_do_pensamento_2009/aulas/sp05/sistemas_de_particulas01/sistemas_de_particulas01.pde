/*
    sistemas de partículas // o som do pensamento // 2009
*/

SysPart sp;

void setup(){
 
 size (700,700);
  frameRate(30);

 sp = new SysPart(100,width/2,height/2); //num parts, centerx, centery 
  
}


void draw(){
  
 background(0);
 sp.update();
 sp.draw(); 
  
}

void mousePressed(){
 
  sp.setPos(mouseX,mouseY);
  
}

void keyPressed(){
  if(key=='s')
    saveFrame("syspart1-######.jpg"); 
}

