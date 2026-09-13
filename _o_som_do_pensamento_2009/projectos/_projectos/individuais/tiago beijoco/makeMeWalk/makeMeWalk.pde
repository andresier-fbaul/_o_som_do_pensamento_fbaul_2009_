import saito.objloader.*;
import processing.opengl.*;
OBJModel model;
float rotX;
float rotY;

void setup(){ 
   size(800, 800, OPENGL);
   model = new OBJModel(this, "makeMeWalk.obj");
}

void draw(){
  background(51);
  noStroke();
  lights();
  pushMatrix();
    translate(width/2, height * 2/3, 0);
//    rotateX(rotY);
    rotateY(rotX);
    scale(200.0);
    pushMatrix();
      if(keyPressed){
        if(key == CODED){
          if(keyCode == UP){
            translate(0,0,1);
          }
          if(keyCode == DOWN){
            translate(0,0,-1);
          }
        }
      }
      model.drawMode(QUADS);
      model.draw();
    popMatrix();
  popMatrix();
}

void keyPressed()
{
   if(key == 'a')
   model.enableTexture();

   else if(key=='b')
   model.disableTexture();
}

void mouseDragged()
{
   rotX += (mouseX - pmouseX) * 0.01;
   rotY -= (mouseY - pmouseY) * 0.01;
}
