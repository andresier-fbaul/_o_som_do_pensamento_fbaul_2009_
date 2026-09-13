
int numlinha=1;
int grelha = (int) sqrt(maxlinhas);

class Linha3d{
  float ox,oy,oz; // origem
  float dx,dy,dz; // destino
  float x,y,z; // posição
  int fftb; // banda fft
  int cor = color (random(25),random(100,255),random(100,255)); // cor
  int al = (int)random(70,200); //alpha

  Linha3d(){

    float theta =  map (numlinha % grelha, 0,grelha, 0, TWO_PI);
    float phi =  map (((float)numlinha / (float)grelha), 0, grelha, 0, TWO_PI);
    float s = 500.;
    // converter theta e phi para uma esfera de raio s +-random(10);
    dx = s*cos(theta)*sin(phi) + random(-10,10);
    dy = s*sin(theta)*sin(phi) + random(-10,10);
    dz = s*cos(phi) + random(-10,10);

    numlinha++;

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
  
  
  void callverts(){
    float tamanho =  0.2 + fft.getBand(fftb) * 0.85;
//    println(tamanho);
    x = tamanho * dx + ox;
    y = tamanho * dy + oy;
    z = tamanho * dz + oz;
    fill(cor,al);
    vertex(x,y,z);    
  }

}


