// colisão inter-bolas vector

class Bola{
  PVector pos,vel,acc;
  float rad;
  ArrayList _b;

  Bola(float x, float y, float z, ArrayList balllist ){
    pos = new PVector(x,y,z);
    vel = new PVector(random(-1,1),random(-1,1),random(-10,10)); //new PVector(); 
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
    display();
  }

  void update(){
    vel.add(acc);
    vel.mult(friccao);
    vel.y+=grav;
    pos.add(vel);
    acc.set(0.,0.,0.);
    bounds();
  }
  void bounds(){
    if(pos.x <  world_pos_min.x) {
      vel.x = -vel.x; 
      pos.x =  world_pos_min.x; 
    }
    if(pos.x >  world_pos_max.x) {
      vel.x = -vel.x; 
      pos.x =  world_pos_max.x; 
    }
    if(pos.y <  world_pos_min.y) {
      vel.y = -vel.y; 
      pos.y =  world_pos_min.y; 
    }
    if(pos.y >  world_pos_max.y) {
      vel.y = -vel.y; 
      pos.y =  world_pos_max.y; 
    }
    if(pos.z <  world_pos_max.z) {
      vel.z = -vel.z; 
      pos.z =  world_pos_max.z; 
    }
    if(pos.z >  world_pos_min.z) {
      vel.z = -vel.z; 
      pos.z =  world_pos_min.z; 
    }
  }
  void colide(int n){
    for(int i=n+1; i < _b.size(); i++){
      Bola b = (Bola) _b.get(i);

      float dx = b.pos.x - pos.x;
      float dy = b.pos.y - pos.y;
      float dz = b.pos.z - pos.z; //-
      float distance = sqrt(dx*dx + dy*dy + dz*dz);
      float minDist = b.rad + rad;
      if (distance < minDist) { 
        float phi = atan2(dy, dx);
        float theta = atan2(sqrt(dx*dx+dy*dy),dz);        //                
        float targetX = pos.x + (sin(theta)*cos(phi) * minDist);
        float targetY = pos.y + (sin(theta)*sin(phi) * minDist);
        float targetZ = pos.z + (cos(theta)*minDist);
        float ax = (targetX - b.pos.x) * spring;
        float ay = (targetY - b.pos.y) * spring;
        float az = (targetZ - b.pos.z) * spring;
        acc.x -= ax;
        acc.y -= ay;
        acc.z -= az;        
        b.acc.x += ax;
        b.acc.y += ay;
        b.acc.z += az;
      } 
    }
  }

  void display(){
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    sphere(rad);
    popMatrix();
   }

}



void drawWorldBox(){
  PVector a = world_pos_min;
  PVector b = world_pos_max;

  noFill();
  stroke(255);
  pushMatrix();
  //front
  beginShape();
  vertex(a.x,a.y,a.z);
  vertex(b.x,a.y,a.z);
  vertex(b.x,b.y,a.z);
  vertex(a.x,b.y,a.z);
  endShape(CLOSE);
  //back
  beginShape();
  vertex(a.x,a.y,b.z);
  vertex(b.x,a.y,b.z);
  vertex(b.x,b.y,b.z);
  vertex(a.x,b.y,b.z);
  endShape(CLOSE);
  //left
  beginShape();
  vertex(a.x,a.y,a.z);
  vertex(a.x,a.y,b.z);
  vertex(a.x,b.y,b.z);
  vertex(a.x,b.y,a.z);
  endShape(CLOSE);
  //right
  beginShape();
  vertex(b.x,a.y,a.z);
  vertex(b.x,a.y,b.z);
  vertex(b.x,b.y,b.z);
  vertex(b.x,b.y,a.z);
  endShape(CLOSE);
  
  popMatrix();
  
  
}


