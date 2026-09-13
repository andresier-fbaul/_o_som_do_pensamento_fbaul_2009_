/*
 *  computervision.cpp
 *  openFrameworks
 *
 *  Created by andre sier on 10/1/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "computervision.h"



//////////////////////////////////////////////////////////
//construtores
ComputerVision::ComputerVision(){
	
}

//////////////////////////////////////////////////////////
ComputerVision::~ComputerVision(){
	if(camera!=NULL)
		delete camera;
}


//////////////////////////////////////////////////////////

//funções de arranque

void ComputerVision::loadVideo(string path){

	video.loadMovie(path);
	video.play();
	
	imgcolor.allocate(video.width, video.height);
	imggray.allocate(video.width, video.height);
	imgthresh.allocate(video.width, video.height);
	imgprev.allocate(video.width, video.height);
	imggraymotion.allocate(video.width, video.height);
		
	fadeAmnt    = 10.0f;
	threshAmnt  = 10;
	bPauseVideo = false;
	frameCount  = 0;
	bUseCamera  = false;

	DrawOm = 1;
	bLearnBackground = true; 
	mirrorX = true;
}


//////////////////////////////////////////////////////////
void ComputerVision::setupCamera(int which, int width, int height){
	
	camera = new ofVideoGrabber(); //alocate the pointer
	
	camera->setDeviceID(which);
	camera->initGrabber(width, height);
	camera->listDevices();

	imgcolor.allocate(camera->width, camera->height);
	imggray.allocate(camera->width, camera->height);
	imgthresh.allocate(camera->width, camera->height);
	imgprev.allocate(camera->width, camera->height);
	imggraymotion.allocate(camera->width, camera->height);
	
	fadeAmnt    = 10.0f;
	threshAmnt  = 10;
	bPauseVideo = false;
	frameCount  = 0;
	bUseCamera  = true;
	
	DrawOm = 1;

	bLearnBackground = true;
	mirrorX = true;
	
}


//////////////////////////////////////////////////////////
void ComputerVision::update(){
	
	if(bPauseVideo ) return;

	if(bUseCamera){
		camera->grabFrame();
		// previous frame
		if(om>0||bLearnBackground)
			imgprev = imggray;	
		if(om==0&&bLearnBackground)
			bLearnBackground=false;
		imgcolor.setFromPixels(camera->getPixels(), camera->width, camera->height);
	}else{		
		video.idleMovie();
		if(video.isFrameNew()){
			if(om>0||bLearnBackground)
				imgprev = imggray;		
			if(om==0&&bLearnBackground)
				bLearnBackground=false;
			frameCount++;
		}else{
			return;
		}		
		imgcolor.setFromPixels(video.getPixels(), video.width, video.height);
	}
	
	//convert the color image to grayscale
	imggray = imgcolor;
	//mirror gray image x axis
	if(	mirrorX )
		imggray.mirror(false,true);

	//do absolute diff between the prev frame and current frame
	//all pixels that are different will show up as non-black
	imgthresh.absDiff(imggray, imgprev);	
	//threshold to binary value
	imgthresh.threshold(threshAmnt);
	
	// fade imggraymotion and add tresh
	imggraymotion -= fadeAmnt; 
	imggraymotion += imgthresh;
	
	// encontrar blobs nos contours
	contourFinder.findContours(imggraymotion, 20, (340*240)/3, MAX_BLOBS, false);	// 20blobs & no find holes
		
}


//////////////////////////////////////////////////////////
void ComputerVision::draw(float x, float y){
	switch (DrawOm) {
		case 0:
			break;

		case 1:
				int cx,cy;
			
				ofSetColor(0xFFFFFF);
				imggray.draw(x, y);
				imgthresh.draw(x, y + imggray.height);
				imggray.draw(x, y + imggray.height + imgthresh.height);				
				imggraymotion.draw(imggray.width +10 ,  imggray.height);			
				
				// we could draw the whole contour finder
				 cx = imggray.width +10;//360;
				 cy = 0;//40;
				contourFinder.draw(cx,cy);
				
				// e tb desenhar os centroids
				for(int i=0; i < contourFinder.nBlobs; i++) {
					ofRect(contourFinder.blobs[i].centroid.x+cx,contourFinder.blobs[i].centroid.y+cy, 10,10);
				}
				
				// e tb desenhar os centroids duas vezes!!
				for(int i=0; i < contourFinder.nBlobs; i++) {
					ofRect(contourFinder.blobs[i].centroid.x+cx,contourFinder.blobs[i].centroid.y+cy+imggray.height, 10,10);
				}
			
						
			
			break;						
	
		case 2:
			
			glColor4f(1.f,1.f,1.f,0.8f);
			imggraymotion.draw(0,0,w,h); //setable during setup

			break;
		
		case 3:
						
				glColor4f(1.f,1.f,1.f,0.2f);//0.8f);
				imggraymotion.draw(0,0,w,h); //setable during setup

				glColor4f(1.f,1.f,1.f,0.05f);
				imggray.draw(w-imggray.width, h-imggray.height);
				imggraymotion.draw(w-imggray.width, h-imggray.height*2);
			
			break;
	}
}


//////////////////////////////////////////////////////////
void ComputerVision::refreshvdig(){
	// delete it
	camera->close();
	delete camera;
	// make a new camera
	camera = new ofVideoGrabber();
	camera->setDeviceID(0);
	camera->initGrabber(320,240);
}


//////////////////////////////////////////////////////////
void ComputerVision::setFade(float amt){
	fadeAmnt = amt;
}


//////////////////////////////////////////////////////////
void ComputerVision::setThresh(float thresh){
	threshAmnt = thresh;
}

//////////////////////////////////////////////////////////
void ComputerVision::setDrawOm(int om){
	DrawOm = om;
}
//////////////////////////////////////////////////////////