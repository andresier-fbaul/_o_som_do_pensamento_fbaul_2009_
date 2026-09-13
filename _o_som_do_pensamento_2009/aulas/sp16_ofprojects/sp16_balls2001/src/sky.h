/*
 *  sky.h
 *  openFrameworks
 *
 *  Created by andre sier on 6/12/08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */


#ifndef SKY_H
#define SKY_H

#define MAXSTARS 2000

#include "ofMain.h"
#include "star.h"

class Sky{
	
public:
		
	Star	*stars[MAXSTARS];
	int   maxnum;
	
	Sky(int max);
	~Sky();	
	void draw();
	
};

#endif