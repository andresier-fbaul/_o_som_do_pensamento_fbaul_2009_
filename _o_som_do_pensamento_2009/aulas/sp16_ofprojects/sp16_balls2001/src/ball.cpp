/*
 *  ball.cpp
 *  openFrameworks
 *
 *  Created by andre sier on 5/12/08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */

#include "ball.h"


Ball::Ball(){

	px = ofRandom(0,ofGetWidth());
	py = ofRandom(0,300);

	sx = (ofRandomuf()<0.1)?ofRandom(-10.2,10.2):ofRandom(-2.2,2.2); // ofRandom(-0.2,0.2);
	sy = (ofRandomuf()<0.1)?ofRandom(-10.001,20.02):ofRandom(0.001,0.02);//(5,10);
	
	rad = ofRandom(10,30);//ofRandom(5,20);//ofRandom(20,50);
	
	ground=false;
	
	snd.loadSound("2001_zarathustra.aiff");

	playtime = playtimemax = 0;

	active=true;//false;
	
	if(ofRandomuf()<0.5)
		colide=true;
	else 
		colide=false;
	
}

Ball::~Ball(){
//	snd.unloadSound();
}


void Ball::activate(bool bactive){
	active=bactive;
}



void Ball::playsound(float pos, float vol,float dur){
	
	if(ground){
		playtimemax = (int) dur;
		playtime = playtimemax; 
	}

	snd.play();		// tem de ser antes, senao o set pos nao funciona
	
	snd.setPosition(pos); //	already 0.1
	snd.setVolume(vol);
	
	
//	snd.play();
	
}



// collision stuff
bool Ball::intersects(Ball *b) {
	
	float left = (b->px - px)*(b->px - px) + (b->py - py)*(b->py - py);
	float right = (b->rad+rad)*(b->rad+rad);
	return (left<=right);
}

void Ball::resolveCollision(Ball *a) {

	// just flip speeds for now
	float tx = sx, ty = sy;
	
	float fact = ofRandom(0.9,1.1);
	
	sx = a->sx*fact;
	sy = a->sy*fact;
	a->sx = tx*fact;
	a->sy = ty*fact;
	
	px+=sx;
	py+=sy;
	a->px+=a->sx;
	a->py+=a->sy;
}









void Ball::update(){
	
	
	if(active) {
	
		px += sx;
		py += sy;
		
		sy += grav;

		//bouce
		if(px>ofGetWidth())
			sx=-sx;
		if(px<0)
			sx=-sx;


		//bounce on 0 and play		
		if(py-rad < 10) {
			sy*=0.996;
		}
		
		
		/*
			wrap
			
	if(px>ofGetWidth())
		px-=ofGetWidth();
	if(px<0)
		px+=ofGetWidth();
	
		 */
		
	if(py+rad > ofGetHeight()-10) {
		ground=true;
		py=ofGetHeight()-10-rad;
		sy=-sy;		
		//py += sy;
	}
	
	if(ground){
		
		float pos = ofMap(px, 0 , ofGetWidth(), 0., 1.); // in percent
		float vol = ofMap((ABS(sx)+ABS(sy)),0,10,0.,1.);
		float dur = ofMap(sy, 0 , -10, 2,30);//1., 10.); // in frames
		playsound(pos,vol,dur);
		if( ABS(sy) < 0.01){
			sy = -20;
			//py += sy;
		}
	}
	
	
	//snd
	if(playtime>0) {
		playtime--;
		
	} else{
		if(snd.getIsPlaying()){
			snd.stop();
		}
	}

	
	
	}
	
	
}


void Ball::draw(){
	
	if(active) {
	
		float alpha= CLAMP(ofMap((ABS(sx)+ABS(sy)),0,20,255,20),20,255);
		
	if(ground) {
		ground=false;
		ofSetColor(0,0,0);
	} else
		ofSetColor(255,255,255,alpha);

		ofFill();
	
		ofCircle(px,py,rad);

		//outline
		ofNoFill();
		if(!colide)
			ofSetColor(50,50,50,alpha);
		else
			ofSetColor(0,100,0,alpha);
		ofCircle(px,py,rad);

		//center
		ofSetColor(0,0,0);
		ofRect(px,py,2,2);
	
	}
	
}