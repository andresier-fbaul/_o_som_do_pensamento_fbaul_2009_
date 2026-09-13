#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	 

	ofBackground(0,0,0);
	ofSetFrameRate(60);
	global_speed = 0.1;
	// actualizar os apontadores das estrelas para o global
	for(int i = 0; i < MAX_STARS; i++)	{
		stars[i].g_speed = &global_speed; // & = address of ...	
										  // * = pointer to ...
	}
	
}

//--------------------------------------------------------------
void testApp::update(){
	
	for(int i=0; i < MAX_STARS; i++){
		stars[i].update();	
	}
	
}

//--------------------------------------------------------------
void testApp::draw(){
     
	ofBackground(0,0,0);
	
	camera();
	
	
	ofEnableAlphaBlending();
	
	glColor4f(1.,1.,1.,0.4);

	glLineWidth(1.0f);
	
	for(int i=0; i < MAX_STARS; i++){
		stars[i].draw();
	}

}


void testApp::camera(){
	
	float fov = 150.f;//120.f;//90.f;
	float w = ofGetWidth();
	float h = ofGetHeight();
	float ratio = w/h;
	float z = 1.0f;
	float Z = Z_MAX;//50000.0f;//20000.0f;
	
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(fov, ratio, z, Z);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	gluLookAt(0.f, 0.f, 100.f,		0.f, 0.f ,0.f,		0.,1.,0.);
	
}



//--------------------------------------------------------------
void testApp::keyPressed  (int key){ 
    
}

//--------------------------------------------------------------
void testApp::keyReleased  (int key){ 
}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){

	float max = 2500.f;
	global_speed = map(x,0,ofGetWidth(), -max, max);
		
}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){
}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){
}

//--------------------------------------------------------------
void testApp::mouseReleased(){
}
