/// Ola Mundo
/// O Som do Pensamento
/// Andre Sier

Linha  linhas[];

///////////setup

void setup(){
  size(400,216);
  frameRate(30);
  linhas=new Linha[25];
  for(int i=0; i<linhas.length;i++){
   linhas[i] = new Linha();
  }
}

///////////draw

void draw() {
  // apagar
  fill(0,10);  noStroke();
  rect(0,0,width,height);

  // update e desenhar
  stroke(255);
  strokeWeight(5);
  for(int i=0; i<linhas.length;i++){
   linhas[i].go();
  }

}

///////////classes

class Pt{
 float x,y;
 Pt(float _x, float _y){ x=_x; y=_y;}
}

class Linha{
 int len=55;
 float s=random(1,8);
 Pt p1 = new Pt(0,0);
 Pt p2 = new Pt(0,len);

 Linha(){ } 

 void go(){
    //update
    p1.x += s;
    p2.x += s;
    //wrap e add y
    if(p1.x>width) {
       p1.x = 0; p2.x = 0;
       p1.y += len; p2.y += len;
       if(p1.y > height) {
        p1.y = 0; p2.y = len;
       }
    }
     //desenhar
   line(p1.x,p1.y,p2.x,p2.y);
  }

}
