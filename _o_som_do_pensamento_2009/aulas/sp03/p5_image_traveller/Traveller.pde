
class imgTraveller{

  float energy,energy_dec;

  float px,py;
  float ppx,ppy;

  float force; //vel na dir do angulo
  float angulo;
  float angulo_inc;
  color cor;

  //constructor
  imgTraveller(float posx, float posy){
    px = ppx = posx;
    py = ppy = posy;
    angulo = random(TWO_PI);
    angulo_inc = random(-HALF_PI,HALF_PI);
    force = random(1,5.);//random(0.1,2.);
    energy = random(100,270);
    energy_dec = random(0.1,2.);
  }


  void draw(){
    if(energy>0.){
      update();
      stroke(cor,energy);
      line(ppx,ppy,px,py);
    } 
  }


  void update(){
    // 1. diminuir a energia
    energy = energy - energy_dec;

    // 2. nova pos
    // 2.1 se preto manter dir, se branco alterar dir
    ppx = px;
    ppy = py;
    
    cor = img.get((int)px,(int)py); //saber o pixel da posição
    
    float g = green(cor); // +eficiente myColor >> 8 & 0xFF;
//    println(g);
    
    if((int)g>0){
     // float f = map(g,0,255,0.1,2.);
      angulo += angulo_inc;//*f;
      px += cos(angulo)*force; 
      py += sin(angulo)*force; 
 //     cor = 255;
    } else {
      px += cos(angulo)*force;
      py += sin(angulo)*force; 
//      cor = 0;
    }
    
    //wrap das coordenadas
    if(px>width){
      px-=width;
      ppx = px;
    }
    if(px<0){
      px+=width;
      ppx = px;
    }
    if(py>height){
      py-=height;
      ppy = py;
    }
    if(py<0){
      py+=height;
      ppy = py;
    }
 

  }


}



