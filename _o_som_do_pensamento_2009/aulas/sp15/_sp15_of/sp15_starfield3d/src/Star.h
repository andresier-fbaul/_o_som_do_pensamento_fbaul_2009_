
#pragma once

#include "ofMain.h"

#define Z_MAX			55000.0f

class Star{
public:
	float		x,y,z;
	float		speed, *g_speed;

	Star();
	~Star();
	void field();
	void render();
	void update();
	void draw();

};