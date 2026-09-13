
#include "Star.h"

////////////// 
Star::Star(){
	field();
}

////////////// 
Star::~Star(){
//	delete g_speed;
}

////////////// 
void Star::field(){	
	int w = ofGetWidth()*64;//10;
	int h = ofGetHeight()*36;//10;
	
	x = ofRandom(-w,w); 
	y = ofRandom(-h,h); 
	z = ofRandom(-1000,-Z_MAX); 
	speed = ofRandom(0.1,5.);
	g_speed = NULL; //é inicializado na setup 	
}

////////////// 
void Star::render(){	
	update();
	draw();	
}

////////////// 
void Star::update(){
	// *g_speed, como g_speed é um pointer, aponta para a data
	// apenas g_speed, aponta para o endereço de memória onde está a data
	float amt = (speed + (*g_speed));
	z += amt;	
	
	if(z>1500&& amt>0.){
		z = ofRandom(-5000,-Z_MAX); 
	}

	if(z<-Z_MAX&& amt<0.){
		z = ofRandom(-100,1500); 
	}
	
}

////////////// 
void Star::draw(){		
	glBegin(GL_LINES);
	glVertex3f(x,y,z);
	glVertex3f(x,y,z-speed*(*g_speed));
	glEnd();
}
