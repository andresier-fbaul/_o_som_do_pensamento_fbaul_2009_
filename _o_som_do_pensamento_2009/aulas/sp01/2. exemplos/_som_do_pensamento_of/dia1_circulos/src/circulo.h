#ifndef CIRCULO_H
#define CIRCULO_H

#include "ofMain.h"


class Circulo {

	public:
	
		float rad;
		float posx, posy;
			
		Circulo();	
        void draw();	
		void reset();
	

};

#endif // CIRCULO_H
