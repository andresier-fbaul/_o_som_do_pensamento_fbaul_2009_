
// fullflight by piece attack 
// march 09 @ osomdopensamento.wordpress.com
// models by craft, thanks! 
// merci as!!

import javax.media.opengl.*;
import processing.opengl.*;
import saito.objloader.*;

OBJModel modelboeing,
         modelf16,
         model;
         
PGraphicsOpenGL pgl; 
GL gl; 

int bgcolor=255,
    next=(int)random(10,50),
    bgset=0;


Aviao[]  av;
Sky sky;


static public void main(String args[]) {
  PApplet.main(new String[] { "fullflight" });
}



void setup(){ 
  size(1000, 500, OPENGL);
  perspective(PI/3.0, float(width)/float(height),0.001f, 1000000.0f);  

  av = new Aviao[10];
  for(int i=0;i<av.length;i++)  av[i] = new Aviao();

  sky = new Sky();   

  modelboeing = new OBJModel(this, "boeing_CRAFT_pieceattack.obj");
  modelf16 = new OBJModel(this, "f-16_CRAFT_pieceattack.obj");
  model = modelf16;    

  pgl = (PGraphicsOpenGL)g;
}

void draw(){
  background(bgcolor);

  gl = pgl.beginGL();
  gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE_MINUS_SRC_ALPHA);
  gl.glEnable(GL.GL_BLEND);
  gl.glDisable(GL.GL_DEPTH_TEST);

  sky.draw();

  fill(0);
  for(int i=0;i<av.length;i++)  av[i].voa();

  pushMatrix();
  translate(width,height,-2000+sin(frameCount*0.01)*2000.);
  scale(55);
  model.drawMode(mode);
  model.draw();    
  popMatrix();    
  
  if(frameCount%next==0){
   // println("!");
    if(bgset<1){
       next = (int)random(1,8);
       bgset = 50; 
       bgcolor^=255;
    }
    
    bgset--;
    if(bgset<100)
      bgcolor^=255;
      
    if(bgset==1){
        bgcolor=255;
        next = frameCount + (int) random(50,10);
        bgset = (int) random(50,85);
    }
  }
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
    case 0: 
      mode = QUADS; 
      break;
    case 1: 
      mode = TRIANGLES; 
      break;
    case 2: 
      mode = POLYGON; 
      break;
    case 4: 
      mode = QUADS; 
      break;

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

void mouse(){
 if(!(frameCount%2==0))
   return;
 bgcolor^=255;
 sky.lhead = (sky.lhead + 1) % sky.linhas.length;
 sky.linhas[sky.lhead].x = mouseX+width/2;
 sky.linhas[sky.lhead].y = mouseY+height/2;
 sky.linhas[sky.lhead].z = 1000; 
}

void mousePressed(){ mouse();  }
void mouseDragged(){ mouse();  }
