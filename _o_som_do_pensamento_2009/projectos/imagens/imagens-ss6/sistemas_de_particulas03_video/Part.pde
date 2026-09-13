class Part{

  float px,py, ppx,ppy;
  float energy,energy_dec;
  float rad;

  float vx,vy; //vel
  float f; //friction

  float Xgravity, Ygravity; //gravidade, força no eixo dos y
  float fx,fy; //força nos eixos
  color col;

  Part(float x,float y){
    px = ppx = x;
    py = ppy = y;
    energy = 250.f; 
    energy_dec = random(5,10);//random(10.9,20.);
    rad = random(10,50);
    make_rnd_normalized_velocity(100.);
    f = 0.95;
    Xgravity = 0;
    Ygravity = 0;
    col = color( 232, random(100,152), 40); //reddishes
  }

  void make_rnd_normalized_velocity(float force){
    vx = random(-1,1);
    vy = random(-1,1);
    //normalizar, dividir cada componente pelo comprimento do vector
    float len = sqrt(vx*vx+vy*vy);
    if(len>0.f){
     vx = vx / len;
     vy = vy / len; 
     vx *= force;
     vy *= force;
    }
    
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
    // calculate attraction
    float dx= mouseX - px;
    float dy = mouseY - py;
    float normGrav = sqrt(dx*dx+dy*dy);
    Xgravity = dx / normGrav;
    Ygravity = dy / normGrav;
    Xgravity *= 30/normGrav;
    Ygravity *= 30/normGrav;
    
   //update velocity
   vx = vx + Xgravity ;
   vy = vy + Ygravity ;
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
   boolean a = sp.count(px,py,0,10);
   if (a== true)
       setPosForce(sp.cx+ random(-sp.cdev,sp.cdev),sp.cy+ random(-sp.cdev,sp.cdev),sp.fx,sp.fy);
     
  }

  void draw(){
    stroke(col, (int)energy);
    line(ppx,ppy,px,py);
  }

}

