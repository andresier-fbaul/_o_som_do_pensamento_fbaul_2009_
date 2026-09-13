
/// airplanes   peace attack

import saito.objloader.*;
import processing.opengl.*;

OBJModel model;

float ca=HALF_PI;
PFont font;


Aviao[]  av;

void setup(){ 
   size(1000, 600, OPENGL);
   
   
   perspective(PI/3.0, float(width)/float(height),0.001f, 1000000.0f);  

   av = new Aviao[10];
   for(int i=0;i<av.length;i++)  av[i] = new Aviao();
   
   
//   model = new OBJModel(this, "boeing_triangles.obj");
//   model = new OBJModel(this, "boeing_polygons.obj");
//   model = new OBJModel(this, "747.obj");
//   model = new OBJModel(this, "747_objfront_Scene.obj");
//   model = new OBJModel(this, "f-16.obj");
   model = new OBJModel(this, "boeing_331triangles.obj");
//  model = new OBJModel(this, "boeing_1587triangles.obj");
//   model = new OBJModel(this, "boeing_2029triangles.obj");
//   model = new OBJModel(this, "boeing_2735triangles.obj");
//   model = new OBJModel(this, "boeing_polygons_2735triangles.obj");
   
    
//   model = new OBJModel(this, "makeMeWalk.obj");

  font = createFont("arial",12);
  textFont(font);
}

void draw(){
  background(255);

//  fill(255,10);
//  noStroke();
//  rect(0,0,width,height);
  
  fill(0);
  
  
  
     for(int i=0;i<av.length;i++)  av[i].voa();

  
  pushMatrix();
  translate(width/2,height/2+100,-2000+sin(frameCount*0.01)*2000.);
  scale(55);
//  scale(1);
  model.drawMode(mode);
  model.draw();

//  for(int i=0; i < 5; i++){
//   translate(i*10+10,0,0);
//   model.draw(); 
//  }
    
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

