float x,y;

void setup(){
 size(500,500);
 x = width/2;
 y = height/2; 
 background(0);
 
}

void draw(){
 
 x+=random(-3,3);
 y+=random(-7,0);
 
 if(y < 0)
   y = height;
 
 ellipse(x,y,20,20); 
  
}
