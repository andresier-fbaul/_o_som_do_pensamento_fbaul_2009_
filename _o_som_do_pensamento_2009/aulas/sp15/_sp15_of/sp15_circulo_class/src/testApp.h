#ifndef _TEST_APP
#define _TEST_APP

#include "ofMain.h"
#include "circulo.h"

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

		// apenas 1 circulo no ecran
		Circulo circulo;
	
		//comportamento do rato
		bool    followmouse;
		int mouseX, mouseY;
	
		void go_mouse();
};

#endif

