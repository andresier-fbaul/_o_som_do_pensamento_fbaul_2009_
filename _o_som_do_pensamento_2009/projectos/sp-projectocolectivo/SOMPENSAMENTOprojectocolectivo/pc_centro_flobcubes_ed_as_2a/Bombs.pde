class Bomb{

  float x,y,s;
  int al=255, alspeed=(int)random(1,5),aldir=-1;
  boolean hit = false;
  int life = 50;

  Bomb(){
    build();
  }
  void build(){
    x = random(width);
    y = -50;
    s = (int)random(1,5) * 2.5;
    life = 5;
    hit = false;
  }
  void go(){
    
    
    if(hit){
      int m = (255-life) / 5;

      x+=random(-m,m);
      y+=random(-m,m);

      life--;
      if (life<0 ){
        build();        
      }
    } 
    else {
          for(int i=0; i<particulas.size();i++){
      MYPART2D part = (MYPART2D) particulas.get(i);
      float d = abs(x-part.x) + abs(y-part.y);
      if(d < 100){
        hit = true;
        particulas.remove(i); 
      }
    }


      y += s;
      if(y > height){
        hit = true;
      } 

    }


      strokeWeight(10);
      line(x,y,x,y-10*s);

      strokeWeight(2);
      fill(255,100);      
      ellipse(x,y,25,50);
      ellipse(x,y+16,45,2);


  }

}


