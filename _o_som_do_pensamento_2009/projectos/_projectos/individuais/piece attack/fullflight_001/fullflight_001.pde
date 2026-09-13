
// fullflight   by piece attack
// models by CRAFT, thanks!

import saito.objloader.*;
import processing.opengl.*;

OBJModel modelboeing,modelf16,model;

float ca=HALF_PI;
PFont font;


Aviao[]  av;
Sky sky;

void setup(){ 
   size(1200, 700, OPENGL);
      
   perspective(PI/3.0, float(width)/float(height),0.001f, 1000000.0f);  

   av = new Aviao[10];
   for(int i=0;i<av.length;i++)  av[i] = new Aviao();
   
   sky = new Sky();   
   
   modelboeing = new OBJModel(this, "boeing_CRAFT_pieceattack.obj");
   modelf16 = new OBJModel(this, "f-16_CRAFT_pieceattack.obj");
   model = modelf16;    

  font = createFont("arial",12);
  textFont(font);
}

void draw(){
  background(255);

//  fill(255,10);
//  noStroke();
//  rect(0,0,width,height);
  
  sky.draw();
  
  fill(0);
  for(int i=0;i<av.length;i++)  av[i].voa();
 
  pushMatrix();
  translate(width/2,height/2+100,-2000+sin(frameCount*0.01)*2000.);
  scale(55);
  model.drawMode(mode);
  model.draw();    
  popMatrix();    
}

int mode = TRIANGLES;
int mm = 0;
boolean tex = false;

void keyPressed(){
  if(key=='m'){
     mm++;
     if(mm>4)
      mm=0;
     switch(mm) {
      case 0: mode = QUADS; break;
      case 1: mode = TRIANGLES; break;
      case 2: mode = POLYGON; break;
      case 4: mode = QUADS; break;
      
     } 
  }
  
  if(key=='s')
    saveFrame("f16-##.png");
  
  if(key=='t'){
     tex^=true;
     if(tex)
      model.enableTexture();
     else
      model.disableTexture(); 
  }
    
}

