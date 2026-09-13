class star{
  float x,y,z,s; 
  float px,py,pz; 
  star(){
    field();
  }  
  void field(){
    float w = width*10; 
    float h = height*10; 
    px=x = noise(millis())*w-w/2;
    py=y = noise(second()+random(1000))*h-h/2;
    pz = z = noise(minute() +random(100))*-10000;
    s = noise(year()+random(22009))*10.;   
  }  

  void zz(){
    pz = z = noise(minute() +random(100))*-10000;    
  }

  void err(){
    //    point(x,y,z);
    if(z>500)
      zz();
    else
      line(x,y,z,px,py,pz);

    pz = z - 5*s;
    z+=s;


  }
}
import processing.opengl.*;
star s[];
void setup(){
  size(500,500,P3D);
  s = new star[1000];
  for(int i=0; i<s.length;i++)
    s[i]=new star();
}
void draw(){
  background(0);
  stroke(255,250);
  translate(width/2,height/2);
  rotate(sin(millis()*1e-7)*TWO_PI);
  for(int i=0; i<s.length;i++)
    s[i].err();
}

