
/// um exemplo de uma class extendida como vocês podem saber
/// lembrem-se que tudo o que faz part da Particula existe já nesta class

class MYPART2D extends Particula {

  int cor; // vou adicionar cor
  float dev; // e uns parâmetros para movimento

  int om = (int) random(2);

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

    //não se esqueçam de 
//    super.update();
//    ou
      
//    checkSendNet(); // aqui no fim
    
    life -= 1.21;

    // este update é brwonian motion

    velx += accx; 
    vely += accy; 
    velz += accz;
    accx = accy = accz = 0.0f;

    dev += random(-2.01,1.01);
    float maxdev = 1.25;
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

    // bounds apenas y...

    if(y<0){
        y = 0; 
        vely = -vely*0.971;
     }
    if(y>height){
        y = height; 
        vely = -vely*0.971;
     }
     
     // , para x basta
    
    checkSendNet();
    
    
    

  }
  
  
  void draw(){

    fill(cor,life);//200);
    pushMatrix();
    translate(x,y,0);//z);
    if(om==0)
    ellipse(0,0,rad,rad);
    else
    rect(-rad*0.5,-rad*0.5,rad,rad);
    
    line(0,0,dev*10,0);
    line(0,0,accx*10,accy*10);
    popMatrix();          



  }


}









