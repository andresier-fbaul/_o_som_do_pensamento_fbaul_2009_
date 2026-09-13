#include "ofMain.h"
#include "testApp.h"
#include "ofAppGlutWindow.h"

//========================================================================
int main( ){

    ofAppGlutWindow window;
//	ofSetupOpenGL(&window,1680,1050,OF_FULLSCREEN);			// <-------- setup the GL context
	ofSetupOpenGL(&window,800,800,OF_WINDOW);			// <-------- setup the GL context

	ofHideCursor();


	// this kicks off the running of my app
	// can be OF_WINDOW or OF_FULLSCREEN
	// pass in width and height too:
	ofRunApp( new testApp());

}
