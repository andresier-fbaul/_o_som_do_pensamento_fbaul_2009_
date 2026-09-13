//este código só tem alterações no void setup para setup_sketch0 e no void draw para void draw_sketch0


int numBalls = 12;
float spring = 0.05;
float gravity = 0.03;
float friction = -0.9;
Ball[] balls = new Ball[numBalls];

void setup_sketch0() 
{

  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(width), random(height), random(20, 40), i, balls);
  }
}

void draw_sketch0() 
{
  background(0);
  for (int i = 0; i < numBalls; i++) {
    balls[i].collide();
    balls[i].move();
    balls[i].display();  
  }
}

class Ball {
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] others;

  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  } 

  void collide() {

    // colisão com as outras bolas

    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }



    // colisão com os tuios


    Vector tuioObjectList = tuioClient.getTuioObjects();
    
    for (int i=0;i<tuioObjectList.size();i++) {
      
      TuioObject tobj = (TuioObject)tuioObjectList.elementAt(i);
      float tx = tobj.getScreenX(width);
      float ty = tobj.getScreenY(height);

       // algoritmo normal de colisão com elasticidade
      float dx = tx - x;
      float dy = ty - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = object_size/2 + diameter/2; //raio do tuio é objectsize/2
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - tx) * spring;
        float ay = (targetY - ty) * spring;
        vx -= ax;
        vy -= ay;
//        others[i].vx += ax;
//        others[i].vy += ay;
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

