/*

  slit scan, o som do pensamento, 2009

 */
  
import processing.video.*;

Capture video;
PImage frame; // uma única frame
float py;
int videoloc;
float speed=1;

void setup() {
  size(320, 720, P2D);  
  // Uses the default video input, see the reference if this causes an error
  video = new Capture(this, 320, 240, 30);
  frame = new PImage(width,height);  
  background(0);
  videoloc = video.height/2;
}


void draw() {

  if (video.available()) {

    speed = map(mouseY,0,height,0,10);
    video.read();
    
//    frame.copy(video,   videoloc, 0, 1, height, 
//                        px, 0, 1, height);

// img.copy(srcImg, sx, sy, swidth,  sheight, dx, dy, dwidth, dheight);

    frame.copy(video,   0, videoloc, width,  ceil(speed), 
                        0, (int)py, width, ceil(speed));
 
      py = py + speed;
      if(py >= height)
        py = 0;
        
     image(frame,0,0,width,height);   
    }
  
}

void keyPressed(){
  if (key=='s'){
    saveFrame("slit2av-#####.jpg");
  }  
}

