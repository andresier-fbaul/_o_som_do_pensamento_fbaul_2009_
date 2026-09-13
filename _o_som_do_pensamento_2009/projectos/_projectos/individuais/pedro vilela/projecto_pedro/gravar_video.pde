import processing.video.*;

MovieMaker mm;
boolean gravar = false;


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
