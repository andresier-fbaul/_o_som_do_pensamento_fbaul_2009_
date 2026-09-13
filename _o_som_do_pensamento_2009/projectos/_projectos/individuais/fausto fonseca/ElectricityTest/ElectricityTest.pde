import processing.opengl.*;

ElectricityFX efx;

void setup(){


  size(700,500,OPENGL);
  frameRate(30);
  smooth();
  efx = new ElectricityFX();
  

}


void draw()
{
  background(0,0,0);
  efx.GenerateArc(0,0,mouseX,mouseY);
}

void keyPressed(){

}


