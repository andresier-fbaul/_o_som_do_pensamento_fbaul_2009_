// colisão inter-bolas vector

class Bola{
  PVector pos,vel,acc;
  float rad;
  ArrayList _b;
  boolean isColiding=false;
  
  Bola(float x, float y, ArrayList balllist ){
    pos = new PVector(x,y,0);
    vel = new PVector(random(-1,1),random(-1,1)); //new PVector(); 
    acc = new PVector();
    rad = random(20,80); 
    _b=balllist;
  }
  void apply_force(PVector a){
   acc.add(a); 
  }
  void render(int i){
    colide(i);
    update();
    if(isColiding)
    fill(25,250);
    else
    fill(255,150);
    
    ellipse(pos.x,pos.y,rad*2,rad*2);
    //draw velocity
    float m=5.;
    line(pos.x,pos.y, pos.x+vel.x*m, pos.y+vel.y*m);
  }
  
  void update(){
    vel.add(acc);
    vel.mult(friccao);
    pos.add(vel);
    acc.set(0.,0.,0.);
    bounds();
  }
  void bounds(){
    if(pos.x <  world_dim_min.x) {vel.x = -vel.x; pos.x =  world_dim_min.x; }
    if(pos.x >  world_dim_max.x) {vel.x = -vel.x; pos.x =  world_dim_max.x; }
    if(pos.y <  world_dim_min.y) {vel.y = -vel.y; pos.y =  world_dim_min.y; }
    if(pos.y >  world_dim_max.y) {vel.y = -vel.y; pos.y =  world_dim_max.y; }
  }
  void colide(int n){
    isColiding = false;
    
    for(int i=n+1; i < _b.size(); i++){
      Bola b = (Bola) _b.get(i);
      
      float dx = b.pos.x - pos.x;
      float dy = b.pos.y - pos.y;
      float distance = (dx*dx + dy*dy);//sqrt(dx*dx + dy*dy);
      float minDist =(b.rad + rad)*( b.rad + rad);
      if (distance < minDist) { 
        isColiding = true;
        minDist = sqrt(minDist);
        float angle = atan2(dy, dx);
        float targetX = pos.x + cos(angle) * minDist;
        float targetY = pos.y + sin(angle) * minDist;
        float ax = (targetX - b.pos.x) * spring;
        float ay = (targetY - b.pos.y) * spring;
        acc.x -= ax;
        acc.y -= ay;
        b.acc.x += ax;
        b.acc.y += ay;
      } 
    }
  }
}



