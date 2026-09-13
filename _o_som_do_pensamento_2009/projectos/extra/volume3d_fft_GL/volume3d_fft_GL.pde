// desenhar linhas 3d a partir de um centro
// e rodar a câmara em torno da cena

// o som do pensamento 2009


import processing.opengl.*;
import javax.media.opengl.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in; // o objecto do input sonoro
AudioPlayer player; // ou um player de som
FFT fft;

GL gl;

Linha3d l[]; // as linhas
int maxlinhas = 1000;

float rx;


void setup(){
  //  size(1280,720,OPENGL);
  size(700,700,OPENGL); // 720p / 1.4
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(in.bufferSize(),in.sampleRate());
//  player =  minim.loadFile("sound.wav");
//  player.loop();
//  fft = new FFT(player.bufferSize(),player.sampleRate());


  // a perspectiva defeito do opengl
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(PI * fov / 360.0);
  perspective(fov, float(width)/float(height), 
  0.001, 10000.0);//cameraZ/10.0, cameraZ*10.0);

  l = new Linha3d[maxlinhas];
  for(int i=0; i<l.length;i++)
    l[i]=new Linha3d();


}

void draw(){  
    fft.forward(in.mix);
//    fft.forward(player.mix);
   
  background(0);
  
  float angle = (frameCount*0.01);
  float raio = 1000;
  // camera (posx, posy, posz, lookatx, lookaty, lookatz, upx, upy, upz  );
  camera(cos(angle)*raio,0,sin(angle)*raio, 0, 0, 0, 0,1,0);

//  rx += map(mouseY,0,height,-0.01,0.01);

  rx = map(mouseY,0,height,-PI,PI) * 360;



  gl = ((PGraphicsOpenGL) g).gl;
  gl.glPushMatrix();
//  gl.glTranslatef(width/2,height/2,0);
  gl.glRotatef(rx,1,0,0);
  gl.glBegin(gl.GL_LINE_STRIP);
  for(int i=0; i<l.length;i++)
    l[i].callverts();

  gl.glEnd();
  gl.glPopMatrix();

 
  
}

void keyPressed(){
  if(key=='s')
    saveFrame("linhas3dfft-######.jpg"); 
}


