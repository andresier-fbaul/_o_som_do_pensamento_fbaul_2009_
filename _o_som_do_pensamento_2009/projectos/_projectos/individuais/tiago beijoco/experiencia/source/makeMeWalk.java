import processing.core.*; 
import processing.xml.*; 

import saito.objloader.*; 
import processing.opengl.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class makeMeWalk extends PApplet {



OBJModel model;
float rotX;
float rotY;

public void setup(){ 
   size(800, 800, OPENGL);
   model = new OBJModel(this, "makeMeWalk.obj");
}

public void draw(){
  background(51);
  noStroke();
  lights();
  pushMatrix();
    translate(width/2, height * 2/3, 0);
//    rotateX(rotY);
    rotateY(rotX);
    scale(200.0f);
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

public void keyPressed()
{
   if(key == 'a')
   model.enableTexture();

   else if(key=='b')
   model.disableTexture();
}

public void mouseDragged()
{
   rotX += (mouseX - pmouseX) * 0.01f;
   rotY -= (mouseY - pmouseY) * 0.01f;
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DCD9DF", "makeMeWalk" });
  }
}
