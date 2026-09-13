class Botao {

  float x, y, w, h, raio;
  int modo; // modo 0 rect modo 1 ellipse
  int cor;
  int estado; // decrescer se não intersectar, crescer se intersectar
  boolean toca = false;

  Botao( float _x, float _y, float _larg , float _alt, int _om  ) {

    x = _x;
    y = _y;
//    raio = _rad;
    w = _larg;
    h = _alt;
    raio = (w+h)/2;

    modo = _om;
    
    cor = 100;

  } 


  void test(float _x, float _y) {
    
    boolean in = false;
    
    if( _x > x-w/2 && _x < x + w/2 && _y > y-h/2 && _y < y + h/2){ 

        in = true;
//      float dx = x - _x;
//      float dy = y - _y;
//      float d = sqrt(dx*dx+dy*dy);
//      
//     // raio = (w+h)/2;
   }   
        if(in == true) {
//        // sabemos toca O BOTAO      
           cor  = 150;
//          
           estado = estado + 1;
//          
           if(estado > 10) {
            estado = 10;
            cor = 255;            
          }
//          
//          toca = true;              
        }
    
  }


  void render(){

    if(toca==false){      
      cor = 100;
      estado = estado - 1;
      if (estado < 0)
        estado = 0;
    }
    
    
    stroke(255);
    fill(cor,100);
    
    switch ( modo ) {      
      case 0:
          rect(x,y,w,h);
        break; 
      case 1:
          ellipse(x,y,raio,raio);
        break;
    }
    
      
      
      fill(0);
      text(""+estado,x,y);


      toca = false;
    
  }


}

