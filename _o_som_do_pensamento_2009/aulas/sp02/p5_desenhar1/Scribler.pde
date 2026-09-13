
class Scribler{

  float px,py; //pos x e y
  float ppx,ppy; //previous pos x e y
  float dx,dy; //vel x e y
  float energy;// energia

  Scribler(){
   //construtor vazio, tudo iniciado a zeros 
  }

  Scribler ( float posx, float posy, float velx, float vely, float energia){
    px = posx;
    py = posy;
    dx = velx;
    dy = vely;
    energy = energia;
  }

  void draw(){
    if(energy>0.){
      update();
      stroke(0, energy*10); 
      line(ppx,ppy, px,py);
    }
  }

  void update(){

      energy -= 1;//0.5; 

      dx *= 0.9;
      dy *= 0.9;
      
      if ( abs(dx) > abs(dy) )
          dx += dx*0.1;
      else
          dy += dy*0.1 ;


      ppx = px;
      ppy = py;

      px = px + dx;
      py = py + dy;

 

  }


}




