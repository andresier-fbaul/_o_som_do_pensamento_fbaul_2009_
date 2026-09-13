///multisketch
import processing.opengl.*;
import TUIO.*;
TuioProcessing tuioClient;
TuioProcessing tuioClient2;

//-----
float cursor_size = 75;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
PFont font;

float cursor_size2 = 15;
float object_size2 = 60;
float table_size2 = 760;
float scale_factor2 = 1;
PFont font2;
//----


int sketch=0;
int sketchnum=2;

void setup(){
  // size(700,700,OPENGL); 
  // size(screen.width,screen.height);
   size(700,700);
   frameRate(60);
   init_sketches(); 
  // noLoop(); 
}

void draw(){
  switch(sketch){
    case 0: draw_sketch0(); break;
    case 1: draw_sketch1(); break;
  }
}

void keyPressed(){
  
 /* if (key == 's')
   saveFrame("desenhar-1-####.png");//save();
 if (key == ' ')
   background(150);
   */

 sketch = (sketch+1)%sketchnum;//(int)random(sketchnum);

}


void init_sketches(){
  setup_sketch0();
  setup_sketch1();
}

void addTuioObject(TuioObject tobj) {
  println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
          +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
          +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
  redraw();
}

