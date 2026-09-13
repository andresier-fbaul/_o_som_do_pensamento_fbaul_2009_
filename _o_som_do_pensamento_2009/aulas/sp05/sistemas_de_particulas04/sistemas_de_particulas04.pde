/*
    sistemas de partículas // o som do pensamento // 2009
 agora com forças nos dois eixos, + a gravidade 
 e com cores diferentes, uma array de sistemas de partículas
 */

SysPart sp[];
int head=0;
color cores[] = { #E86528, #08FFF9, #0885FF, #4408FF, #FF087B ,
                  #40FF08, #08FFD4, #51607C, #B7DCE3, #C6FFC1};


void setup(){

  size (700,700);
  frameRate(30);

  sp = new SysPart[10];
  for(int i=0; i < sp.length; i++){    
    color c = cores[(int)random(cores.length)]; // escolher uma cor aleatória da array de cores    
    sp[i] = new SysPart((int)random(50,200),width/2,height/2, c); //num parts, centerx, centery, cor
  }

}


void draw(){  
  // background(0);
  noStroke(); 
  fill(0,100);
  rect(0,0,width,height);

  for(int i=0; i < sp.length; i++) {
    sp[i].update();
    sp[i].draw(); 
  }

}

void mousePressed(){
  head= (head+1)%sp.length;
  sp[head].setPosForce(mouseX,mouseY,pmouseX,pmouseY);  
}
void mouseDragged(){
  sp[head].setPosForce(mouseX,mouseY,pmouseX,pmouseY);  
}

void keyPressed(){
  if(key=='s')
    saveFrame("syspart4-######.jpg"); 
}


