/*
    sistemas de partículas // o som do pensamento // 2009
 agora com forças nos dois eixos, + a gravidade 
 */

import processing.opengl.*;
import processing.video.*;
import ddf.minim.*;

MovieMaker mm;
boolean gravar = false;
Minim minim;
AudioInput in; // o objecto do input sonoro

SysPart sp;
Johny jMouse;

void setup(){

  size (screen.width/2,screen.height/2, OPENGL);
  frameRate(30);

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  sp = new SysPart(100,random(width/4)+width/2,random(height/4)+height/2); //num parts, centerx, centery 
  jMouse = new Johny();
}


void draw(){  
  // background(0);
  noStroke(); 
  fill(0,100);
  rect(0,0,width,height);

  sp.update();
  sp.draw(); 

  jMouse.draw();
  //ellipse(mouseX,mouseY,10,10); 

  if(gravar)
    mm.addFrame(); 

}

void keyPressed(){
  if(key=='s')
    saveFrame("syspart3-######.jpg"); 


  if (key == 'g') {

    if(!gravar){
      mm = new MovieMaker(this, width, height, "video.mov", 30, 
      MovieMaker.JPEG, MovieMaker.HIGH);

      gravar = true;
    } 
    else {

      // Finish the movie if space bar is pressed
      mm.finish();
      // Quit running the sketch once the file is written
      exit();

    } 

  }



}


