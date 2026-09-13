import processing.core.*; 
import processing.xml.*; 

import ddf.minim.*; 

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

public class pedro_projecto extends PApplet {


// import a library


// um objecto da biblioteca
Minim minim;
// o objecto do input sonoro
AudioInput in;

// o valor do audio para ser passado por um filtro
float audio_energy;

// a array de tri\u00e2ngulos
sndTri  tris[];
int numtris = 100;

float minSND = 0.01f; //0.001


public void setup(){

  size(screen.width,screen.height);
//  size(700,700);

  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 512);


  // load images
  loadImages();


  tris = new sndTri[numtris];
  for(int i=0; i<tris.length;i++){
     tris[i] = new sndTri(); 
  }

  background(0);
}



public void draw(){
 background(0);

//  fill(0,25);
//  noStroke();
//  rect(0,0,width,200); // s\u00f3 apaga at\u00e9 \u00e0 posi\u00e7\u00e3o 200 y
//
//
//  stroke(255,150);
//
//  // draw the waveforms
//  for(int i = 0; i < in.bufferSize() - 1; i++){
//    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
//    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
//  }


  //   o valor da energia do som vai-se usar para escalar o raio do tri
  //   passado com um filtro lowpass para suavizar as transi\u00e7\u00f5es

  float rms = in.mix.level();
  float f = 0.1f;
  audio_energy = audio_energy * (1.f-f) + rms * f;

//println(audio_energy);
 
   // renderizar todos os triangulos
 
 
   for(int i=0; i<tris.length;i++){
     tris[i].update();
     tris[i].draw(); 
     
     // check distance & line if < thresh
      for(int j=i+1; j<tris.length;j++){
       float d = abs(tris[i].px-tris[j].px) + abs(tris[i].py-tris[j].py); 
       if(d < 100){
        stroke(tris[i].cfill,12);
        line(tris[i].px,tris[i].py,tris[j].px,tris[j].py);
       }
      }
  }

 

}



public void keyPressed(){
  if(key=='s')
    saveFrame("sndhumans-######.jpg"); 
}





PImage h[] = new PImage[8];
PImage m[] = new PImage[8]; // celula mask


public void loadImages(){
 
  // retirado do exemplo Alphamask
  
 for(int i=1; i < 8; i++) {
   h[i] = loadImage("f.jpg");
   m[i] = loadImage("fm.jpg");
   h[i].mask(m[i]);
   //println("acabei de ler "+"humanmasks/h"+i+".jpg e sua m\u00e1scara humanmasks/m"+i+".jpg");
 } 

  
}
/// agora a class sndTri segue a l\u00f3gica do jogo, se o som
/// for inferior, altera a dir e n\u00e3o anda, sen\u00e3o anda e n\u00e3o altera a direc\u00e7\u00e3o


class sndTri{

  
  PImage img;
  
  // o centro do tri\u00e2ngulo
  float px = random(width), py = random(height);
  // o tamanho do triangulo
  float rad=50;
  // a inclina\u00e7\u00e3o do tri\u00e2ngulo
  float angulo;  

  float speed;
  int mode; // 0 = no audio interaction; 1 = audio interaction; 2 = py audio

  float speedmax,speedmin;
  float radmax,radmin;
  float angmax,angmin;

  int  cfill,cstroke;


  sndTri(){
    
    img = h[(int)random(1,8)];
    
    mode = (int)random(3);//2);
    speed = random(0.5f,2.f);
    rad = random(20,70);

    //color
    boolean c = (random(1)<0.5f);
    cfill=(c)?color(255):color(0);
    cstroke=(c)?color(0):color(15);//(255);


    py = random(200,400);

    // mins e maxs para as escalas
    speedmax = random(10,50.0f);
    speedmin = random(0.f,0.2f);
    radmax = random(55,250);
    radmin = random(5,20);
    angmax = random(1)<0.5f? -random(0.01f,2.7f):random(0.01f,2.7f);
    angmin = random(-0.001f,0.001f);    
  }

  public void update(){

    rad = map (audio_energy, 0.f , 0.1f , radmin,radmax);//50, 250);

    speed = map(audio_energy, 0.f, 0.1f, speedmin, speedmax);// 1.1, 15.);

    if(audio_energy < minSND){
      // agora tende a ir ter com o rato
      float dif = atan2(mouseY-py,mouseX-px) + HALF_PI;
      angulo = angulo*0.5f + dif*0.5f;//map(audio_energy, 0., 0.1, angmin, angmax);//-0.001, 0.3);
      px = px + cos(angulo-HALF_PI)*speed;
      py = py + sin(angulo-HALF_PI)*speed;
 
    
    }else{
      angulo += random(-0.1f,0.1f);
      px = px + cos(angulo-HALF_PI)*speed;
      py = py + sin(angulo-HALF_PI)*speed;
 
   //   angulo += 0.1*map(audio_energy, 0.002, 0.01, angmin, angmax);//-0.001, 0.3);
 
 
    }
    //wrap das coords
    if(px > width)
      px = px - width;
    if(px < 0)
      px += width;

    if(py > height)
      py -= height ;
    if(py < 0)
      py += height ;




  }

  public void draw(){

    fill(cfill,20);
    stroke(cstroke,20);

    pushMatrix();

    translate(px,py);

    rotate(angulo);

    tint(255,150);
    image(img, -rad/2, -rad/2, rad, rad);

//    beginShape();
//    vertex(0, -rad);
//    vertex(rad/2, rad);
//    vertex(-rad/2, rad);
//    endShape(CLOSE);    


    popMatrix();

  }



}











  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--hide-stop", "pedro_projecto" });
  }
}
