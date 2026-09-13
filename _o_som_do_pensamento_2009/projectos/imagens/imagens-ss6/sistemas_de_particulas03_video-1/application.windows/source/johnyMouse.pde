class Johny {
void draw(){
  fill(255, 100);
  stroke(255,255);
  pushMatrix();
  translate(mouseX,mouseY);
  ellipse(0,0,30,30);
  beginShape();
    vertex(-4,0);
    vertex(-8,0);
    vertex(0,-8);
    vertex(8,0);
    vertex(4,0);
    vertex(4,4);
    vertex(-4,4);
  endShape();
  popMatrix();
}
}
