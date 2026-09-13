/*
  multi touch camera draw sketch
 with particle systems
 
 exercício_criar uma composição gráfica à base
 de sistemas de partículas, reconhecimento de imagem,
 usando em cada partícula a imagem do video,
 fazendo a vida da particula crescer as dims do video,
 ou rodando as imagens nos eixos x y. dessa composição
 devem gravar umas frames que depositam na área pública
 de transferência
 
 */

import processing.opengl.*;
import processing.video.*;
import s373.flob.*;

/// vars
Capture video;
Flob flob; 
int timeout=0;
/// video params
int TRESH = 20;       //adjust treshold value here or keys t/T!!
int videores=128;
boolean drawimg=false; // key 'i' toggles draw


//cada sistema de particulas agora mantem posições actuais e anteriores
SysPart sp[];
color cores[] = { #E86528, #08FFF9, #0885FF, #4408FF, #FF087B ,
                  #40FF08, #08FFD4, #51607C, #B7DCE3, #C6FFC1};

int fps = 60;//25

/// program
void setup(){
  //bug 882 processing 1.0.1
  try { 
    quicktime.QTSession.open(); 
  } 
  catch (quicktime.QTException qte) { 
    qte.printStackTrace(); 
  }

  size(1200,700,OPENGL);
  frameRate(fps);
  // init video data and stream
  video = new Capture(this, videores, videores, fps);  

  // init blob tracker
  flob = new Flob(this, video); 
  flob.mirrorX(true); 
  flob.setTresh(TRESH);

  flob.setOm(flob.CONTINUOUS_DIFFERENCE); 
  background(0);

  sp = new SysPart[10];
  for(int i=0; i < sp.length; i++){    
    color c = cores[(int)random(cores.length)]; // escolher uma cor aleatória da array de cores    
    sp[i] = new SysPart((int)random(50,200),width/2,height/2, c); //num parts, centerx, centery, cor
  }

}



void draw(){
  if(video.available()) {
    video.read();
    flob.calc(  flob.binarize(video) );    



    //write test image to frame
    if(drawimg)
       image(video, 0, 0, width, height);
//      image(flob.videotex, 0, 0, width, height);


    noStroke();
    fill(0,20);
    rect(0,0,width,height);

  for(int i=0; i < sp.length; i++) {
    sp[i].update();
    sp[i].draw(); 
  }

    //get and use the data
    int numblobs = flob.getNumBlobs(); 
    if(numblobs>0) { 
      float centermass[] = new float[3];
 
      for(int i = 0; i < numblobs; i++) {
        centermass = flob.getCentroidPixelcount(i);
        int numsys = (int)constrain(i,0,sp.length-1);
        sp[numsys].setPosForce(centermass[0]*width,centermass[1]*height);
        sp[numsys].reIgnite();  

      }







    }

  }

}

void keyPressed(){
  if(key=='i')
    drawimg^=true;
  else if(key=='t'){
    TRESH-=2;
    flob.setTresh(TRESH);
    println("video tresh: "+TRESH);
  }
  else if(key=='T'){
    TRESH+=2;
    flob.setTresh(TRESH);
    println("video tresh: "+TRESH);
  }  
  else if(key=='s'){
    saveFrame("videodraw-######.jpg");
  }  
  else
    init_video_bg(); //any key sets new background to test against

}


void init_video_bg(){
  background(0);
  flob.setBackground(video);
}





