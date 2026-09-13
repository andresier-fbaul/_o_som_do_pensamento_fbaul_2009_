class Part{

  float px,py, ppx,ppy;
  float energy,energy_dec;
  float rad;

  float vx,vy; //vel
  float f; //friction

  float gravity; //gravidade, força no eixo dos y
  float fx,fy; //força nos eixos
  color col;
  
  int al = (int)random(50,100);

  Part(float x,float y){
    px = ppx = x;
    py = ppy = y;
    energy = 255.f; 
    energy_dec = random(5,10);//random(10.9,20.);
    rad = random(10,50);
    make_rnd_normalized_velocity(50.);
    f = 0.9;
    gravity = 0.9;
    col = color( 232, random(100,152), 40); //reddishes
  }

  Part(float x,float y,color c){
    this(x,y);
    col = c;
  }

 void make_rnd_velocity(float force){
    
     vx = random(-force,force);  
     vy = random(-force,force);  
    
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
    
//    stroke(col, (int)energy);
//    line(ppx,ppy,px,py);
    
    int szx = (int)map(energy,0,255,0,50);
    int szy = (int)(szx / 1.7);

//    image(video,px,py,50,20);

    pushMatrix();
    translate(px,py);
   // rotateX(map(energy,0,255,-0.01,0.01));   
 //   rotateY(map(energy,0,255,-0.01,0.01));   
//    rotateX(map(energy,0,255,-0.1,0.1));   
 //   rotateX(map(energy,0,255,0,TWO_PI*5));  
    rotate(energy*0.1); 
    tint(255,al);
    image(video,-szx,-szy,szx*2,szy*2);
  popMatrix();


  }

}

