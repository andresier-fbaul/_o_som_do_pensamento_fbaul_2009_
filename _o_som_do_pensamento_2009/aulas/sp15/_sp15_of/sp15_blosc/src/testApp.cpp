#include "testApp.h"


//--------------------------------------------------------------
void testApp::setup(){
	
	#ifdef _USE_LIVE_VIDEO
		cv.setupCamera(0,320,240);
		cv.DrawOm = 2;//2;
	#else
		cv.loadVideo("movie.mov");
	#endif
		
	om = 0;/// deve ser o om do open cv
	cv.om = om;

	// copias dos valores de altura e largura, para nao andar sempre a pedir
	thiswidth = ofGetWidth();
	thisheight = ofGetHeight();
	framecounter=0;
	// passar cópia dos valoresv para dentro do obj cv
	cv.w = thiswidth;
	cv.h = thisheight;
	cv.DrawOm = 1;
	
	rw = 1.0f / 320.0f;
	rh = 1.0f / 240.0f; //reciprocal width, reciprocal height, reciprocal area  
	ra = 1.0f / (320.0*240.0);
	
	ofSetFrameRate(30); 
	ofSetRectMode(OF_RECTMODE_CORNER);
	ofSetBackgroundAuto(false); /// no clear bg
//	ofHideCursor();
	
	// open an outgoing connection to HOST:PORT
	oscsender.setup( HOST, PORT );
	calcimg = true;
	stattxt = true;
	
}

//--------------------------------------------------------------
void testApp::update(){
  
	// cv update
		cv.update();

	framecounter++;
	if(framecounter % 120 == 0){
		//stattxt^=true;
		stattxt++;
		if(stattxt>10)
			stattxt=0;
	}
	
	if(framecounter < 10)
		cv.bLearnBackground=true;

	
}


//--------------------------------------------------------------
void testApp::draw(){
	
	if(calcimg){
		ofBackground(0,0,0);
		ofEnableAlphaBlending();
		cv.draw(0,0); 
	}
		

//	send numblobs first
	int numblobs = cv.contourFinder.nBlobs; // clamped in the function, only 100 max, i guess
	/// osc sending code
	ofxOscMessage oscmessage;
	oscmessage.setAddress("/blosc/num");
	oscmessage.addIntArg(numblobs); // maxblobs
	oscsender.sendMessage( oscmessage );
	
	char reportStr[1024];

	for (int num = 0; num < numblobs; num++){
		ofPoint pt = cv.contourFinder.blobs[num].centroid;
		float area = cv.contourFinder.blobs[num].area;		
		/// osc sending code
		ofxOscMessage m; 
		m.setAddress("/blosc/data");
		m.addIntArg(num); // id x y area , x y area normalized
		m.addFloatArg(pt.x * rw);
		m.addFloatArg(pt.y * rh);
		m.addFloatArg(area * ra);
		oscsender.sendMessage( m );
	
		if(calcimg){	
			/// graphix code
			glColor4f(num*0.102f,num*0.502f,num*0.302f,0.7f);
			float areawidth = map(area, 0. , 76800, 20, 240);
			ofEllipse(map(pt.x,0.,320.,0.,thiswidth),map(pt.y,0.,240.,0.,thisheight), areawidth,areawidth);
			
			// graphix line center
			glColor4f(0.,1.,0.,0.75);
			float px = map(pt.x,0.,320.,0.,thiswidth);
			float py = map(pt.y,0.,240.,0.,thisheight);//ofGetHeight());
					   
			// write info
			glColor4f(1.,1.,1.,0.8);
			sprintf(reportStr, "%i\n",num);
			ofDrawBitmapString(reportStr, px,py);
		}
    }
	
	if(calcimg){
		string host = HOST;
		string port = ofToString(PORT);
		ofDrawBitmapString("\nfps "+ ofToString(ofGetFrameRate(), 2) + 
						   "\nnum "+ofToString(numblobs)+" om "+ofToString(om)+//" img "+ofToString(calcimg)+
						   "\nthresh "+ofToString(cv.threshAmnt,0)+" fade "+ofToString(cv.fadeAmnt,0)+" T/t F/f"
						   "\nhost: "+host+" "+port ,	
						   2, thisheight-55); 
					
	}
}


//--------------------------------------------------------------
void testApp::keyPressed  (int key){ 
	
	switch (key){
		case ' ':
			cv.bLearnBackground = true;
			break;
		case 'T':
			cv.threshAmnt++;//threshold ++;
			if (cv.threshAmnt > 255) cv.threshAmnt = 255;
			break;
		case 't':
			cv.threshAmnt --;
			if (cv.threshAmnt < 0) cv.threshAmnt = 0;
			break;
		case 'o':
			om=(om+1)%2 ;
			cv.om = om;
			break;
		case 's':
			cv.settings() ;			
			break;
		case 'f':
			cv.fadeAmnt++;//threshold ++;
			if (cv.fadeAmnt > 255) cv.fadeAmnt = 255;
			break;
		case 'F':
			cv.fadeAmnt --;
			if (cv.fadeAmnt < 0) cv.fadeAmnt = 0;
			break;
		case 'c':
		case 'i':
			calcimg^=true;
			break;
			
	}
}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){
}	

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){
}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){
}

//--------------------------------------------------------------
void testApp::mouseReleased(){

}
