/**
 * modificado do exemplo; carregar na tecla g para começar a gravar
 * e novamente no g para parar
 */

import processing.video.*;

MovieMaker mm;
boolean gravar = false;

void setup() {
  size(320, 240);

  // Save uncompressed, at 15 frames per second
  // mm = new MovieMaker(this, width, height, "drawing.mov");

  // Or, set specific compression and frame rate options
  //mm = new MovieMaker(this, width, height, "drawing.mov", 30, 
  //                    MovieMaker.ANIMATION, MovieMaker.HIGH);

  background(160, 32, 32);
}


void draw() {
  stroke(7, 146, 168);
  strokeWeight(4);

  // Draw if mouse is pressed
  if (mousePressed && pmouseX != 0 && mouseY != 0) {
    line(pmouseX, pmouseY, mouseX, mouseY);
  }

  if(gravar)// Add window's pixels to movie
    mm.addFrame();
}


void keyPressed() {

  if (key == 'g') {

    if(!gravar){
      mm = new MovieMaker(this, width, height, "video.mov", 30, 
      MovieMaker.JPEG, MovieMaker.HIGH);
      gravar = true;
    } 
    else {

      // Finish the movie if space bar is pressed
      mm.finish();
      // Quit running the sketch once the file is written
      exit();

    } 

  }

}




