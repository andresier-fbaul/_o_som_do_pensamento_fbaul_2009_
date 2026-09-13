
class Scribler{

  float px,py; //pos x e y
  float ppx,ppy; //previous pos x e y
  float dx,dy; //vel x e y
  float energy;// energia

  float angle,magnitude;
  float curv = random(0.01,0.8);
  float side;

  Scribler(){
   //construtor vazio, tudo iniciado a zeros 
  }

  Scribler ( float posx, float posy, float velx, float vely, float energia){
    px = posx;
    py = posy;
    dx = velx;
    dy = vely;
    energy = energia;
    
    angle = atan2(dy,dx);
    magnitude = sqrt(dx*dx+dy*dy);
    side = ( abs(dx) > abs(dy) ) ? 1. : -1.;

  }

  void draw(){
    if(energy>0.){
      update();
      stroke(0,196,191,energy*10 + 20); 
      line(ppx,ppy, px,py);
    }
  }

  void update(){

      energy -= 1;//0.5; 

      //update angle
       angle += side * curv;
      
      // diminuir o raio do angulo
      magnitude *= 0.9;
      
      // novas coordenadas do circulo
     float  cx = cos(angle)*magnitude;
     float  cy = sin(angle)*magnitude;


      ppx = px;
      ppy = py;

      px = px + cx;
      py = py + cy;

 

  }


}




