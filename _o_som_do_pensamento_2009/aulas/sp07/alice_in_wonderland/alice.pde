class Alice{

  float x,y;
  PImage img;
  boolean left,right,up;
  float speed;

  Alice(){
    img = loadImage("alicet.png"); 
  }

  void move(){
    keys();

    if(up)
      y-=2;
    else
      y+=1.2;

    y = constrain(y,-1000,height);

    if(left)
      x-= speed;
    if(right)
      x+= speed;
      
      if(left||right){
        speed += 1;
        speed = constrain(speed,0,100);  
    } else
      speed = 0;


  }

  void draw(){
    image(img,x,y); 
  }

  void keys(){
    if(keyPressed) {
      if(keyCode==UP)
        up=true;
      if(keyCode==LEFT)
        left=true;
      if(keyCode==RIGHT)
        right=true;

      if(key=='w')
        up=true;
      if(key=='a')
        left=true;
      if(key=='d')
        right=true;


    }
 

  } 

}
