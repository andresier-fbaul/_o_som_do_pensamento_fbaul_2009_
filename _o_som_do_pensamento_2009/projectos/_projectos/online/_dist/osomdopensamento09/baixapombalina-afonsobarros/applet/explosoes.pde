PImage explosoes[];

void init_explosoes(){
  explosoes = new PImage[8];
  for(int i=0; i<8;i++){
    String f = "e16-"+i+".png";
    explosoes[i] = loadImage(f); 
  }
}


void explode(float x,float y, int num, boolean blood) {
  if(explosions.size()<500){
  for(int i=0; i<num;i++){
    Explo e = new Explo(x,y, blood);
    explosions.add(e);
  }
  }
}


class Explo{

  float x,y,vx,vy,energy,energy_dec;
  PImage img;
  boolean blood;

  Explo(float _x, float _y,boolean blood){
    x = _x;
    y = _y;
    vx = random(-2,2);
    vy = random(-2,2);
    energy = 255;
    energy_dec = random(1.5, 5.);
    img = explosoes[(int)random(explosoes.length)];
    this.blood = blood;
  } 

  void render(){
    x+=vx;
    y+=vy; 
    vx*=0.96;
    vy*=0.96;
    energy-=energy_dec;
    if (this.blood)
      tint (255,0,0,energy);
    else
      tint(255,energy);
    image(img,x,y,16,16);
  }

}

