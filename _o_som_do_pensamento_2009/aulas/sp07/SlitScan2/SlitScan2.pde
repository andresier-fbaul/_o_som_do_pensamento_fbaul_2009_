/*

  slit scan, o som do pensamento, 2009

 */
  
import processing.video.*;

Capture video;
PImage frame; // uma única frame
int px;
int videoloc;

void setup() {
  size(640, 240, P2D);  
  // Uses the default video input, see the reference if this causes an error
  video = new Capture(this, 320, 240, 30);
  frame = new PImage(width,height);  
  background(0);
  videoloc = video.width/2;
}


void draw() {
  if (video.available()) {
    video.read();
    
 // img.copy(srcImg, sx, sy, swidth,  sheight, dx, dy, dwidth, dheight);
   frame.copy(video,   videoloc, 0, 1, height, 
                        px, 0, 1, height);
 
      px = px + 1;
      if(px >= width)
        px = 0;
        
     image(frame,0,0,width,height);   
    }
  
}


void keyPressed(){
  if (key=='s'){
    saveFrame("slit2-#####.jpg");
  }  
}

