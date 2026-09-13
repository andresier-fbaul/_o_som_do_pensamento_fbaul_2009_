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
  }
  void go(){
    for(int i=0; i<particulas.size();i++){
      MYPART2D part = (MYPART2D) particulas.get(i);
      float d = abs(x-part.x) + abs(y-part.y);
      if(d < 100){
        hit = true;
        particulas.remove(i); 
      }
    }

    if(hit){
      int m = (255-life) / 5;

      x+=random(-m,m);

      life--;
      if (life<0 ){
        build();        
      }
    } 
    else {

      y += s;
      if(y > height){
        hit = true;
      } 

    }



      line(x,y,x,y+10*s);
      
      ellipse(x,y,25,50);
      ellipse(x,y+40,55,10);


  }

}


