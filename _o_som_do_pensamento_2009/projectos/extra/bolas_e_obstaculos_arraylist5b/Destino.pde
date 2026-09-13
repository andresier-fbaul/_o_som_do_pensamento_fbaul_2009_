class Destino{
  float x,y,r,d;
  float vx, vy; //adicionar velocidade a obstaculos (definir variaveis de movimento)


  Destino(){
    x = random(width);
    y = random(height);
    r = random(20,50);
    d = r*2.f;
  }

  void render(){
   draw(); 
    //parametros para velocidade de deslocacao
   //mutiplicar os valores por 0.x para velocidades menores
   x+= vx; // x+=1 é o mesmo que x = x + 1 (para acumular)
   y+= vy;
   vx*=friccao;
   vx*=friccao;
  }
  
  void draw(){
    fill(100,250,25,250);
    ellipse (x,y,d,d);
  }

}
