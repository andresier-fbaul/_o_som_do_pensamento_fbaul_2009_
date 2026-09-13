
class Tiro{

  float x,y,vx,vy,energy=100;

  Tiro(float px, float py, float angle){
    float s = 10;
    vx = cos(angle)*s;
    vy = sin(angle)*s;
    x = px;
    y = py;
  } 

  void render(){
    colide();
    update();
    draw(); 
  }
  
  void colide(){
    //colisão apenas com os obstáculos
    for(int i=0; i<obstaculos.size(); i++){
      Obstaculo o = (Obstaculo) obstaculos.get(i);

      float dx = o.x - x;
      float dy = o.y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = o.r + 1;
      if (distance < minDist) { 
        energy=-1;
        //        float angle = atan2(dy, dx);
//        float targetX = x + cos(angle) * minDist;
//        float targetY = y + sin(angle) * minDist;
//        float ax = (targetX - o.x) * spring;
//        float ay = (targetY - o.y) * spring;
//        vx -= ax;
//        vy -= ay;
  //obstaculo não se move
//        o.vx += ax;
//        o.vy += ay;
      }
    } 

    //colisão com as outras bolas
    for(int i=0; i<bolas.size(); i++){
      Bola o = (Bola) bolas.get(i);
      float dx = o.x - x;
      float dy = o.y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = o.r + 1;
      if (distance < minDist) { 
        o.live=false;
        energy = -1;
        //        float angle = atan2(dy, dx);
//        float targetX = x + cos(angle) * minDist;
//        float targetY = y + sin(angle) * minDist;
//        float ax = (targetX - o.x) * spring;
//        float ay = (targetY - o.y) * spring;
//        vx -= ax;
//        vy -= ay;
//        o.vx += ax;
//        o.vy += ay;
      }
    } 
    
   
    
  }
  void update(){
   x+=vx;
   y+=vy;
   energy-=5; 
  }
  void draw(){
   line(x,y,x-vx,y-vy);
    
  }
  
  
}

