/*
 *  sky.cpp
 *  openFrameworks
 *
 *  Created by andre sier on 6/12/08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */

#include "sky.h"

Sky::Sky(int max) {
		
	maxnum = MIN(max,MAXSTARS);

	for(int i=0; i< maxnum; i++) {
		
		stars[i] = new Star;
		
		stars[i]->px = ofRandom(0,ofGetWidth());
		stars[i]->py = ofRandom(0,ofGetHeight());
		stars[i]->rad = ofRandom(0.1,2);

		stars[i]->alpha = ofRandomuf();
		stars[i]->alphaspeed = ofRandom(0.01,0.05);
	}
	
}


Sky::~Sky() {
	
//	for(int i=0; i< MAXSTARS; i++) {
//		delete stars[i];
//	}
	
	delete[] stars;
	
}


//////////////

void Sky::draw() {
	
	for(int i=0; i< maxnum; i++) {		
		// advance alpha
		stars[i]->alpha += stars[i]->alphaspeed;
		if(stars[i]->alpha > 1.f || stars[i]->alpha < 0.f)
			stars[i]->alphaspeed = -stars[i]->alphaspeed;

		ofSetColor(255, 255, 255, stars[i]->alpha*255.f);		
		ofCircle(stars[i]->px,stars[i]->py,stars[i]->rad);
	}
	
}
