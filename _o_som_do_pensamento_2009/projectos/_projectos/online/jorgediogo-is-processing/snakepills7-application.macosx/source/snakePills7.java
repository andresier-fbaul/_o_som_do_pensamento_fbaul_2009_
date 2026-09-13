import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 
import ddf.minim.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class snakePills7 extends PApplet {




// import a library


// um objecto da biblioteca
Minim minim;
// o objecto do input sonoro
AudioInput in;

float rad=20;
float triDistance=rad * 1.4f;
float initialSpeed = 2;
float speedAccelFactor = 1.05f;

float angleAccel = 0.06f;
int initialSnakeSize = 7;
int minSnakeSize = 3;
int pillGrowSnakeBy = 2;

int fps = 30;

float speed;
int fifoSlotSize;
int snakeSize = 0;
float audioEnergy=0;
int flashNextFrame = 0;
boolean flashGood;

/// game logic
Goodie pill;
RectWall rectWall;
snakeTri tri[];

int score = 0;
PFont font;

class snakePos {
  float px, py;  
  float angle;
  snakePos(float apx, float apy, float aangle){
    px=apx;
    py=apy;
    angle=aangle;
  }  
  public void set(float apx, float apy, float aangle){
    px=apx;
    py=apy;
    angle=aangle;
  }  
} 

snakePos posFifo[];


public void setup(){

  size(700,700); // ,OPENGL
  smooth();
  frameRate(fps);

  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 512);

  // nova fonte
  font = createFont(PFont.list()[1],16);
  textFont(font,16);

  rectWall = new RectWall(width*0.3f, height*0.485f, width*0.7f, height*0.515f); 
  pill = new Goodie();
  
  setSnakeSpeed(initialSpeed);

  for(int i=0; i<initialSnakeSize; i++){
    appendSnakeTri(width/2, height/4, -HALF_PI, rad);
  }
  
}

public void appendSnakeTri(float px, float py, float angle, float rad){
  
  snakeTri newTri = new snakeTri(snakeSize, px, py, angle, rad);
                                      
  if(snakeSize == 0){
    tri = new snakeTri[1];
    tri[0] = newTri;
    
    posFifo = new snakePos[fifoSlotSize];    
    for(int i=0; i<fifoSlotSize; i++){
      posFifo[i] = new snakePos(px, py, angle);;
    }
  }
  else {
    tri = (snakeTri[])append(tri, newTri);
    
    for(int i=0; i<fifoSlotSize; i++){
      snakePos newSnakePos = new snakePos(px, py, angle);
      posFifo = (snakePos[])append(posFifo, newSnakePos);
    }    
  }
 
  snakeSize++;
}

public void shortenSnakeTri(){
  tri=(snakeTri[])shorten(tri);
  for(int i=0; i<fifoSlotSize; i++){
    posFifo = (snakePos[])shorten(posFifo);
  }
  snakeSize--;
}

  
public void setSnakeSpeed(float newSpeed){
  speed = newSpeed;
  fifoSlotSize = (int) (triDistance / speed);
  fifoSlotSize = max(fifoSlotSize, 2);
//println("speed: " + speed + " fifoSlotSize: " + fifoSlotSize);
}

public void doBadCollision(){

  if(snakeSize >= minSnakeSize+1){

    for(int i=0; i<1; i++){ // pillGrowSnakeBy
      shortenSnakeTri();
    }
    
 // set all immortal for 1s to avoid multiple kills
    for(int i=0; i<snakeSize; i++){
      tri[i].setImmortalFor( (int)(1.5f * fps) );
    }
   
    flashNextFrame=fps/2;
    flashGood=false;

    score--;
    score=max(0,score);
  }
}


