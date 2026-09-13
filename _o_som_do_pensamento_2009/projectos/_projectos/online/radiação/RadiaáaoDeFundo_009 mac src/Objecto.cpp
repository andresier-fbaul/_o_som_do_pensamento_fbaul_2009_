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
//--------------------------------------------------------------
//void Objecto::joystick(unsigned int buttonMask, int x, int y, int z) {
//
//	// retrieve each button by masking the int with powers of two
//	for(int i=0;i<joynumbuttons;i++){
//		joybuttons[i] =  (buttonMask & (1<<i));
//	}
//
//	joyx = x;
//	joyy = y;
//	joyz = z;
//
//}
//--------------------------------------------------------------

void Objecto::init(long double _x, long double _y, long double _z, long double _c,long double _red, long double _green, long double _blue){

    x = _x;
    y = _y;
    z = _z;
//    rad = _r;
    cor = _c;
    green = _green;


}




void Objecto::update(long double speed){

    z+=speed;//200.0f;//1.0f;//100.0;
    if(z>-1)
        z = ZMAX;//-8000;

    cor = CLAMP( ofMap (z , ZMAX , -1 , 0, 255)  , 0 , 255) ;
    green = CLAMP( ofMap (z , ZMAX , -1 , 0, 350)  , 0 , 350) ;
    red = CLAMP( ofMap (z , ZMAX , -1 , 0, 300)  , 0 , 300) ;

}



void Objecto::draw(){

//    pushMatrix();
//    translate(x,y,z);
//    //cor
//    fill(cor,cor,cor,255);
//    noStroke();
//    ellipse(0,0,rad,rad);
//    popMatrix();

  //  joyx = 0;//joystic
//	joyy = 0;
//	joyz = 0;
//	joynumbuttons = 12;
//    joybuttons = new bool[joynumbuttons];
//	for(int i=0;i<joynumbuttons;i++){
//		joybuttons[i] = false;
//	}


float rad=40;

//        if (joybuttons[0]==true){
//
//        rad+=2;
//	}
//        if (joybuttons[2]==true){
//
//        rad-=2;
//	}

    float c = cor/255.0f;

    float g = green/255.0f;

    float r = red/255.0f;

    glPushMatrix();
    glTranslatef(x,y,z);
    glColor3f(r,g,c);
    ofCircle(0,0,rad);
    glPopMatrix();


}
