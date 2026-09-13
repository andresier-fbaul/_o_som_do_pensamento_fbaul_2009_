

/// a class que vocês podem extender

class Particula {

  float x,y,z; //posição (quem quiser não usa o z, quem quiser usa)
  float velx, vely, velz;
  float accx, accy, accz;


  float rad;
  float life; // 0 a 255

  // sempre que se cria uma particula, precisa de uma posição
  Particula(float _x, float _y){
    this(_x,_y,0.0f);   
  }  
  Particula(float _x, float _y, float _z){
    x = _x; 
    y = _y; 
    z = _z;
    velx=vely=velz=0.0f;
    accx=accy=accz=0.0f;
    rad = 70;
    life = 255;
  }


  boolean estaNaMinhaArea(){
    // ver se esta partícula está na minha área para poder alterá-la, desenhá-la...

    int clientx = client.getXoffset();
    int clienty = client.getYoffset();
    int clientdimx = client.getLWidth();
    int clientdimy = client.getLHeight();

    boolean result = false;

    if (  x >= clientx && x < (clientx+clientdimx) &&
          y >= clienty && y < (clienty+clientdimy)  )
      result = true;

    return result;    
  }


  // método para fazerem overload , este não faz nada
  void update(){

  }


  // método exemplo draw da particula, que podem alterar completamente

    void draw(){   
    pushMatrix();
    translate(x,y,z);
    ellipse(0,0,rad,rad);
    popMatrix();          
  }

}


/// um exemplo de uma class extendida como vocês podem saber
/// lembrem-se que tudo o que faz part da Particula existe já nesta class

class MYPART2D extends Particula {

  int cor; // vou adicionar cor
  float dev; // e uns parâmetros para movimento

  MYPART2D( float _x, float _y) {
    super(_x,_y); //chamar o construtor de Particula
    cor = color (random(50), random(70,150), random(150,255) );
    dev = random(0.00010,0.00100);
 
    // vou alterar as vels' iniciais a 0
    float a = 2;//10;
    velx = random(-a,a); 
    vely = random(-a,a); 
    velz = random(-a,a);
  }

  //temos de fazer tudo aqui
  void update(){
      
    life -= 0.01;
    
      velx += accx; 
      vely += accy; 
      velz += accz;
      accx = accy = accz = 0.0f;
//      float fade = 0.912;      
//      accx *= fade; accy *= fade; accz *=fade;
      
      dev += random(-0.01,0.01);
      float maxdev = 0.25;
      if(dev > maxdev)
        dev = maxdev;
      if(dev < -maxdev)
        dev = -maxdev;
      accx += random(-dev,dev);
      accy += random(-dev,dev);
      accz += random(-dev,dev);

      x +=velx; 
      y+=vely; 
      z+= velz;

      // bound é com as dims do cliente
      // se sair das bounds, notificar os outros

      //faz-se aqui o y que bounça em cima e em baixo
      if(y<client.getYoffset()){
         y = client.getYoffset(); 
         vely = -vely;
      }
      if(y>client.getYoffset()+client.getLHeight()){
         y = client.getYoffset()+client.getLHeight(); 
         vely = -vely;
      }
      
      
      // o x faz-se com as dimensões master e faz um wrap
      
      if( x < 0 ){
        x += client.getMWidth();
        velx *= 0.7;
      }
       if( x > client.getMWidth() ){                  
        x -= client.getMWidth();
        velx *= 0.7;
       }
     

  }
//    else {
//      //tentar enviá-la por rede para o vizinho 
//
//    }
//
//  }
//

  void draw(){
 
     fill(cor,life);//200);
    pushMatrix();
    translate(x,y,0);//z);
    ellipse(0,0,rad,rad);
    popMatrix();          
     
    
    
  }


}







