#include "testApp.h"

#include "Poco/Poco.h"


void testApp::setup() {
	
	ofSetFrameRate(60);
	ofBackground(0, 0, 0);
	ofSetBackgroundAuto(false);
	ofSetVerticalSync(true);


//	inicializar
	int numparticulas = 250;
	for(int i=0;i<numparticulas;i++){
		Part particula;
		particula.init(ofRandom(0,ofGetWidth()),ofRandom(0,ofGetHeight()));
		particulas.push_back(particula);
	}

}


void testApp::draw() {

	ofBackground(0, 0, 0);
	ofEnableAlphaBlending();
	
	// zero a iniciar cada frame, para contar as activas
	int activecount=0;
	bool eraseparticulas = false;
	
	for(int i=0; i<particulas.size();i++){
		if(particulas[i].active ){
			particulas[i].render();
			activecount++;
		} else{
			// zero
//			particulas.erase( (&particulas[i]));
			if(eraseparticulas)
			particulas.erase( particulas.begin() );
		}
		
	}

//	particulas.erase(std::remove_if(particulas.begin(), particulas.end(), &particulaActiva), particulas.end());
	

	glColor4f(1.f,1.f,1.f,0.7f);
	ofDrawBitmapString("parts: "+ofToString(particulas.size(),0)+
					   "\nactive parts: "+ofToString(activecount,0)+
					   "\nfps: "+ofToString(ofGetFrameRate(), 2) , 5,10);
	
}


void testApp::spawn(float x, float y){
	
	int numparts = (int) ofRandom(2,10);
	
	for(int i=0; i<numparts;i++){		
		Part particula;
		float xd = ofRandom(-50,50);
		float yd = ofRandom(-50,50);
		particula.init(x+xd,y+yd);
		particulas.push_back(particula);
									  
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
//	particulas.clear();
	spawn((float)x,(float) y);
	
	
}

//--------------------------------------------------------------
void testApp::mouseReleased(){

}
