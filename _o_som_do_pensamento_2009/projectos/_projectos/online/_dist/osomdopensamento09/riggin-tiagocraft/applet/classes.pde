class Corpo{
  int x, y;
  float px, py;
  
  Corpo(int in_x, int in_y){
    x = in_x;
    y = in_y;
    px = py = 0;
  }
  void update(){
    px = mouseX-int(width*0.5);
    py = constrain(mouseY-int(height*0.75),-100,-20);
  }
  void draw(){
    stroke(0);
    strokeWeight(1);
    fill(255);
    rectMode(CORNERS);
    rect(-x/2, 0, x/2, -y);
}}


class Aste{
  float x;
  float rot;

  Aste(int in_x){
    x = in_x;
    rot = 0;
  }
  void draw(){
    stroke(0);
    strokeWeight(1);
    fill(255);
    rectMode(CORNERS);
    rect(5, 0, -5, x);
}}


class Roda{
  float rad, sides;
  float rot;
  int contacto;

  Roda(int in_rad){
    rad = in_rad;
    sides=3;
    rot=0;
    contacto=1;
  }
 void draw(){
    beginShape();
      for(int a=0; a<=sides; a++){
        float ang = a*TWO_PI/sides;
        vertex(rad*cos(ang), rad*sin(ang));
      }
    endShape();
}}
