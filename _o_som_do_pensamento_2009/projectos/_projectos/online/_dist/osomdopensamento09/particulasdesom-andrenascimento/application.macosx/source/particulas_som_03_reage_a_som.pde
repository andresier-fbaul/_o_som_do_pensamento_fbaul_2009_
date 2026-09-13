/*
    sistemas de partículas // o som do pensamento // 2009
 agora com forças nos dois eixos, + a gravidade 
 e com cores diferentes, uma array de sistemas de partículas
 e agora eles decaem quando são criados
 e
o som cria sistemas de partículas, com forças dependentes do som
e posições aleatórias
 */


// som
import ddf.minim.*;
Minim minim;
AudioInput in;
//definir valores minimos e maximos de reacção para input de som; 
float MINSOUND = 0.0015;///0.0007//0.05;//0.01; // o valor de som que despoleta a criação de sistemas
float MAXSOUND = 0.22; // o valor máximo de som para calibrar a força dos sistemas

// sistemas de partículas
SysPart sp[];
int head=0;
color cores[] = { #E86528, #08FFF9, #0885FF, #4408FF, #FF087B ,
                  #40FF08, #08FFD4, #51607C, #B7DCE3, #C6FFC1};


void setup(){
  size (1024,768);
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, 512);
    
  frameRate(30);

  sp = new SysPart[10];
  for(int i=0; i < sp.length; i++){    
    color c = cores[(int)random(cores.length)]; // escolher uma cor aleatória da array de cores    
    sp[i] = new SysPart((int)random(50,200),width/2,height/2, c); //num parts, centerx, centery, cor
  }

}


void draw(){  
  noStroke();fill(0,100);
  rect(0,0,width,height);

  float rms = in.mix.level();
//  println(rms); //escrever os valores de som
  
  if(rms > MINSOUND){ //criar um novo sistema; ou seja se o volume audio for acima do MINSOUND, surge mais um sistema no array de particulas
     call_new_sys(rms); //ver mais abaixo valor fff (que é este rms)
   }


  for(int i=0; i < sp.length; i++) {
    sp[i].update();
    sp[i].draw(); 
  }

}


void keyPressed(){
  if(key=='s')
    saveFrame("syspart5s-######.png"); 
}



void mousePressed(){
  head= (head+1)%sp.length;
  sp[head].setPosForce(mouseX,mouseY,pmouseX,pmouseY);  
  sp[head].reIgnite();
}

void mouseDragged(){
  sp[head].setPosForce(mouseX,mouseY,pmouseX,pmouseY);  
  sp[head].reIgnite();
}

//criar sistema de particulas dependente do volume de som

void call_new_sys(float fff){ //recebe valor de rms
    head= (head+1)%sp.length;
    sp[head].setPos(random(200,width-200),random(200,height-200));
    //vector aleatório normalizado de força
    float fx = random(-1,1);  
    float fy = random(-1,1);
    float len = sqrt(fx*fx+fy*fy);
    fx/=len; fy/=len;
    // multiplicar o vector por intensidade sonora
    float inten = map (fff, MINSOUND,MAXSOUND, 0.05,10.);
    fx*=inten; fy*=inten;
    sp[head].fx = fx; sp[head].fy = fy;
    
    sp[head].reIgnite(fff);   //adiciona-se fff ao parentesis para usar valor de som para mapear os raios (na segunda funcao reignite no syspart que recebe floats)
 
}
