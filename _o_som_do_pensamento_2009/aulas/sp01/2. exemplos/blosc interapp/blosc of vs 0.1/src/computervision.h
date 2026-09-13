/*
 *  computervision.h
 *  openFrameworks
 *
 *  Created by andre sier on 10/1/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */


//inspirada na do theo

#pragma once


#define OF_ADDON_USING_OFXOPENCV

#include "ofMain.h"
#include "ofAddons.h"

#define MAX_BLOBS	100

class ComputerVision{
public:
	//// imagens que preciso
	ofxCvColorImage			imgcolor;	
	ofxCvGrayscaleImage		imggray;
	ofxCvGrayscaleImage		imggraymotion;
	ofxCvGrayscaleImage		imgthresh;
	ofxCvGrayscaleImage		imgprev;
	ofxCvContourFinder		contourFinder;
	ofVideoGrabber			*camera; // now as a pointer.., preciso de a iniciar
	ofVideoPlayer			video;	
	// outras vars
	float threshAmnt, fadeAmnt;
	bool bPauseVideo;
	bool bUseCamera;
	int frameCount;	
	int DrawOm;	
	int w,h;	
	int om; // modo de operação // 1 remove bg //0 diferença contínua
	bool bLearnBackground;
	bool mirrorX;

	//construtores
	ComputerVision();
	~ComputerVision();
	//funções
	void loadVideo(string path);
	void setupCamera(int which, int width, int height);
	void update();
	void draw(float x, float y);	
	void refreshvdig();	
	void setFade(float amt);
	void setThresh(float thresh);
	void setDrawOm(int om);

};