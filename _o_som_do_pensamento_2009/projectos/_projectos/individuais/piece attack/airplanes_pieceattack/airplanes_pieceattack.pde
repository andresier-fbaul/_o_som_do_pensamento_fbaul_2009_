
/// airplanes   peace attack

import saito.objloader.*;
import processing.opengl.*;

OBJModel model;

float ca=HALF_PI;
PFont font;

void setup(){ 
   size(1000, 600, OPENGL);
//   model = new OBJModel(this, "boeing_triangles.obj");
//   model = new OBJModel(this, "boeing_polygons.obj");
//   model = new OBJModel(this, "747.obj");
//   model = new OBJModel(this, "747_objfront_Scene.obj");
//   model = new OBJModel(this, "f-16.obj");
   model = new OBJModel(this, "boeing_1587triangles.obj");
//   model = new OBJModel(this, "boeing_2029triangles.obj");
//   model = new OBJModel(this, "boeing_2735triangles.obj");
//   model = new OBJModel(this, "boeing_polygons_2735triangles.obj");
   
    
//   model = new OBJModel(this, "makeMeWalk.obj");

  font = createFont("arial",12);
  textFont(font);
}

void draw(){
  background(255);
  
  pushMatrix();
  translate(0,height/2+50,-1000+sin(frameCount*0.01)*1000.);
  scale(25);
  model.drawMode(mode);
  model.draw();

//  for(int i=0; i < 5; i++){
//   translate(i*10+10,0,0);
//   model.draw(); 
//  }
    
  popMatrix();
    
}

int mode = QUADS;
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

