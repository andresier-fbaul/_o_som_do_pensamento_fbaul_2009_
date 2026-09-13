#ifndef _TEST_APP
#define _TEST_APP


#include "ofMain.h"
#include "Objecto.h"
//#include "ofxOpenCv.h"
//#include "ofxDirList.h"
//#include "ofxVectorMath.h"
//#include "ofxNetwork.h"
//#include "ofxOsc.h"
//#include "ofxThread.h"
//#include "ofxXmlSettings.h"
//#include "ofx3DModelLoader.h"



class testApp : public ofBaseApp{

	public:

bool recording;


		testApp();
		void setup();
		void update();
		void draw();

		void keyPressed  (int key);
		void keyReleased(int key);
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased(int x, int y, int button);
		void resized(int w, int h);

        void billboardSphericalBegin(float camX, float camY, float camZ,float objPosX, float objPosY, float objPosZ);//billboarding


        void joystick(unsigned int buttonMask, int x, int y, int z);


        void button();


        int         grelhax;
        int         grelhay;
        int         grelhaz, objcount;
        float       speed;

  		// the joystick data to work in the app
		bool *joybuttons;					//bot›es
		int  joyx,joyy,joyz;				//eixo(s)
		int joynumbuttons,joynumaxes,joypresent; //caracter’sticas

        float camx,camy,camz;

		Objecto     *obj;//obj[1000000];

		// we don't actually use these
        // just checking to see if they
        // all work in the same place :)

//        ofxCvGrayscaleImage cvGray;
//        ofxDirList dirList;
//        ofxVec2f p;
//        ofxTCPClient client;
//        ofxTCPServer server;
//        ofxOscSender osc_sender;
//        ofxThread thread;
//        ofxXmlSettings settings;
//        ofx3DModelLoader modelLoader;

};

#endif
