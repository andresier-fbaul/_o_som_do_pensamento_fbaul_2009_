class Bola {
  float x,y,r,g, vx, vy;

  Bola(){
    x= random(width);
    y= random(height);
    r= random(10,15);
    g= random (15);
      vx = random(15);
    vy = random(15);
  }

  Bola(float _x, float _y){
    this();
    x= _x; 
    y= _y;
  }

  void render(int i){
    colide(i);
    update();
    draw();
  }

  void colide(int num){
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

  }

  void update(){
    x+=vx;
    y+=vy;
    vx*=friccao;
    vy*=friccao;


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


