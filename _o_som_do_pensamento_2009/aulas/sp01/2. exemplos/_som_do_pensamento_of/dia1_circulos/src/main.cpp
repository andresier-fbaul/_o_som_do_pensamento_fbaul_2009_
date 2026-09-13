#include "ofMain.h"
#include "testApp.h"

int main( ){

	ofSetupOpenGL(500,281, OF_WINDOW);			// <-------- setup the GL context

	//16:9
	
	// this kicks off the running of my app
	// can be OF_WINDOW or OF_FULLSCREEN
	// pass in width and height too:

	ofRunApp(new testApp());

}
