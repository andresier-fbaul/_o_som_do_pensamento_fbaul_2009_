/**
 * Bouncy Bubbles. 
 * Based on code from Keith Peters (www.bit-101.com). 
 * 
 * Multiple-object collision.
 */
 
 
int numBalls = 12;
float spring = 0.05;
float gravity = 0.1;//0.03;
float friction = -0.9;
ArrayList balls = new ArrayList();
//Ball[] balls = new Ball[numBalls];

void setup() 
{
  size(640, 400);
  noStroke();
  smooth();
  for (int i = 0; i < numBalls; i++) {
    Ball b = new Ball(random(width), random(height), random(20, 40), i, balls);
    balls.add(b);
  }
}

void draw() 
{
  background(0);
  for (int i = 0; i <  balls.size(); i++) {
    Ball b = (Ball) balls.get(i);
    b.collide();
    b.move();
    b.display();  
  }

  if(mousePressed){
    if(frameCount%10==0){
       Ball b = new Ball(mouseX,mouseY, random(20, 40), balls.size(), balls); 
       balls.add(b);
    }
  }  
}

class Ball {
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  ArrayList others;
 
  Ball(float xin, float yin, float din, int idin, ArrayList oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  } 
  
  void collide() {
    for (int i = id + 1; i < others.size(); i++) {
      Ball other = (Ball) others.get(i);
      float dx = other.x - x;
      float dy = other.y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = other.diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - other.x) * spring;
        float ay = (targetY - other.y) * spring;
        vx -= ax;
        vy -= ay;
        other.vx += ax;
        other.vy += ay;
      }
    }   
  }
  
  void move() {
    vy += gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction; 
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction; 
    } 
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }
  
  void display() {
    fill(255, 204);
    ellipse(x, y, diameter, diameter);
  }
}

void keyPressed(){
  if(key=='s')
    saveFrame("bouncybubbles-#####.jpg");

}


