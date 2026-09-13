



class Goodie{

  float px,py;
  float rad,radinc;
  float minRad=15;
  float maxRad=25;
  boolean active;
  float xSpeed;
  float ySpeed;

  Goodie(){
    reset();
  } 

  void reset(){
    px = random(maxRad,width-maxRad);
    
// avoid the screen vertical center    
    if(random(0,1) > 0.5)
      py = random(maxRad,height/2-maxRad);
    else
      py = random(height/2+maxRad,height-maxRad);

    rad = minRad;
    radinc = 1.2;
    active = true;
    xSpeed=ySpeed=0;
  }

  void resetAnSetRandomSpeed(float speedFactor){
    reset();
    if(random(0,1) < 0.5)
      xSpeed=speedFactor;
    else  
      ySpeed=speedFactor;
  }

  void draw(){
    if(active){
      noStroke();
      fill(#E2E53A);      
      ellipse(px,py, rad,rad);
      
      //updated radius
      rad+=radinc;
      if(rad<minRad||rad>maxRad)
        radinc=-radinc;

      px+=xSpeed;
      py+=ySpeed;
      
// wrap coords  
      px = (px+width) % width;  
      py = (py+height) % height;      
    }
  }


}




