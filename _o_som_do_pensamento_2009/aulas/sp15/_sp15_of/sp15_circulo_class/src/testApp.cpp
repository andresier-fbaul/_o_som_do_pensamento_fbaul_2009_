#include "testApp.h"
#include "ofMain.h"

//--------------------------------------------------------------
void testApp::setup(){

	
	ofSetFrameRate(60); //30
	
	// set background: 
	
	ofBackground(58,95,83);
	ofSetBackgroundAuto(false); // não chamar bg automaticamente ao inicio de cada draw

		
	// o círculo já foi instanciado com as suas variáveis
	
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
	//ofBackground(58,95,83);
	circulo.draw();
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
		circulo.posx = circulo.posx * (1.0-filter) + mouseX * filter;
		circulo.posy = circulo.posy * (1.0-filter) + mouseY * filter;
	} else { 
		//se o rato não premido, afastamo-nos
		float filter = 0.01;	
		// calcular um vector com origem no rato até ao circulo
		float dx = circulo.posx - mouseX;
		float dy = circulo.posy - mouseY;
		// as coordenadas de destino são a posição do círculo + o vector
		circulo.posx = circulo.posx * (1.0-filter) + (circulo.posx +dx) * filter;
		circulo.posy = circulo.posy * (1.0-filter) + (circulo.posy +dy) * filter;	
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
