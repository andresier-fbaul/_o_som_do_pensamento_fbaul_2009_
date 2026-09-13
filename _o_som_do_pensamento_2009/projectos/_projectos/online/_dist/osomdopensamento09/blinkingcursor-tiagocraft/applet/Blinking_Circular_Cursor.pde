class PulsingCircle{
  float iRad= 50;  //preset radius
  float rad = iRad;  //mouse-modulated radius
  float rad2 = rad;  // pulsing radius
  float phase = random(2)-1;  //pulse phase
  float inc = random(0.02, 0.075);  //phase increment at each frame
  float weight = int(random(5));  //ellipse line-weight
  color col = color(15,210,200,80);

  void update(){

    phase+=(inc+2*map(weight,0,5,0.075,0.02))/3; //pulsing is determined 1*by the inc. and 2* the line-weight
    if(phase>TWO_PI)
      phase-=TWO_PI;

    //modulate the circle radius with the mouse buttons
    if(mousePressed==true)
      rad = (9*rad+iRad*0.7)/10;
    else
      rad = (9*rad+iRad)/10;
    
    draw(mouseX,mouseY, phase);
  }
  
  void draw(float x,float y, float phase){
    noFill();
    smooth();
    stroke(col);
    

    
    //trace the circle
    
    for(float i=weight;i>0;i-=1){
      strokeWeight(i);
      rad2 = 2*rad+0.5*rad*sin(phase);
      ellipse(x,y,rad2,rad2);
    }
    stroke (80,75);
    strokeWeight (5);
    ellipse (mouseX,mouseY,1.6*rad,1.6*rad);
  }
}
