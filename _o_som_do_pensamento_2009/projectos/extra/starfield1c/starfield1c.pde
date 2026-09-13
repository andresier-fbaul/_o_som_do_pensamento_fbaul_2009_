
import processing.opengl.*;

star s[];

void setup(){
  size(1000,700,OPENGL);

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

