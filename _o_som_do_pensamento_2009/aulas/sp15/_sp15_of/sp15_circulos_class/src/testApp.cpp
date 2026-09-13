#include "testApp.h"
#include "ofMain.h"

//--------------------------------------------------------------
void testApp::setup(){

	
	ofSetFrameRate(60); //30
	
	// set background: 
	
	ofBackground(58,95,83);
		
	ofSetRectMode(OF_RECTMODE_CORNER);
	//ofSetCircleM
	// os c’rculos j‡ foi instanciado com as suas vari‡veis
	
	// falta instanciar os valores das outras coordenadas
	
	followmouse = true; // atr‡s do rato
	mouseX = ofGetWidth()/2;
	mouseY = ofGetHeight()/2;
}

//--------------------------------------------------------------
void testApp::update(){
	
	go_mouse();
	
}

//--------------------------------------------------------------
void testApp::draw(){

	for(int i = 0; i < NUM_CIRCULOS; i++) {
	
		circulo[i].draw();
	
	}
}

//--------------------------------------------------------------
void testApp::keyPressed  (int key){
	
	if(key== ' '){
		for(int i = 0; i < NUM_CIRCULOS; i++) {
			
			circulo[i].reset();
			
		}
		
	}
	
}

//--------------------------------------------------------------
void testApp::keyReleased  (int key){
}

//--------------------------------------------------------------
void testApp::go_mouse( ){
	
	for(int i = 0; i < NUM_CIRCULOS; i++) {
		
		if(followmouse){
			// um filtro low pass ao movimento com destino ao rato
			float filter = 0.01;			
			circulo[i].posx = circulo[i].posx * (1.0-filter) + mouseX * filter;
			circulo[i].posy = circulo[i].posy * (1.0-filter) + mouseY * filter;
		} else { 
			//se o rato n‹o premido, afastamo-nos
			float filter = 0.01;	
			// calcular um vector com origem no rato atŽ ao circulo
			float dx = circulo[i].posx - mouseX;
			float dy = circulo[i].posy - mouseY;
			// as coordenadas de destino s‹o a posi‹o do c’rculo + o vector
			circulo[i].posx = circulo[i].posx * (1.0-filter) + (circulo[i].posx +dx) * filter;
			circulo[i].posy = circulo[i].posy * (1.0-filter) + (circulo[i].posy +dy) * filter;	
		}
	
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
