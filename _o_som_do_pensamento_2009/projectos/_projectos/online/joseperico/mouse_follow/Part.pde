class Part{

  float px,py, ppx,ppy;
  float energy,energy_dec;
  float rad;

  float vx,vy; //vel
  float f; //friction

  float gravity; //gravidade, força no eixo dos y
  color col;

  Part(float x,float y){
    px = ppx = x;
    py = ppy = y;
    energy = 255.f; 
    energy_dec = random(5,7);//random(10.9,20.);
    rad = random(10,40);
    make_rnd_normalized_velocity(50.);
    f = 0.9;
    gravity = 0.7;
    col = color( random(41,200),200, random(20,100)); //reddishes
  }

  void make_rnd_normalized_velocity(float force){
    vx = random(-1,1);
    vy = random(-1,1);
    //normalizar, dividir cada componente pelo comprimento do vector
    float len = sqrt(vx*vx+vy*vy);
    if(len>0.f){
     vx = vx / len;
     vy = vy / len; 
     vx *= force/0.7;
     vy *= force/0.7;
    }
    
  }
  
  void setPos(float x, float y){
   px = ppx = x;
   py = ppy = y; 
  }
  
  void update(){
    //store pos
    ppx = px;
    ppy = py;
   //update velocity
   vy = vy + gravity ;
  
  float dx = mouseX - px;
  float dy = mouseY - py;
  float len = sqrt(dx*dx+dy*dy);
  dx = dx/len;
  dy = dy/len;
  
  dx*=7.2;
  dy*=7.2;
  
  vx = vx+dx;
  vy = vy+dy;
  
   //friction = vel * friction
   vx = vx * f;
   vy = vy * f;
   // position = pos + vel
   px = px + vx;
   py = py + vy;
   // energy
   energy = energy - energy_dec;
   
  }

  void draw(){
    stroke(col, (int)energy);
    line(ppx,ppy,px,py);
  }

}

