#ifndef _TEST_APP
#define _TEST_APP


#include "ofMain.h"
#include "Part.h"


class testApp : public ofSimpleApp{
	
	public:
		
		void setup();
		void update();
		void draw();
		
		void keyPressed(int key);
		void keyReleased(int key);
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased();
		
	
		Part	*p;		// um pointer para part’culas
		int		num_p;	// o nœmero de part’culas
		
		void spawn(float x, float y);
		void init_n_parts(int num);
};	
#endif
	
