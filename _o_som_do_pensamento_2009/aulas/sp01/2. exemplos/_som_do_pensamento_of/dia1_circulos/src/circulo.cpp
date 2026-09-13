#include "circulo.h"


//------------------------------------------------------------------
Circulo::Circulo(){
	//iniciar as variaveis
	rad = ofRandom(10,30);
	posx = ofRandom (rad,ofGetWidth()-rad);
	posy = ofRandom (rad,ofGetHeight()-rad);
}

//------------------------------------------------------------------
void Circulo::draw() {
	// circulo cheio
	ofFill();
    ofSetColor(82,247,195);
    ofCircle(posx, posy, rad, rad);

	// adicionar um circulo vazio preto
	ofNoFill();
    ofSetColor(0,0,0);
    ofCircle(posx, posy, rad, rad);
	
	
}


void Circulo::reset() {
	posx = ofRandom (rad,ofGetWidth()-rad);
	posy = ofRandom (rad,ofGetHeight()-rad);
	
}
