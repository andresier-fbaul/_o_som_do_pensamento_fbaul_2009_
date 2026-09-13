
/// um exemplo de uma class extendida como vocês podem saber
/// lembrem-se que tudo o que faz part da Particula existe já nesta class

class MYPART2D extends Particula {

  float dev; // e uns parâmetros para movimento
  PImage img;
  int om = (int) random(2);

  MYPART2D(PImage img, float _x, float _y) {
    super(_x,_y); //chamar o construtor de Particula
    this.img = img;

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
    
//    life -= 1.21;

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

    pushMatrix();
    translate(x,y,0);//z);
    image(img,0,0);
    popMatrix();          



  }


}









