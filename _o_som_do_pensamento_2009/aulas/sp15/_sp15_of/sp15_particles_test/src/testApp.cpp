#include "testApp.h"



void testApp::setup() {
	
	ofSetFrameRate(60);
	ofBackground(0, 0, 0);
	ofSetBackgroundAuto(false);

	num_p = 2000;
	init_n_parts(num_p);

}



void testApp::draw() {

	ofBackground(0, 0, 0);
	ofEnableAlphaBlending();
	
	for(int i=0; i<num_p;i++){
//		(p+i)->render();
		p[i].render();
	}
	
}


void testApp::spawn(float x, float y){
	
	int carry = (int) ofRandom(2,10);
	int count = 0;
	
	for(int i=0; i<num_p;i++){
		if(!(p+i)->active){
			(p+i)->init(x,y);
			if(count++>=carry)
				break; //only some per loop
		}
	}
}

void testApp::init_n_parts(int num){	
     //iniciamos o apontador com mem—ria para uma array com num elementos
	p = new Part[num];
	num_p = num;
	
	float w = ofGetWidth()/2.0f;
	float h = ofGetHeight()/2.0f;
	
	printf("wh %f %f",w,h);
	
	for(int i=0; i<num;i++){
		float x = w+ofRandom(-100,100);
		float y = h+ofRandom(-100,100);
//		(p+i)->init(x,y);	///call init with these params			
		p[i].init(x,y);	///call init with these params			
	}
	
}



//--------------------------------------------------------------
void testApp::update(){
	
}


//--------------------------------------------------------------
void testApp::keyPressed  (int key){ 
	
}

//--------------------------------------------------------------
void testApp::keyReleased  (int key){ 
	
}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){
}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){
	spawn((float)x,(float) y);
}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){
	
	spawn((float)x,(float) y);
	
	
}

//--------------------------------------------------------------
void testApp::mouseReleased(){

}
