/*

  slit scan 3d, o som do pensamento, 2009

 */
  
import processing.video.*;
import processing.opengl.*;


Movie video;
PImage tex;
float px;
int videoloc;

void setup() {
 //bug 882 processing 1.0.1
  try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }
  
  size(1024, 512, OPENGL);  
  // Uses the default video input, see the reference if this causes an error
//  video = new Capture(this, 320, 240, 30);
  video = new Movie(this, "20847.mov");//new Capture(this, 320, 240, 30);
  video.loop();
  tex = new PImage(256,128);   //new PImage(512,256);  
  background(0);
  videoloc = video.width/2;
  
    // a perspectiva defeito do opengl
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(PI * fov / 360.0);
  perspective(fov, float(width)/float(height), 
  0.001, 10000.0);//cameraZ/10.0, cameraZ*10.0);

}


void movieEvent(Movie video) {
  video.read();
}


float speed = 2;

void draw() {
 // if (video.available()) {
 //   video.read();
 println("fps: "+frameRate);
    
 // img.copy(srcImg, sx, sy, swidth,  sheight, dx, dy, dwidth, dheight);
   tex.copy(video,   videoloc, 0, ceil(speed), video.height, 
                        (int)px, 0, ceil(speed), tex.height);
 
      px = px + speed;
      if(px >= tex.width)
        px = 0;
        
 //    image(frame,0,0,width,height);   
  
//  tex.updatePixels();
  
  float dimx = 512;
  float dimy = 256;
  
    //draw
    background(0);
    pushMatrix();     
    translate(width/2,height/2,-550.0f);
    rotateX(map(mouseY,0,height,PI,0.));
    rotateY(map(mouseX,0,height,0,TWO_PI));
    beginShape();
    texture(tex);
    vertex(-dimx,-dimy,0,0);
    vertex( dimx,-dimy,tex.width,0);
    vertex( dimx, dimy,tex.width,tex.height);
    vertex(-dimx, dimy,0,tex.height);
    endShape(CLOSE);
    popMatrix();     
}


void keyPressed(){
  if (key=='s'){
    saveFrame("slit3d-#####.jpg");
  }  
}

