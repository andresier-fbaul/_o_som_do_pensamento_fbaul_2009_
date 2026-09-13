class Bola{
  float x,y,r,d, vx,vy;
  boolean live=true;

  Bola(){
    x = random(width);
    y = random(height);
    r = random(10,20);
    d = r*2.f;
    vx = random(-5,5);
    vy = random(-5,5);
  }
  Bola(float _x, float _y){
   this();
   x=_x; y = _y; 
  }

  void render(int i){
    colide(i);
    update();
    draw(); 
  }

  void colide(int num){
    //colisão apenas com os obstáculos
    for(int i=0; i<obstaculos.size(); i++){
      Obstaculo o = (Obstaculo) obstaculos.get(i);

      float dx = o.x - x;
      float dy = o.y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = o.r + r;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - o.x) * spring;
        float ay = (targetY - o.y) * spring;
        vx -= ax;
        vy -= ay;
  //obstaculo não se move
//        o.vx += ax;
//        o.vy += ay;
      }
    } 

    //colisão com as outras bolas
    for(int i=num+1; i<bolas.size(); i++){
      Bola o = (Bola) bolas.get(i);
      float dx = o.x - x;
      float dy = o.y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = o.r + r;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - o.x) * spring;
        float ay = (targetY - o.y) * spring;
        vx -= ax;
        vy -= ay;
        o.vx += ax;
        o.vy += ay;
      }
    } 
    
    
    //colisão com o destino
      Destino d = dst;
      float dx = d.x - x;
      float dy = d.y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = d.r + r;
      if (distance < minDist) { 
        live=false;
      }


  }

  void update(){
    x+=vx;
    y+=vy;
    vx*=friccao;
    vy*=friccao;
    
    //bounds
    if(x<0)  {
      x=0; 
      vx = -vx;
    }
    if(x>width)  {
      x=width; 
      vx = -vx;
    }
    if(y<0)  {
      y=0; 
      vy = -vy;
    }
    if(y>height)  {
      y=height; 
      vy = -vy;
    }
  }

  void draw(){
    fill(250,200);
    ellipse (x,y,d,d);
  }

}