public void draw(){
  
  int backAlpha = (int)map((float)score, 0,20, 40,2); // 64
  
  if(flashNextFrame > 0){
    if(flashGood)
      fill(flashNextFrame*20,flashNextFrame*20,flashNextFrame*10, backAlpha);
    else
      fill(flashNextFrame*10,0,0, backAlpha);
    flashNextFrame--;
  }
  else
    fill(0, backAlpha);
    
  noStroke();
  rect(0,0,width,height);

  float rms = in.mix.level();
  float f = 0.5f;
  audioEnergy = audioEnergy * (1.f-f) + rms * f;

  for(int i=0; i<snakeSize; i++){
    if(i == 0){
      if(keyPressed){ // fake audio energy from pressed key
        if(key == ' ')
          audioEnergy=tri[i].audioEnergyThreshRight;
        else
          audioEnergy=tri[i].audioEnergyThreshLeft;        
        tri[i].updateAngleFromAudioEnergy(audioEnergy, speed, angleAccel);             
      }
      else
        tri[i].updateAngleFromAudioEnergy(audioEnergy, speed, angleAccel);
      
// move array contents one forward:
      for(int j=posFifo.length-1; j>=1; j--)
        posFifo[j].set(posFifo[j-1].px, posFifo[j-1].py, posFifo[j-1].angle);
      posFifo[0].set(tri[i].px, tri[i].py, tri[i].angle);
      
    }
    else {
//if(i*fifoSlotSize >= posFifo.length){
//println( "i*fifoSlotSize: " + i*fifoSlotSize + " posFifo.length:" + posFifo.length);   
//}
      // nasty bug here: snakePos pos = posFifo[i*fifoSlotSize];
      snakePos pos = posFifo[min(i*fifoSlotSize,posFifo.length-1)];
      tri[i].updateAngleFromNext(pos.px, pos.py, pos.angle);
    }      
  }

// draw all:
  rectWall.draw();
  
  pill.draw();

  for(int i=snakeSize-1; i>=0; i--){
    tri[i].draw();
  }
  
// see collisions: pill 
  if( tri[0].inCollisionWithCircle(pill.px,pill.py, pill.rad*1.2f) ){ // so that it appears to move over to eat the pill
    println("pill eaten");  
    score++;
    
    float pillSpeed=0;
    if(score >= 3){
      pillSpeed = random(score/10, score/5);
    }
    pill.resetAnSetRandomSpeed(pillSpeed);
    
//  increase tail
    snakeTri lastTri = tri[snakeSize-1];

    for(int i=0; i<pillGrowSnakeBy; i++){
      appendSnakeTri( lastTri.px, lastTri.py, lastTri.angle, lastTri.rad);    
//println(lastTri.px);
    }
    
    flashNextFrame=fps/4;
    flashGood=true;
    
  }


// check for collision between head and tails
  for(int i=minSnakeSize; i<snakeSize; i++){
    if( tri[0].inCollisionWithCircle(tri[i].px, tri[i].py, tri[i].rad) ){
//      println("tail collision " + i + random(0,1));
      doBadCollision();
      break;      
    }
  }


// check collision with rect wall:
  for(int i=0; i<1; i++){
    if(rectWall.inCollisionWithCircle(tri[i].px, tri[i].py, tri[i].rad*.6f) && 
       !tri[i].isImmortal()){
  //      println("rectWall collision " + i + random(0,1));    
      doBadCollision();
      break;
    }
  }
 
  float sp = initialSpeed * pow(speedAccelFactor,score);
  sp=min(sp,4.7f);
  setSnakeSpeed(sp); // go faster snake, go!
 
  text("snake score: " + score,6,18);
  text("microphone or space to control snake", width-265, 18);

}


public void keyPressed(){
  if(key=='s')
    saveFrame("snakePills-######.jpg"); 
  if(key=='p')
    rect(1,height-30,75,30); //clear score
  // pill.reset();
}


public void stop(){
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();

  super.stop();
}






class Goodie{

  float px,py;
  float rad,radinc;
  float minRad=15;
  float maxRad=25;
  boolean active;
  float xSpeed;
  float ySpeed;

  Goodie(){
    reset();
  } 

