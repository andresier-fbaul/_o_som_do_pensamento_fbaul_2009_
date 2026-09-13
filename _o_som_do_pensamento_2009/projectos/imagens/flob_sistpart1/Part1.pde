
class Part1{

  float px,py, ppx,ppy;
  float energy,energy_dec;
  float rad;

  float vx,vy; //vel
  float f; //friction

  float gravity; //gravidade, força no eixo dos y
  float fx,fy; //força nos eixos
  color col;

  String txt = ""; // o texto a escrever


  Part1(float x,float y){
    px = ppx = x;
    py = ppy = y;
    energy = 255.f; 
    energy_dec = 100;
    rad = random(10,50);
    make_rnd_normalized_velocity(50.);
    f = 0.9;
    gravity = 3;
    col = color(255); 
  }

  Part1(float x,float y, String s){
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
    // energy
    energy = energy - energy_dec;
  }

  void draw(){
    //stroke(col, (int)energy);
    fill(col,random (0,0));
    //    line(ppx,ppy,px,py);
    text(txt,px,py);
  }

}


