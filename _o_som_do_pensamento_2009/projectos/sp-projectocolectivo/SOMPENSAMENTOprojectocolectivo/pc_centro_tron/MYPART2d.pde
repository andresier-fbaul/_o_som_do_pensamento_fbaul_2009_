
/// um exemplo de uma class extendida como vocês podem saber
/// lembrem-se que tudo o que faz part da Particula existe já nesta class

class MYPART2D extends Particula {

  int cor0,cor1; // vou adicionar cor
  float dev; // e uns parâmetros para movimento

  int dir = (int)random(3); // 0 esquerda, 1 cima, 2 direita, 3 baixo
  int timer = 100;
  float speed = random(5,15);


  int om = (int) random(2);

  MYPART2D( float _x, float _y) {
    super(_x,_y); //chamar o construtor de Particula

    dir = (int) random(4);
    timer = (int) random ( 10,50 );


    cor0 = random(1) < 0.5 ? color (0): color(255) ;
    cor1 = color ( 255-green(cor0) );

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

    //   life -= 1.21;

    if(frameCount % timer == 0 ) {

      dir = (int) random(4);
      timer = frameCount + (int) random ( 5, 25 );

    }


    velx = vely = 0;

    if( dir == 0 ) {
      
       x = x - speed; 
       velx = -speed;
      
    } else if (dir == 1) {
     
       y = y - speed; 
       vely = -speed;
      
    } else if (dir == 2) {
       x = x + speed; 
       velx = speed;
    } else if( dir == 3) {

      vely = speed;

       y = y+speed; 
    }


    // bounds apenas y...

    if(y<0){
      dir = 3;
    }
    if(y>height){
      dir = 1;
    }

    // , para x basta

    checkSendNet();




  }


  void draw(){

    stroke(cor0,life);//200);    
    strokeWeight(5);       
    line(x,y, x-velx*5, y - vely*5);
    stroke(cor1,life);//200);    
    strokeWeight(2);       
    line(x,y, x-velx*2, y - vely*2);
    
    ellipse(x,y,10,10);


  }


}










