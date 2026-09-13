/*
 *  Part.h
 *  openFrameworks
 *
 *  Created by andre sier on 24/3/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "ofMain.h"

#ifndef __PART_H
#define __PART_H 1

class Part{
public:
	
	float x,y,vx,vy;
	float energy,energy_dec,friccao;
	bool active; 

	Part(){
	};

	~Part(){};
	
	Part(float _x,float _y){
		init(_x,_y);
	}

	void init(float _x,float _y){
		x = _x;
		y = _y;
		vx = ofRandom(-5.0f,5.0f);
		vy = ofRandom(-2.0f,2.0f);
		energy = 255.f;
		friccao = 0.970;//float friccao = 0.970;
		active = true;
		energy_dec =  ofRandom(0.1f,5.5f);
	}
	
	void render(){
		update();
		ofSetColor(255,255,255,energy);
		ofCircle(x,y,20);
	}
	
	void update(){
		x+=vx;
		y+=vy;
		vx*=friccao;
		vy*=friccao;
		energy-=energy_dec;
		if(energy<0.)
			active=false; 
	}
	
	
};

#endif