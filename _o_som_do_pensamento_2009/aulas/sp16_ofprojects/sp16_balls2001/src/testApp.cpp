#include "testApp.h"


//--------------------------------------------------------------
void testApp::setup(){	 	
	ofSetFrameRate(60);
	ofBackground(0, 0, 0);
	ofSetBackgroundAuto(false); /// no clear bg	
	
	sky = new Sky(100);//2000);	
	
	// handle tracking
	tracking=false;
	which=-1;
	pMouseX=0,pMouseY=0;

//	balls = new Ball[numballs];		

	//	inicializar
	for(int i=0;i<numballs;i++){
		Ball b;
		balls.push_back(b);
	}
	
}


//--------------------------------------------------------------
void testApp::update(){	
	for(int i=0; i < numballs; i++) {
		balls[i].update();
		for (int j=i+1; j < numballs; j++) {
			Ball *b = (Ball *) &balls[j];
			if(b->colide&&balls[i].colide) {
				if (balls[i].intersects(b)) {
					balls[i].resolveCollision(b);
				}
			}
		}
	}		
}

//--------------------------------------------------------------
void testApp::draw(){
//	ofBackground(0,0,0);//(80,80,20);
	ofFill();
	ofEnableAlphaBlending();
	ofSetColor(0, 0, 0, 55);//ofSetColor(100, 100, 100,55);	
	ofRect(0,0,ofGetWidth(),ofGetHeight());
			

	sky->draw();
	
//	ofDisableAlphaBlending();		
	for(int i=0; i < numballs; i++) {		
		balls[i].draw();		
	}	
}


//--------------------------------------------------------------
void testApp::keyPressed  (int key){ 	
	
}

//--------------------------------------------------------------
void testApp::keyReleased(int key){ 
	
}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){
	//store mouse pos
	pMouseX = x;
	pMouseY = y;
}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){

	if(tracking&&which!=-1) {
		float dx= x - pMouseX ;
		float dy= y - pMouseY ;	
		
		balls[which].sx += (dx*0.1);
		balls[which].sy += (dy*0.1);
	}

	//store mouse pos
	pMouseX = x;
	pMouseY = y;
	
	
/*	
	// add into vx and vy a small amount of the change in mouse:
	vx += (x - prevx) / 20.0f;
	vy += (y - prevy) / 20.0f;
	// store the previous mouse position:
	prevx = x;
	prevy = y;
*/
 }
 
//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){

	for(int i=0; i<numballs; i++) {

		float d = ABS(balls[i].px-x)+ABS(balls[i].py-y);

		if( d < (balls[i].rad*2.2)){
			tracking=true;
			which=i;
			break;
		} else {
			which=-1;
		}
		
	}
	
	//spawn ball
	if(which=-1){
		Ball b;
		b.px = mouseX; b.py = mouseY;
		balls.push_back(b);
	}
	
}

//--------------------------------------------------------------
void testApp::mouseReleased(){
	if(tracking){
		tracking=false;
		which=-1;
	}
}
