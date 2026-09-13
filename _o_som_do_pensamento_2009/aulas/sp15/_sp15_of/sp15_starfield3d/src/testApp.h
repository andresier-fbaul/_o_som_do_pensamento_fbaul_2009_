#ifndef _TEST_APP
#define _TEST_APP


#include "ofMain.h"
#include "Star.h"

#define MAX_STARS       2500
#define Z_MAX			55000.0f

class testApp : public ofSimpleApp{	
	public:		
		void setup();
		void update();
		void draw();		
		void keyPressed  (int key);
		void keyReleased (int key);		
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased();

		//
		Star		stars[MAX_STARS];
		float		global_speed;		
		void		camera();
};

#endif
	
