class Centro {

  float x,y;
  float px,py;
  float xamount = random(2,30);//20;
  float yamount = random(2,30);//20;
  
  float speed = random (2, 10);

  //2 construtores
  Centro() { 
  };
  Centro(float _x, float _y) { 
    set(_x,_y);
  }

  void set (float _x, float _y) {
    px = x = _x;
    py = y = _y;
  }

  void update( float _x, float _y){
    px = x; 
    py = y; //primeiro copiar valores anteriores
    x = _x; 
    y = _y; //depois actualizar
    bounds();
  }
  
  void bounds(){
    if(x<0||x>width||y<0||y>height) {
     x = width/2;
     y = height/2; 
    }
  }

  void dwell(){
    // brownian motion
    // pos = lastpos + random(-offset,offset);
 //   update( (random(-xamount,xamount)+x), (random(-yamount,yamount)+y)  ); 
 
     px = x;
     py = y;
 
 
     x = x + speed;/// 2;
     
     if ( x > width) {
      
      y = y + 100;
      x = 0;
     
      if (y > height)
       y = 0; 
       
     }
 
 
  }


  void draw(){
    fill(255,100);
    ellipse(x,y,20,20); 
  }

}



