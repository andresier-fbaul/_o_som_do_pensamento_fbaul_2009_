/**
 * Bounce. 
 * 
 * When the shape hits the edge of the window, it reverses its direction. 
 */
 
int size = 60;       // Width of the shape
float xpos, ypos;    // Starting position of shape    

float xspeed = 2.8;  // Speed of the shape
float yspeed = 2.2;  // Speed of the shape

int xdirection = 1;  // Left or Right
int ydirection = 1;  // Top to Bottom



int size1 = 60;       // Width of the shape
float xpos1, ypos1;    // Starting position of shape    

float xspeed1 = random(5);  // Speed of the shape
float yspeed1 = random(5);  // Speed of the shape

int xdirection1 = 1;  // Left or Right
int ydirection1 = 1;  // Top to Bottom



void setup() 
{
  size(640, 200);
  noStroke();
  frameRate(30);
  smooth();
  // Set the starting position of the shape
  xpos = xpos1 = width/2;
  ypos = ypos1 = height/2;
}

void draw() 
{
  background(102);
  
  // Update the position of the shape
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );
  xpos1 = xpos1 + ( xspeed1 * xdirection1 );
  ypos1 = ypos1 + ( yspeed1 * ydirection1 );
  
  // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
  if (xpos > width-size || xpos < 0) {
    xdirection *= -1;
  }
  if (ypos > height-size || ypos < 0) {
    ydirection *= -1;
  }

  if (xpos1 > width-size || xpos1 < 0) {
    xdirection1 *= -1;
  }
  if (ypos1 > height-size || ypos1 < 0) {
    ydirection1 *= -1;
  }


  // Draw the shape
  ellipse(xpos+size/2, ypos+size/2, size, size);
  ellipse(xpos1+size/2, ypos1+size/2, size, size);
}
