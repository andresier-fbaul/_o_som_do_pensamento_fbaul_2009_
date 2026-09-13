import processing.opengl.*;
import javax.media.opengl.*;
import java.nio.*; 

//opengl
PGraphicsOpenGL pgl;
GL gl;


ArrayList balls = new ArrayList();
float a;

PVector world_pos_min = new PVector ( 0.0f, 0.0f, -100.0f  );
PVector world_pos_max = new PVector ( 1000.0f, 600.0f, -1000.0f  );
PVector world_pos_c = new PVector ( (world_pos_min.x+world_pos_max.x)/2.0f, 
(world_pos_min.y+world_pos_max.y)/2.0f,
(world_pos_min.z+world_pos_max.z)/2.0f );
float spring=0.025;//0.05;//0.05;
float friccao=0.999;//0.99991;//1.0f;//0.9975;
float grav = 1;//0.25;//0.72;



void setup(){
  size(1000,600,OPENGL);
  frameRate(30);
  sphereDetail(5);

  for(int i = 0; i < 10; i++) {
    Bola b = new Bola(random(width),random(100),random(world_pos_min.z,world_pos_max.z),balls); 
    balls.add(b);
  }
  
  
  // a perspectiva defeito do opengl
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(PI * fov / 360.0);
  perspective(fov, float(width)/float(height), 
  0.001, 10000.0);//cameraZ/10.0, cameraZ*10.0);
  
  
  background(0);
}



void add_ball(){
  Bola b = new Bola (mouseX, random(100), world_pos_c.z , balls);
  balls.add(b);
  println("esferas: "+balls.size());
}

void draw(){


  pgl= ((PGraphicsOpenGL)g);
  gl= pgl.beginGL();
  gl.glClearColor( 0.0, 0.0, 0.0, 0.01);//1.00);//0.01 ); 
  gl.glClear(  GL.GL_DEPTH_BUFFER_BIT ) ; 
//  gl.glDisable( GL.GL_DEPTH_TEST ) ;
  gl.glEnable( GL.GL_DEPTH_TEST ) ;


  //  background(0);

  gl.glEnable( GL.GL_BLEND ) ;
  gl.glBlendFunc(GL.GL_ONE,GL.GL_ONE_MINUS_SRC_ALPHA); /// este arrasto brutal
  // gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE_MINUS_SRC_ALPHA);

  gl.glDepthMask(false);

  //      gl.glBlendFunc(GL.GL_ONE, GL.GL_ONE_MINUS_SRC_ALPHA);//,GL.GL_ONE_MINUS_SRC_ALPHA);//GL.GL_ONE);//GL.GL_ONE_MINUS_SRC_ALPHA);

  if(keyPressed&&key=='a')
    add_ball();


  fill(0,5);
  noStroke();
  rect(0,0,width*5,height*5);
  stroke(0,25);


  gl.glTranslatef(width/2.0,height/2.0,555.0f);


  drawWorldBox();

  // fill(255,100);
  fill(255); 
  stroke(0);
  for(int i=0; i < balls.size(); i++) {
    Bola b = (Bola) balls.get(i);
    if(mousePressed){
      //apply force towards mouse
      float dx = (mouseX-b.pos.x);//(b.pos.x - mouseX);
      float dy = (mouseY-b.pos.y);
      float len = sqrt(dx*dx+dy*dy);
      dx/=len; 
      dy/=len;
      float force = 0.5;//0.1;
      dx*=force; 
      dy*=force;
      b.apply_force(new PVector(dx,dy,0));
    }
    b.render(i);
  }




}


void keyPressed(){
  if(key=='s')
    saveFrame("bolas_vector_3d-#####.jpg");

}



