#ifndef PARTICLE_H
#define PARTICLE_H

#include "ofMain.h"
#include "ofxVectorMath.h"

class particle
{
    public:
        ofxVec3f pos;
        ofxVec3f vel;
        ofxVec3f frc;   // frc is also know as acceleration (newton says "f=ma")
			
        particle();
		virtual ~particle(){};

        void resetForce();
        void addForce(float x, float y);
        void addDampingForce();
        void setInitialCondition(float px, float py, float vx, float vy);
		void setInitialCondition(float px, float py, float pz, float vx, float vy, float vz);
        void update();
        void draw();
	
		float damping;

    protected:
    private:
};

#endif // PARTICLE_H
