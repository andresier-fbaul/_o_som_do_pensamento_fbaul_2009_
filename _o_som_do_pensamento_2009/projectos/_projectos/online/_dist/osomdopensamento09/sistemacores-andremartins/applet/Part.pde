class Part{

  float px,py, ppx,ppy;
  float energy,energy_dec;
  float rad;

  float vx,vy; //vel
  float f; //friction

  float gravity; //gravidade, força no eixo dos y
  float fx,fy; //força nos eixos
  color col;

  Part(float x,float y){
    px = ppx = x;
    py = ppy = y;
    energy = 755.f; 
    energy_dec = random(10,30);//random(10.9,20.);
    rad = random(10,50);
    make_rnd_velocity(50.);
    f = 0.8;//0.9;
    gravity = 0.9;
    col = color( random(0,255), random(0,255), random(0,255)); //reddishes
  }


  void make_rnd_velocity(float force){
    
     vx = random(-force,force);  
     vy = random(-force,force);  
    
  }

  
  void setPos(float x, float y){
   px = ppx = x;
   py = ppy = y; 
  }

  void setPosForce(float x, float y, float fx, float fy){
   px = ppx = x;
   py = ppy = y; 
   this.fx = fx;
   this.fy = fy;
  }
  
  void update(){
    //store pos
    ppx = px;
    ppy = py;
   //update velocity
   vy = vy + gravity ;
   vx = vx + fx;
   vy = vy + fy;
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
    strokeWeight(px);
    line(ppx,ppy,px,py);
  }

}

