
class Sky{
  Linha linhas[] = new Linha[1000];
  Quadrado quadrados[] = new Quadrado[100];
  Sky(){
    for(int i=0;i<linhas.length;i++)
      linhas[i] = new Linha();    
    for(int i=0;i<quadrados.length;i++)
      quadrados[i] = new Quadrado();    
  }
  void draw(){
    stroke(0,200);
    for(int i=0;i<linhas.length;i++)
      linhas[i].go();    
    noStroke();//stroke(255,200);
    for(int i=0;i<quadrados.length;i++)
      quadrados[i].go();    

  }
}


class Quadrado extends Linha{

  float dimx = random(700,2500),dimy = dimx*3.0f/4.0f;
  int cor;
  float alfa = random(10,150);

  Quadrado(){
    super(); 
    y = random(250,5000); 
    int m = random(1)<0.5 ? (int) random(50) : (int)random(5,10)*25; 
    cor = color(m,m,m);
  }
  
  void go(){
    super.update();
    fill(cor,alfa);
    pushMatrix();
    translate(x,y,z);
    rect(0,0,dimx,dimy);
    popMatrix();
  }

}

class Linha{

  float x,y,z,vz;

  Linha(){
    x = random(-25000,25000); 
    y = random(-5000,5000); 
    z = random(-15000,1000);
    vz = -25 - random(10);
  }

  void update(){
    z+=vz;     
    if(z<-15000)
      z=1000;    
  }

  void go(){
    update();
    line(x,y,z,x,y,z+vz);
  }
}


