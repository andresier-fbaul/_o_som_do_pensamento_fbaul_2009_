
/**
 * slomo aka "The place where good intentions come to rest"
 */

import processing.opengl.*;
import javax.media.opengl.*; 
import processing.video.*;

float movieSizeFactor = 6.0;

float sketchFPS = 23.98; // this must match the src movie frame rate
float sketchFrameDur = 1.0 / sketchFPS;

float maxDurFactor = 20; /// these multiply the normal duration of a sketch frame
float minDurFactor = 0.01;

float timeDisturbancesMinDurFactor = 0.94;

 
float movieDur;
float frameDur;
float durFactor;
float nextPos;
int baseFrameIndex;
float inFrameRatio; // 0..1 pos inside the frame
float timeDisturbancesIntensity;
int syncLoss;


Movie movie;
MovieMaker movieMaker;
boolean movieMaking;

PImage baseFrame;
PGraphics nextFrame;
PGraphics ghostFrame;

PFont cameraFont;
int cameraFontSize = 64;

int ghostPalette[] = {0xffffff, 0xffb648, 0x092961, 0x102410, 0x3a1e00};

PGraphicsOpenGL pgl;
GL gl;




void setup() {
  movie = new Movie(this, "station.mov");
  movie.read();

  size((int)(movie.width * movieSizeFactor), 
       (int)(movie.height * movieSizeFactor), 
       OPENGL);
  smooth();
  frameRate((float)sketchFPS);
  
  movie.noLoop();
  movie.stop();
  movieDur = movie.duration(); //get the duration
println("dur "+movieDur);

  cameraFont = loadFont("Arial-Black-" + cameraFontSize + ".vlw");

  baseFrame = createImage(movie.width,movie.height, RGB);
//  nextFrame = createImage(movie.width,movie.height, RGB);
  nextFrame = createGraphics(movie.width,movie.height,P2D);
  ghostFrame = createGraphics(movie.width,movie.height,P2D);

  ghostFrame.beginDraw();
  ghostFrame.background(0x01000000);
  ghostFrame.endDraw();

  createEmptyWords();

  durFactor=20.0;
  frameDur = sketchFrameDur * durFactor;
  baseFrameIndex=-1;
  nextPos = 0.0;

  syncLoss=0;
  movieMaking=false;

  HandleTimePassage();
}

/*
void movieEvent(Movie aMovie) {
println("here");
aMovie.read();
}*/


void copyFrame(PImage dest, PImage src){
  src.loadPixels();
  arrayCopy(src.pixels, dest.pixels); 
  dest.updatePixels();
}

void decAlpha(PImage dest, int dec){
  dest.loadPixels();

  int count = dest.width*dest.height;
  color  c;
  int a;
  for (int i = 0; i < count; i++) {
    c=dest.pixels[i];
    a=((c>>24) & 0xff) - dec;
    if(a < 0)
      a=0;
    dest.pixels[i] = (c & 0xffffff) | (a << 24);
  }
  
  dest.updatePixels();
}




void _copyFrame(PImage dest, PImage src){
  dest.copy(src, 0,0, src.width,src.height, 0,0, src.width,src.height);
}



void HandleTimePassage(){
  
  nextPos = nextPos + frameDur;
  nextPos = nextPos % movieDur;

  boolean newFrame = false;
  
// are we in a new frame?
  int nextFrameIndex = (int)(nextPos / sketchFrameDur);
  if(nextFrameIndex != baseFrameIndex){
    baseFrameIndex=nextFrameIndex;
    copyFrame(baseFrame, nextFrame);

// load nextFrame (which next time will be baseFrame)
    double nextNextPos=(nextFrameIndex+1) * sketchFrameDur;
    nextNextPos = nextNextPos % movieDur;
    movie.jump((float)nextNextPos);
    movie.read();
    copyFrame(nextFrame, movie);

    newFrame = true;
//    println("base: " + nextPos + " next: " + nextNextPos);
  }
  
  if(newFrame)
    inFrameRatio = 0;
  else {
    inFrameRatio = (nextPos - (baseFrameIndex * sketchFrameDur)) / sketchFrameDur;
    inFrameRatio = constrain(inFrameRatio, 0.0,1.0);
  }
//  println("inFrameRatio: " + inFrameRatio);

  applyTimeDisturbances();
}


