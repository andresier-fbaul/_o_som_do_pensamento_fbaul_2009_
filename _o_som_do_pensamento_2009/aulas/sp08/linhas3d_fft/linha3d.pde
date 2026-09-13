class Linha3d{
  float ox,oy,oz; // origem
  float dx,dy,dz; // destino
  float x,y,z; // posição
  int fftb; // banda fft
  int cor = color (random(25),random(100,255),random(100,255)); // cor
  int al = (int)random(70,200); //alpha

  Linha3d(){

    //   ox = oy = oz = 0.0f;
    //   ox = width/2;
    //    oy = height/2;
    //    oz = -500.0f;

    ox = 5;
    oy = 5;
    oz = 5;

    dx = random(-100,100);
    dy = random(-100,100);
    dz = random(-100,100);

    // low, mid, high
    int who = (int) random(3);
    switch(who) {
    case 0:      
      fftb = (int) random(fft.specSize()*0.1); 
      cor = color (random(100,255),random(100),random(100)); // cor
     break; 
    case 1:      
      fftb = (int) random(fft.specSize()*0.1,fft.specSize()*0.25 );
      cor = color (random(50),random(100,255),random(50)); // cor
      break; 
    case 2:      
      fftb = (int) random(fft.specSize()*0.25, fft.specSize()*0.7 );
      cor = color (random(25),random(55),random(100,255)); // cor
      break; 
    }

    //    fftb = (int) random(fft.specSize()); 

  } 

  void render(){

    float tamanho =  0.5 + fft.getBand(fftb) * 0.25;

    x = tamanho * dx + ox;
    y = tamanho * dy + oy;
    z = tamanho * dz + oz;

    stroke(cor,al);
    line(ox,oy,oz,x,y,z);

  }

}


