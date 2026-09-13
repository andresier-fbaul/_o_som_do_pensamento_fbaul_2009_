
//
//	blosc // andré sier // v.01 jan 20090119
// 


//	simple utility app that tracks blobs in a camera based image and 
//	sends blobs information to the localhost on port 7737 via osc protocol.


//	key commands: 
//		' ' :  space in om 0 clears background to the current frame
//		'o' :  change om; 0=background check / 1=continuous difference
//		't/T': add/remove thresh val
//		'f/F': add/remove fade val
//		'i' :  toggle output image (still calcs and sends blobs information)


#ifndef _TEST_APP
#define _TEST_APP

#define _USE_LIVE_VIDEO		// comment for movie

#define OF_ADDON_USING_OFXOPENCV
#define OF_ADDON_USING_OFXOSC

#include "ofMain.h"
#include "ofAddons.h"
#include "computervision.h"

#define HOST "localhost"
#define PORT 7737


class testApp : public ofSimpleApp{	
	public:
		void setup();
		void update();
		void draw();

		void keyPressed  (int key);
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased();
	
	private:
		//vars
		int	thiswidth,thisheight;
		float rw, rh, ra; //reciprocal camera width, reciprocal camera height , reciprocal area
		int framecounter;
		int	om; // modo de computer vision : 0=background check / 1=continuous difference
		bool calcimg; // toggle to draw to screen (doenst really impact performance??)
		int stattxt; // change assistance txt
	
		ComputerVision		cv; // o objecto já instanciado	
		ofxOscSender		oscsender; // o obj que envia osc		
};

#endif
