#include "testApp.h"


//--------------------------------------------------------------
void testApp::setup(){	
	
	ofSetVerticalSync(true);
	ofSetFrameRate(60);
	ofBackground(200,210,200);
	angl = 90.f;
	
	for (int i = 0; i < 1000; i++){
		particle myParticle;
		myParticle.setInitialCondition(300,300,0, ofRandom(-4,4), ofRandom(-4,4),ofRandom(-4,4));
		// more interesting with diversity :)
		//myParticle.damping = ofRandom(0.001, 0.05);
		particles.push_back(myParticle);
	}
	
}

//--------------------------------------------------------------
void testApp::update(){

	// on every frame 
	// we reset the forces
	// add in any forces on the particle
	// perfom damping and
	// then update
	
	for (int i = 0; i < particles.size(); i++){
		particles[i].resetForce();
		particles[i].addDampingForce();
		particles[i].update();
	}
	
	angl += ofMap(mouseX,0,ofGetWidth(),-1.f,1.f);

}

//--------------------------------------------------------------
void testApp::draw(){

	
//	glPushMatrix();
//	glTranslatef(ofGetWidth()/2.f,0.f,-100.f);
//	glRotatef(angl,0,1,0);
	
	ofSetColor(0x000000);
	
	for (int i = 0; i < particles.size(); i++){
		particles[i].draw();
	}

//	glPopMatrix();
	
	ofSetColor(0x000000);

	ofDrawBitmapString("fps: "+ofToString(ofGetFrameRate(), 1)+
					   "\nnum: "+ofToString(particles.size(),0),
					   5,15);
	
}

//--------------------------------------------------------------
void testApp::keyPressed  (int key){ 
	if(key==' ')
		particles.clear();
}

//--------------------------------------------------------------
void testApp::keyReleased  (int key){ 
}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){
}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){
}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){
//	for (int i = 0; i < particles.size(); i++){
//		particles[i].setInitialCondition(mouseX,mouseY,0, ofRandom(-4,4), ofRandom(-4,4),ofRandom(-4,4));
//	}
	
	int num = (int) ofRandom(100,700);
	
	for (int i = 0; i < num; i++){
		particle partic;
		partic.setInitialCondition(mouseX,mouseY,0, ofRandom(-4,4), ofRandom(-4,4),ofRandom(-4,4));
		particles.push_back(partic);
	}
	

}

//--------------------------------------------------------------
void testApp::mouseReleased(){
}
