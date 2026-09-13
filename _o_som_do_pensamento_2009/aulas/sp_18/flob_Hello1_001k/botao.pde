class Botao {

  float x, y, w, h, raio;
  int modo; // modo 0 rect modo 1 ellipse
  int cor;
  int estado; // decrescer se não intersectar, crescer se intersectar
  boolean toca = false;

  Botao( float _x, float _y, float _rad , int _om  ) {

    x = _x;
    y = _y;
    raio = _rad;
    w = h = raio;

    modo = _om;
    
    cor = 100;

  } 


  void test(float _x, float _y) {

      float dx = x - _x;
      float dy = y - _y;
      float d = sqrt(dx*dx+dy*dy);
      
      if(d <= raio) {
        // sabemos toca O BOTAO
      
          cor  = 150;
          
          estado = estado + 1;
          if(estado > 255) {
            estado = 255;
            cor = 255;
            
          }
          
          toca = true;
        
      
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
    fill(cor);
    
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

