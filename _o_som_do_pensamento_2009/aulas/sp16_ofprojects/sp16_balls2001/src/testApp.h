#ifndef _TEST_APP
#define _TEST_APP


#include "ofMain.h"
#include "ball.h"
#include "sky.h"

#define numballs	20

class testApp : public ofSimpleApp{
	
	public:
		
		void setup();
		void update();
		void draw();
		
		void keyPressed  (int key);
		void keyReleased(int key);
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased();
	
		/// my data
		//Ball		*balls;
		vector<Ball> balls;
		Sky			*sky;

		// mouse
		bool		tracking;
		int			which;
		int			pMouseX,pMouseY;
		
	
		bool		gFriction; //mouse toggled
};

#endif	

