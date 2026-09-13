/*
 *  ball.h
 *  openFrameworks
 *
 *  Created by andre sier on 5/12/08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */



#ifndef BALL_H
#define BALL_H

 #include "ofMain.h"

#define grav 0.12
//0.05
//1.f
//2.0f
//0.5


class Ball{
	
public:
	
	float px,py,sx,sy,rad;
	bool ground,active;
	bool colide;
	int  playtime,playtimemax;
	
	ofSoundPlayer snd;
	
	Ball();
	~Ball();
	void update();
	void draw();
	
	void activate(bool bactive);
	void playsound(float pos, float vol, float dur);
	
	// collision stuff
	bool intersects(Ball *b);
	void resolveCollision(Ball *a);	
	
};




#endif