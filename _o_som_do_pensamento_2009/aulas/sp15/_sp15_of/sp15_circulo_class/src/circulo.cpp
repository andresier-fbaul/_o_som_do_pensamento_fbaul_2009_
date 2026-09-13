#include "circulo.h"


//------------------------------------------------------------------
Circulo::Circulo(){
	//iniciar as variaveis
	rad = ofRandom(20,50);
	posx = ofRandom (rad,ofGetWidth()-rad);
	posy = ofRandom (rad,ofGetHeight()-rad);
}

//------------------------------------------------------------------
void Circulo::draw() {
	ofFill();
    ofSetColor(82,247,195);

    ofCircle(posx, posy, rad, rad);
}
