class Destino{
  float x,y,r,d;

  Destino(){
    x = random(width);
    y = random(height);
    r = random(2,10);
    d = r*2.f;
  }

  void render(){
   draw(); 
  }
  
  void draw(){
    fill(100,250,25,250);
    ellipse (x,y,d,d);
  }

}
