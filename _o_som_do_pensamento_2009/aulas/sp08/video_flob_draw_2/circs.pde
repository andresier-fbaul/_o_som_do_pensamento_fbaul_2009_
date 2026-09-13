class Circ{
  float x,y,dim,angulo,speed, raio;
  color c;

  Circ( ){
    angulo = random(TWO_PI);
    speed = random(-0.2,0.2);//0.1;
    dim = random(5,25);
    raio = random(20,250);
  }

  void render(float cx, float cy, float nr){
    float r = raio*nr;
    //update xy
     angulo+=speed;
     x = cx + cos(angulo)*r;
     y = cy + sin(angulo)*r;
     int vx = constrain((int)x,0,video.width-1);
     int vy = constrain((int)y,0,video.height-1);
     
     c = video.pixels[vx + vy*video.width];
     
     fill(c,50);
     ellipse(x,y,dim,dim);

  }

}