  public void reset(){
    px = random(maxRad,width-maxRad);
    
// avoid the screen vertical center    
    if(random(0,1) > 0.5f)
      py = random(maxRad,height/2-maxRad);
    else
      py = random(height/2+maxRad,height-maxRad);

    rad = minRad;
    radinc = 1.2f;
    active = true;
    xSpeed=ySpeed=0;
  }

  public void resetAnSetRandomSpeed(float speedFactor){
    reset();
    if(random(0,1) < 0.5f)
      xSpeed=speedFactor;
    else  
      ySpeed=speedFactor;
  }

  public void draw(){
    if(active){
      noStroke();
      fill(0xffE2E53A);      
      ellipse(px,py, rad,rad);
      
      //updated radius
      rad+=radinc;
      if(rad<minRad||rad>maxRad)
        radinc=-radinc;

      px+=xSpeed;
      py+=ySpeed;
      
// wrap coords  
      px = (px+width) % width;  
      py = (py+height) % height;      
    }
  }


}








class RectWall{

  float left,top,right,bottom;

  RectWall(float aleft, float atop, float aright, float abottom){
    left=aleft;
    top=atop;
    right=aright;
    bottom=abottom;
  } 

  public void draw(){
    stroke(0xff808080);
    fill(0xff817452);      
    rect(left,top, right-left, bottom-top);
  }


  public boolean inCollisionWithCircle(float cx, float cy, float rad){
    if((cx >= left-rad) && (cx < right+rad) &&
       (cy >= top-rad) && (cy < bottom+rad))
      return true;
    else
      return false;
  }
}




/// agora a class sndTri segue a l\u00f3gica do jogo, se o som
/// for inferior, altera a dir e n\u00e3o anda, sen\u00e3o anda e n\u00e3o altera a direc\u00e7\u00e3o



class snakeTri{

  // o centro do tri\u00e2ngulo
  float px, py;  
  float angle; 
    
  // o tamanho do triangulo
  float rad;
  
  float audioEnergyThreshLeft = 0.1f; // 0.06
  float audioEnergyThreshRight = 0.6f;

  int id; // id 0 is head
  
  int immortalFrameBegin;
  int immortalFrameCount;

  snakeTri(int aid, float apx, float apy, float aangle, float arad){
    id=aid;
    px=apx;
    py=apy;
    angle=aangle;
    rad = arad;
    setImmortalFor(2 * fps);
  }


  public void updateAngleFromAudioEnergy(float energy, float speed, float angleAccel){
    
    if(energy <= audioEnergyThreshLeft)
      angle -= angleAccel;
    else
    if(energy >= audioEnergyThreshRight)
      angle += angleAccel;
      
// only the head updates pos from angle and speed, other follow the next one      
    px = px + cos(angle) * speed;
    py = py + sin(angle) * speed;  
    
// wrap coords  
    px = (px+width) % width;  
    py = (py+height) % height;
  }


  public void updateAngleFromNext(float nx, float ny, float nAngle){
    px = nx;
    py = ny;
    angle = nAngle;
  }


  public boolean isImmortal(){ // immortal during this period
    return (frameCount - immortalFrameBegin <= immortalFrameCount);
  }
  
  public boolean inCollisionWithCircle(float cx, float cy, float minDist){
    if(isImmortal())
      return false;
    
    float distance = sqrt( sq(cx-px) + sq(cy-py) );
    return (distance < minDist);
  }


  public void setImmortalFor(int aFrameCount){
    immortalFrameCount = aFrameCount;
    immortalFrameBegin = frameCount;
  }

  public void draw(){

    if((id & 1) == 1)
      fill(100);
    else
      fill(170);
    stroke(30, 160);

    pushMatrix();
      
    translate(px,py);
    rotate(angle);
    
    float balanceDelta = 0.3f; // a cheap way to have the center of mass of the triangle at 0,0
    beginShape();
    vertex(rad + balanceDelta, 0);
    vertex(-rad + balanceDelta, rad);
    vertex(-rad + balanceDelta, -rad);
    endShape(CLOSE);    

    popMatrix();
  }



}











  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#000000", "--hide-stop", "snakePills7" });
  }
}
