/**
 * Loop. 
 * 
 * Move the cursor across the screen to draw. 
 * Shows how to load and play a QuickTime movie file.  
 */

import processing.video.*;

Movie myMovie;

void setup() {
  size(640, 480, P2D);
  background(0);
  // Load and play the video in a loop
  myMovie = new Movie(this, "station.mov");
//  myMovie.loop();
  myMovie.play();
}

void movieEvent(Movie myMovie) {
  myMovie.read();
}

void draw() {
   
 // myMovie.read();
  tint(255, 20);
//  image(myMovie, mouseX-myMovie.width/2, mouseY-myMovie.height/2);
  image(myMovie,0,0,width,height);
  
  if(mousePressed){
    myMovie.jump(0);
    myMovie.play();
  }
  
}
