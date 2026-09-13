/// agora a class sndTri segue a lógica do jogo, se o som
/// for inferior, altera a dir e não anda, senão anda e não altera a direcção



class snakeTri{

  // o centro do triângulo
  float px, py;  
  float angle; 
    
  // o tamanho do triangulo
  float rad;
  
  float audioEnergyThreshLeft = 0.06;
  float audioEnergyThreshRight = 0.6;

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


  void updateAngleFromAudioEnergy(float energy, float speed, float angleAccel){
    
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


  void updateAngleFromNext(float nx, float ny, float nAngle){
    px = nx;
    py = ny;
    angle = nAngle;
  }


  boolean isImmortal(){ // immortal during this period
    return (frameCount - immortalFrameBegin <= immortalFrameCount);
  }
  
  boolean inCollisionWithCircle(float cx, float cy, float minDist){
    if(isImmortal())
      return false;
    
    float distance = sqrt( sq(cx-px) + sq(cy-py) );
    return (distance < minDist);
  }


  void setImmortalFor(int aFrameCount){
    immortalFrameCount = aFrameCount;
    immortalFrameBegin = frameCount;
  }

  void draw(){

    if((id & 1) == 1)
      fill(100);
    else
      fill(170);
    stroke(30, 160);

    pushMatrix();
      
    translate(px,py);
    rotate(angle);
    
    float balanceDelta = 0.3; // a cheap way to have the center of mass of the triangle at 0,0
    beginShape();
    vertex(rad + balanceDelta, 0);
    vertex(-rad + balanceDelta, rad);
    vertex(-rad + balanceDelta, -rad);
    endShape(CLOSE);    

    popMatrix();
  }



}










