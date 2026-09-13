
/*
 starfield / um campo de estrelas, o som do pensamento 2009
 mouseX controla a velocidade
 mouseY controla a rotação
 */

import processing.opengl.*;
import processing.video.*;


MovieMaker mm;
boolean gravar = false;

PImage img[]; //as imagens
star s[]; // as estrelas
plane p[]; // os planos

float speed = 5; // a velocidade
float rotspeed = 1e-7; // a velocidade de rotação
float rot; //


void setup(){
  //  size(1280,720,OPENGL);
  size(914,514,OPENGL); // 720p / 1.4
  hint(DISABLE_OPENGL_2X_SMOOTH);  

  // Load the image
  img = new PImage[10];
  for(int i=0; i < 10; i++){
    img[i] = loadImage("img"+i+".png");
  }


  // a perspectiva defeito do opengl
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(PI * fov / 360.0);
  perspective(fov, float(width)/float(height), 
  0.001, 10000.0);//cameraZ/10.0, cameraZ*10.0);

  s = new star[1000];
  for(int i=0; i<s.length;i++)
    s[i]=new star();

  p = new plane[100];

  for(int i=0; i<p.length;i++) {
    p[i]=new plane(img[i%10]);
  }

  if(gravar)// Add window's pixels to movie
    mm.addFrame();


}

void draw(){

  //  if(mousePressed)
  speed = map(mouseX, 0, width,0.,100.);
  rotspeed = map(mouseY, 0, height, -1e-2, 1e-2);
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
    
   if(gravar)
    mm.addFrame(); 
    
}


void keyPressed() {
  if(key=='s')
    saveFrame("starfieldimg-######.jpg"); 

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


