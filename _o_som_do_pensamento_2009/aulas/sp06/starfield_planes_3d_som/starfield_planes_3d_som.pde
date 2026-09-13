
/*
 starfield / um campo de estrelas, o som do pensamento 2009
 mouseX controla a velocidade
 mouseY controla a rotação
 */

import processing.opengl.*;
import ddf.minim.*;

Minim minim;
AudioInput in; // o objecto do input sonoro

star s[]; // as estrelas
plane p[]; // os planos

float speed = 5; // a velocidade
float rotspeed = 1e-7; // a velocidade de rotação
float rot; //


void setup(){
  //  size(1280,720,OPENGL);
  size(914,514,OPENGL); // 720p / 1.4
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);

  // a perspectiva defeito do opengl
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(PI * fov / 360.0);
  perspective(fov, float(width)/float(height), 
  0.001, 10000.0);//cameraZ/10.0, cameraZ*10.0);

  s = new star[1000];
  for(int i=0; i<s.length;i++)
    s[i]=new star();

  p = new plane[100];
  for(int i=0; i<p.length;i++)
    p[i]=new plane();

}

void draw(){

  float av = in.mix.level();   
  speed = map(av, 0., 0.1,0.,100.);//map(mouseX, 0, width,0.,100.);
  rotspeed = 0.;//map(mouseY, 0, height, -1e-2, 1e-2);
  rot = rot + rotspeed; //aculumar as rotações

  background(0);
  stroke(255,250);
  fill(255,50);

  translate(width/2,height/2);
  rotate(sin(rot)*TWO_PI);

  for(int i=0; i<s.length;i++)
    s[i].render();

  for(int i=0; i<p.length;i++)
    p[i].render();
}


void keyPressed(){
  if(key=='s')
    saveFrame("starfieldsom-######.jpg"); 
}