// called with durFactor <= timeDisturbancesMinDurFactor
void applyTimeDisturbances(){
  
  if(inFrameRatio == 0){ // new nextFrame
    if(timeDisturbancesIntensity < 0.2)
      return;

    if(timeDisturbancesIntensity > 0.4){ // time for the ghost ideas (of the platform towards the train)
    
      decAlpha(ghostFrame, 32);
    
      int px = (int)random(0,nextFrame.width);
      int py = (int)random(0,nextFrame.height);
      int rx = (int)random(nextFrame.width * 0.3,nextFrame.width * 0.7);
      int ry = (int)random(10,nextFrame.height * 0.2);
      
      color srcColor = 0xff000000 | ghostPalette[ (int)random(0,ghostPalette.length) ]; //nextFrame.get(px,py);
      ghostFrame.beginDraw();
      ghostFrame.noStroke();
      ghostFrame.fill(srcColor);
      ghostFrame.ellipse(px-rx,py-ry, rx*2,ry*2);
      ghostFrame.endDraw();
      

      float intensity = map(timeDisturbancesIntensity, 0.5,1, 32,255);
      nextFrame.beginDraw();
      nextFrame.tint(255, intensity);
      nextFrame.image(ghostFrame,0,0);
      nextFrame.endDraw();
      
/*      
      
      nextFrame.blend(ghostFrame, 
                      0,0, nextFrame.width, nextFrame.height,
                      0,0, nextFrame.width, nextFrame.height, 
                      OVERLAY);
      nextFrame.copy(ghostFrame, 
                     0,0, nextFrame.width, nextFrame.height,
                     0,0, nextFrame.width, nextFrame.height);
*/                     
    }
    else {
      ghostFrame.beginDraw();
      ghostFrame.background(0x01000000);
      ghostFrame.endDraw();
    }

    float intensity = map(timeDisturbancesIntensity, 0.2,0.7, 0,1);
    intensity=constrain(intensity, 0,1);    
    
    if(timeDisturbancesIntensity >= 0.4){
      int colors = (int)map(intensity, 0,1, 16,2);
      nextFrame.filter(POSTERIZE, colors);    
    }
    
    float blur = map(intensity, 0,1, 0.1, 6);
    nextFrame.filter(BLUR, blur);
//println("colors: " + colors + " blur: " + blur);
  }

}


void draw() {
//  background(0);


// update durations:
  if(mousePressed){
    if(mouseY < height/3)
      durFactor = map(mouseY, 0,height/3, maxDurFactor,1.0);
    else {
      durFactor = map(mouseY, height/3,height, 1.0, minDurFactor);
      durFactor = durFactor*durFactor; // quadratic for extra sensitivity
    }
    durFactor=constrain(durFactor, minDurFactor, maxDurFactor);
    
    if(durFactor <= timeDisturbancesMinDurFactor){
      float d = durFactor / timeDisturbancesMinDurFactor;
      timeDisturbancesIntensity = log(d) / log(minDurFactor);
      timeDisturbancesIntensity = constrain(timeDisturbancesIntensity,0,1);
    }
    else
      timeDisturbancesIntensity=0.0f;
    
    frameDur = sketchFrameDur * durFactor;
  }

println("timeDisturbancesIntensity: " + timeDisturbancesIntensity);  

  HandleTimePassage();
  

// draw
  pgl = (PGraphicsOpenGL) g;
  gl = pgl.beginGL();
  gl.glDisable(GL.GL_DEPTH_TEST);
  pgl.endGL();
  
  
//  frameBuffer.
  if(timeDisturbancesIntensity >= 0.89){ // time interference in the camera causes sync loss
    if(random(0,1) < 0.005)
      syncLoss=12;
  }

  if(syncLoss > 0){
    int px = 0;
    int py = (int)random(-height/8,height/8);
    translate(px,py);
    syncLoss--;
  }

  float t = (1.0-inFrameRatio) * 255;
  tint(255,t);
  image(baseFrame, 0,0, width,height);
  tint(255,255-t);
  image(nextFrame, 0,0, width,height);
  
  
  if(timeDisturbancesIntensity >= 0.7){ // time interference in the camera
    bootEmptyWords();
    float mainAlpha = map(timeDisturbancesIntensity, 0.7,1, 1,64);
    drawEmptyWords(mainAlpha);
  }
  else {
    shutdownEmptyWords();
  }
  
// monitors:  
if(false){
  tint(255,255);
  image(nextFrame, 0,0, width/5,height/5);
  image(baseFrame, 0,height/5, width/5,height/5);
  image(ghostFrame, 0,2*height/5, width/5,height/5);
}

// draw xplier text
// we'll fake it under 0
  double d = durFactor;
  if(d < 1.0) 
    d = d * d * d * d * d;
//println("durFactor: " + durFactor + " d: " + d);

  if(d < 1E-9)
    d = 0.0;

  String s = "x";
  if(d == 0.0)
    s += "0";
  else  
  if(d >= 0.095)
    s += String.format("%.1f", d);
  else
  if(d >= 0.0095)
    s += String.format("%.2f", d);
  else
  if(d >= 0.00095)
    s += String.format("%.3f", d);
  else
  if(d >= 0.000095)
    s += String.format("%.4f", d);
  else
  if(d >= 0.000095)
    s += String.format("%.5f", d);
  else
  if(d >= 0.0000095)
    s += String.format("%.6f", d);
  else
  if(d >= 0.00000095)
    s += String.format("%.7f", d);
  else
  if(d >= 0.000000095)
    s += String.format("%.8f", d);
  else
    s += String.format("%.9f", d);
  
  int xPos = width-25;
  int yPos = cameraFontSize;
  textFont(cameraFont, cameraFontSize);
  textAlign(RIGHT);
  fill(0);
  text( s, xPos+4,yPos+2);
  fill(255);
  text( s, xPos,yPos);
  
  
  if(movieMaking)// Add window's pixels to movie
    movieMaker.addFrame();
  
}


void keyPressed(){

  if(key=='i')
    saveFrame("slomo-######.jpg");   
  else
  if (key == 'v') {

    if(!movieMaking){
      movieMaker = new MovieMaker(this, width, height, "slomo.mov", (int)sketchFPS, 
                                  MovieMaker.JPEG, MovieMaker.HIGH);
      movieMaking = true;
    } 
    else {
      movieMaker.finish();
      movieMaking = false;
     
// Quit running the sketch once the file is written
//      exit();
    } 

  }
  
}


