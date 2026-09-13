class Centro {

  float x,y;
  float px,py;
  float xamount = 20;
  float yamount = 20;

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
    bounds();//comment this to turn off centre movement limits
  }
  //limits the area for partcile center movement (ensures that it stays within the window)
  void bounds(){
    if(x<0||x>width||y<0||y>height) {
     x = width/2;
     y = height/2; 
    }
  }

  void dwell(){
    // brownian motion
    // pos = lastpos + random(-offset,offset);
    update( (random(-xamount,xamount)+x), (random(-yamount,yamount)+y)  ); //calls update function with randomized valiues
  }


  void draw(){
    fill(255,100);
    ellipse(x,y,20,20); 
  }

}



