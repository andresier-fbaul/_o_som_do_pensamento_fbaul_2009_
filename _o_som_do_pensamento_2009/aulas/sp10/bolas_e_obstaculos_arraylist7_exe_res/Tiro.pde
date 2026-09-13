
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
        explode(x,y,(int)random(2,5)); 
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
        explode(x,y,(int)random(5,10)); 
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

