PImage explosoes[];

void init_explosoes(){
  explosoes = new PImage[8];
  for(int i=0; i<8;i++){
    String f = "e16-"+i+".png";
    explosoes[i] = loadImage(f); 
  }
}



void explode(float x,float y, int num) {
  if(explosions.size()<500){
  for(int i=0; i<num;i++){
    Explo e = new Explo(x,y);
    explosions.add(e);
  }
  }
  sendosc();
}


int who=0;
int prev_who=0;
String os[] = {"/a","/b","/c"};

void sendosc(){
  prev_who = who;
  who=(who+1)%3;

    OscMessage myMessage = new OscMessage(os[who]);
    myMessage.add(1);
    oscP5.send(myMessage, myRemoteLocation); 
  
     myMessage = new OscMessage(os[prev_who]);
    myMessage.add(0);
    oscP5.send(myMessage, myRemoteLocation); 
  
}


class Explo{

  float x,y,vx,vy,energy,energy_dec;
  PImage img;

  Explo(float _x, float _y){
    x = _x;
    y = _y;
    vx = random(-2,2);
    vy = random(-2,2);
    energy = 255;
    energy_dec = random(1.5, 5.);
    img = explosoes[(int)random(explosoes.length)];
  } 

  void render(){
    x+=vx;
    y+=vy; 
    vx*=0.96;
    vy*=0.96;
    energy-=energy_dec;
    tint(255,energy);
    image(img,x,y,16,16);
  }

}

