
class Part{
  float xoff = 0.0;
  float px,py, ppx,ppy;
  float energy,energy_dec;
  float rad;

  float vx,vy; //vel
  float f; //friction

  float gravity; //gravidade, força no eixo dos y
  float fx,fy; //força nos eixos
  color col;

  String txt = ""; // o texto a escrever


  Part(float x,float y){
    px = ppx = x;
    py = ppy = y;
    energy = 255.f; 
    energy_dec = random(5,25);//random(10.9,20.);
    rad = random(10,50);
    make_rnd_normalized_velocity(50.);
    f = 0.9;
    gravity = 0.29;
    col = color(  0); //reddishes
  }

  Part(float x,float y, String s){
    this(x,y);
    txt = s;
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
    //friction = vel * friction;
    vx = vx * f;
    vy = vy * f;
    // position = pos + vel
    px = px + vx;
    py = py + vy;
    
    if(px < 0 || px > width)
      vx = -vx;
    
    if(py < 0 || py > height)
      vy = -vy;
    
    
    // energy
    energy = energy - energy_dec;
  }

  void draw(){
   xoff = xoff + .9;
   float n = noise(xoff) * width;
    //image(video,px,py,50,20); imagem do video num ecran de 50x20
    fill(col,255);
    text(txt,px,py);
  }

}


