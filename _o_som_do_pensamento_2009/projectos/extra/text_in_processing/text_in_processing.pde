PFont font;

void setup(){
  size (420,150);
  font = createFont("Arial",16);
//  font = loadFont("ArialMT-47.vlw");
  textFont(font,47);
  text("Hello World!", width/5,height/2);
}


