import processing.opengl.*;


// import a library
import ddf.minim.*;

// um objecto da biblioteca
Minim minim;
// o objecto do input sonoro
AudioInput in;

float rad=20;
float triDistance=rad * 1.4;
float initialSpeed = 2;
float speedAccelFactor = 1.05;

float angleAccel = 0.06;
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
  void set(float apx, float apy, float aangle){
    px=apx;
    py=apy;
    angle=aangle;
  }  
} 

snakePos posFifo[];


void setup(){

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

  rectWall = new RectWall(width*0.3, height*0.485, width*0.7, height*0.515); 
  pill = new Goodie();
  
  setSnakeSpeed(initialSpeed);

  for(int i=0; i<initialSnakeSize; i++){
    appendSnakeTri(width/2, height/4, -HALF_PI, rad);
  }
  
}

void appendSnakeTri(float px, float py, float angle, float rad){
  
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

void shortenSnakeTri(){
  tri=(snakeTri[])shorten(tri);
  for(int i=0; i<fifoSlotSize; i++){
    posFifo = (snakePos[])shorten(posFifo);
  }
  snakeSize--;
}

  
void setSnakeSpeed(float newSpeed){
  speed = newSpeed;
  fifoSlotSize = (int) (triDistance / speed);
  fifoSlotSize = max(fifoSlotSize, 2);
//println("speed: " + speed + " fifoSlotSize: " + fifoSlotSize);
}

void doBadCollision(){

  if(snakeSize >= minSnakeSize+1){

    for(int i=0; i<1; i++){ // pillGrowSnakeBy
      shortenSnakeTri();
    }
    
 // set all immortal for 1s to avoid multiple kills
    for(int i=0; i<snakeSize; i++){
      tri[i].setImmortalFor( (int)(1.5 * fps) );
    }
   
    flashNextFrame=fps/2;
    flashGood=false;

    score--;
    score=max(0,score);
  }
}


void draw(){
  
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
  float f = 0.5;
  audioEnergy = audioEnergy * (1.-f) + rms * f;

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
  if( tri[0].inCollisionWithCircle(pill.px,pill.py, pill.rad*1.2) ){ // so that it appears to move over to eat the pill
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
    if(rectWall.inCollisionWithCircle(tri[i].px, tri[i].py, tri[i].rad*.6) && 
       !tri[i].isImmortal()){
  //      println("rectWall collision " + i + random(0,1));    
      doBadCollision();
      break;
    }
  }
 
  float sp = initialSpeed * pow(speedAccelFactor,score);
  sp=min(sp,4.7);
  setSnakeSpeed(sp); // go faster snake, go!
 
  text("snake score: " + score,6,18);
  text("microphone or space to control snake", width-265, 18);

}


void keyPressed(){
  if(key=='s')
    saveFrame("snakePills-######.jpg"); 
  if(key=='p')
    rect(1,height-30,75,30); //clear score
  // pill.reset();
}


void stop(){
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();

  super.stop();
}


