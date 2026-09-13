
import processing.opengl.*;
import javax.media.opengl.*;
import java.nio.*;


PGraphicsOpenGL pgl;
GL gl;

ArrayList bolas = new ArrayList();
ArrayList obstaculos = new ArrayList();
float spring=0.33;
float friccao = 0.9991;


void setup(){
  size (700,500,OPENGL); 
  init_scene();
  init_mesh(1.0f);//(200);
   // a perspectiva defeito do opengl
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(PI * fov / 360.0);
  perspective(fov, float(width)/float(height), 
  0.001, 10000.0);//cameraZ/10.0, cameraZ*10.0);

}

void draw(){

    pgl = ((PGraphicsOpenGL)g);
    gl = ((PGraphicsOpenGL)g).gl;

   gl.glEnable(GL.GL_BLEND);
   gl.glBlendFunc(GL.GL_ONE,GL.GL_SRC_ALPHA);
 //  gl.glDepthMask(false);
 //  gl.glDisable(GL.GL_DEPTH_TEST);
  gl.glEnable(GL.GL_DEPTH_TEST);

 
 
  background(0);


  float angle = map(mouseX,0,width,0,2*TWO_PI);//(frameCount*0.01);
  float raio = 1000;
  float ele = map(mouseY,0,height,-1000,1000);
  // camera (posx, posy, posz, lookatx, lookaty, lookatz, upx, upy, upz  );
  camera(cos(angle)*raio,ele,sin(angle)*raio, 0, 0, 0, 0,1,0);



 for(int i=0; i<obstaculos.size(); i++){
  Obstaculo o = (Obstaculo) obstaculos.get(i);
  o.render();
 } 

 for(int i=0; i<bolas.size(); i++){
  Bola b = (Bola) bolas.get(i);
  b.render(i);
 } 
  
}

void mouseReleased(){
   Bola b = new Bola(mouseX,mouseY);
   bolas.add(b);
}


void init_scene(){
 int num_ob = (int) random(10,20);
 int num_bolas = (int) random(10,20);
 
 for(int i = 0; i < num_ob; i++) {
   Obstaculo o = new Obstaculo();
   obstaculos.add(o);   
 }
 for(int i = 0; i < num_bolas; i++) {
   Bola b = new Bola();
   bolas.add(b);   
 }
  
}

void keyPressed(){
  if(key=='s')
    saveFrame("bolasobstaculos-#####.jpg");
}
