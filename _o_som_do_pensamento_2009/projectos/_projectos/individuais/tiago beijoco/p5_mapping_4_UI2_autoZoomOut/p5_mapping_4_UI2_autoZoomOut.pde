import saito.objloader.*;
import processing.opengl.*;

OBJModel hull;
Rover rover;  // rover object
Path path;  // rover path
CheckPoints checkPoints;  // path checkpoints
Cam cam;  // camera
Radar radar;  // radar object
public boolean terminate;  // drawing_viewing switch

void setup(){
  size (1280,720, OPENGL);
  frameRate(25);
  hull = new OBJModel(this, "rover.obj");
  rover = new Rover();
  path = new Path();
  checkPoints = new CheckPoints();
  cam = new Cam();
  radar = new Radar();
  terminate=false;
}

void draw(){
  background(255);
  if(!terminate){
    rover.update();
    noLights();
    cam.update();
    path.update();
    checkPoints.update();
    radar.update();
  }
  else{
    rover.render();
    cam.zoomOut();
    path.zoomOut();
    checkPoints.update();
  }
}

void initiate(){
  rover.initiate();
  cam.initiate();
  checkPoints.initiate();
  path.initiate();
  terminate=false;
}

void mousePressed(){
  if(!path.start){
    path.start = true;
    path.minX = path.maxX = rover.px;
    path.minZ = path.maxZ = rover.pz;
  }
  if(!path.trace)
    path.trace = true;
  else{
    path.trace = false;
    path.points.add(new Pt(rover.px, rover.pz, path.trace));
  }
}

void keyPressed(){
  if(key == ' '){
    if(!terminate)
      terminate = true;
    else
      initiate();
  }
}


