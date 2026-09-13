Corpo corpo;
Aste asteFrente1, asteFrente2, asteMeio, asteTras;
Roda rodaFrente, rodaMeio, rodaTras;

void setup(){
  size(800,200);
  frameRate(30);
  corpo = new Corpo(100,40);
  asteFrente1 = new Aste(40);
  asteFrente2 = new Aste(30);
  asteMeio = new Aste(25);
  rodaMeio = new Roda(10);
  rodaFrente = new Roda(10);
  asteTras = new Aste(40);
  rodaTras = new Roda(10);
}

void draw(){
  update();
  background(255);
  pushMatrix();
    translate(width*0.5, height*0.8);
    line(-width/2, 0, width/2, 0);
    translate(corpo.px, corpo.py);
    scale(-1,1);
    pushMatrix();
      rotate(asteTras.rot);
      asteTras.draw();
      translate(0, asteTras.x);
      rotate(rodaTras.rot);
      rodaTras.draw();
    popMatrix();
    pushMatrix();
      rotate(asteFrente1.rot);
      asteFrente1.draw();
      translate(0, asteFrente1.x);
      pushMatrix();
        rotate(asteFrente2.rot);
        asteFrente2.draw();
        translate(0,asteFrente2.x);
        rotate(rodaFrente.rot);
        rodaFrente.draw();
      popMatrix();
      pushMatrix();
        rotate(asteMeio.rot);
        asteMeio.draw();
        translate(0,asteMeio.x);
        rotate(rodaMeio.rot);
        rodaMeio.draw();
      popMatrix();
    popMatrix();
    translate(-corpo.x/7,0);
    corpo.draw();
    translate(-corpo.x/2+rodaFrente.rad*2,-corpo.y/2);
    rotate(PI);
    rodaFrente.draw();
  popMatrix();
}

