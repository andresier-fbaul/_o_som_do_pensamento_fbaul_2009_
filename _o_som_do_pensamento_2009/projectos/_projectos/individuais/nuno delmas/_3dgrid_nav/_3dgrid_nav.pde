
import processing.opengl.*;
import javax.media.opengl.*;
import javax.media.opengl.glu.*;
import java.nio.*; 

PGraphicsOpenGL pgl;
GL gl;
GLU glu;

/// 3d user grid /// andré sier /// 20080827

boolean draw_lines = false;
Player player;
WorldGrid world;

void setup(){
  size(1000,600,OPENGL);
  frameRate(60);
  player = new Player();
  world = new WorldGrid(7,7,5);
}

void draw(){

  pgl = (PGraphicsOpenGL) g; 
  gl = pgl.gl;
  glu = pgl.glu;
  gl.setSwapInterval(1); // vsync

  gl.glClearColor(0,0,0,1f);
  gl.glClear( GL.GL_COLOR_BUFFER_BIT | GL.GL_DEPTH_BUFFER_BIT);

  player.run();
  world.render( player.pos );




}

