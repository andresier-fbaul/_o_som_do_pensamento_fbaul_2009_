#include "ofMain.h"
#include "Objecto.h"

/*
    Objecto(float _x, float _y, float _z, float _r, float _c);
    ~Objecto();
    void update();
    void draw();
*/

// construtor
Objecto::Objecto(){




}


// destrutor
Objecto::~Objecto(){


}


void Objecto::init(float _x, float _y, float _z, float _r, float _c){

    x = _x;
    y = _y;
    z = _z;
    rad = _r;
    cor = _c;



}




void Objecto::update(float speed){

    z+=speed;//1.0f;//100.0;
    if(z>0)
      z = ZMAX;//-8000;

    cor = CLAMP( ofMap (z , -8000, 0 , 0, 255)  , 0 , 255) ;


}



void Objecto::draw(){

//    pushMatrix();
//    translate(x,y,z);
//    //cor
//    fill(cor,cor,cor,255);
//    noStroke();
//    ellipse(0,0,rad,rad);
//    popMatrix();
    float c = cor;///255.0f;

    glPushMatrix();
    glTranslatef(x,y,z);
    glColor3f(cor,cor,cor);
    ofCircle(0,0,rad);
    glPopMatrix();


}
