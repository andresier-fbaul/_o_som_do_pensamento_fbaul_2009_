#include "testApp.h"
#include "ofMain.h"

//--------------------------------------------------------------
void testApp::setup(){

	
	ofSetFrameRate(60); //30
	
	// set background: 
	
	ofBackground(58,95,83);
	ofSetBackgroundAuto(false); // não chamar bg automaticamente ao inicio de cada draw

		
	// o círculo já foi instanciado com as suas variáveis
	//iniciar as variaveis
	rad = ofRandom(20,50);
	posx = ofRandom (rad,ofGetWidth()-rad);
	posy = ofRandom (rad,ofGetHeight()-rad);
	
	
	// falta instanciar os valores das outras coordenadas
	
	followmouse = true; // atrás do rato
	mouseX = ofGetWidth()/2;
	mouseY = ofGetHeight()/2;
}

//--------------------------------------------------------------
void testApp::update(){
	
	go_mouse();
	
}

//--------------------------------------------------------------
void testApp::draw(){
	ofBackground(58,95,83);
	
	ofFill();
    ofSetColor(82,247,195);
	
    ofCircle(posx, posy, rad);
	//	circulo.draw();
	
}

//--------------------------------------------------------------
void testApp::keyPressed  (int key){
	
}

//--------------------------------------------------------------
void testApp::keyReleased  (int key){
}

//--------------------------------------------------------------
void testApp::go_mouse( ){
	
	if(followmouse){
		// um filtro low pass ao movimento com destino ao rato
		float filter = 0.01;			
//		circulo.posx = circulo.posx * (1.0-filter) + mouseX * filter;
//		circulo.posy = circulo.posy * (1.0-filter) + mouseY * filter;
		posx = posx * (1.0-filter) + mouseX * filter;
		posy = posy * (1.0-filter) + mouseY * filter;
	} else { 
		//se o rato não premido, afastamo-nos
		float filter = 0.01;	
		// calcular um vector com origem no rato até ao circulo
		float dx = posx - mouseX;
		float dy = posy - mouseY;
		// as coordenadas de destino são a posição do círculo + o vector
		posx = posx * (1.0-filter) + (posx +dx) * filter;
		posy = posy * (1.0-filter) + (posy +dy) * filter;	
	}
	
}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){
	//actualizar as coords do rato
	mouseX = x;
	mouseY = y;
	
	go_mouse();
}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){
	//actualizar as coords do rato
	mouseX = x;
	mouseY = y;
	
	go_mouse();
}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){
	followmouse = false;
}

//--------------------------------------------------------------
void testApp::mouseReleased(){
	followmouse = true;
}
