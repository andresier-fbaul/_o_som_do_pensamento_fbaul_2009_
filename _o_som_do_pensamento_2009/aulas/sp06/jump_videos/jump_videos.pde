/**
 * jump to a videoplace  
 */

import processing.video.*;

Movie myMovie;
float movieDur;

void setup() {
  size(640, 480, P2D);
  background(0);
  // Load and play the video in a loop
  myMovie = new Movie(this, "station.mov");
  myMovie.loop();
  movieDur = myMovie.duration(); //get the duration
  println("dur "+movieDur);
}

void movieEvent(Movie myMovie) {
  myMovie.read();
}

void draw() {
  
  float pos = constrain( map(mouseX,0,width,0.,1.), 0.,1.);
  pos = pos * movieDur;
  
  myMovie.jump(pos);
//  myMovie.read();
  tint(255, 20);
  image(myMovie, 0,0,width,height);
}
void keyPressed(){
  if(key=='s')
    saveFrame("video-######.jpg"); 
}

