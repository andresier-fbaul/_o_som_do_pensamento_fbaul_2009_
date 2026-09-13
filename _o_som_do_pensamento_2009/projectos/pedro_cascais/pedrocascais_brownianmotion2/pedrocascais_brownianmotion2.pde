
class part {
  float x,y;

  part(){
    x = random(0,width);
    y = height;
  }

  void draw(){
    x+=random(-3,3);
    y+=random(-7,0);

    if(y < 0)
      y = height;
      
    ellipse(x,y,20,20);
  }

}



part p[];



void setup(){
  size(500,500);

  p = new part[50];
  for(int i=0; i < p.length; i++)
    p[i] = new part();

  background(0);

}

void draw(){

  for(int i=0; i < p.length; i++)
    p[i].draw();// = new part();

  
}


void keyPressed(){
 background(0); 
}
