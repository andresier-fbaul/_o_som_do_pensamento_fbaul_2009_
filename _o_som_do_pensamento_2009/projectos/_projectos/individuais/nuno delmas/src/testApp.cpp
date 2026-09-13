#include "testApp.h"
#include "stdio.h"

//--------------------------------------------------------------
testApp::testApp(){

}

//--------------------------------------------------------------
void testApp::setup(){

    //obj

 // obj = new Objecto[grelhax*grelhay*grelhaz+1];

    int w = 0;
    int grelhax = 20;
    int grelhay = 20;
    int grelhaz = 20;


  for(int i = 0; i < grelhax; i++) {
    for(int j = 0; j < grelhay; j++) {
      for(int k = 0; k < grelhaz; k++) {


        float x = ofMap (i , 0, grelhax-1, -5000,5000 );
        float y = ofMap (j , 0, grelhay-1, -5000,5000);
        float z = ofMap (k , 0, grelhaz-1, 0,ZMAX);//-8000);
        float rad = 50;
 //       float inverso;
        float cor = CLAMP( ofMap (z , -20000, 0 , 0, 255)  , 0 , 255)    ;// (z/255)+255;

        obj[w].init(x,y,z,rad,cor);// = new Objecto(x,y,z,rad,cor);
        //println("obj "+x+" "+y+" "+z+" "+rad+" "+cor);
        w++;


      }
    }
  }

 // println(w);



}

//--------------------------------------------------------------
void testApp::update(){

    float s = ofMap(mouseX,0,ofGetWidth(),0.,100.0f);

  for(int i = 0; i < 100000 ; i++) {

      obj[i].update(s);
    }
}


//--------------------------------------------------------------
void testApp::draw(){


    ofBackground(0,0,0);

    //camera
    float fov = 60.f;//120.f;//90.f;
	float w = ofGetWidth();
	float h = ofGetHeight();
	float ratio = w/h;
	float z = 1.0f;
	float Z = 100000000.0f;//50000.0f;//20000.0f;

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(fov, ratio, z, Z);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
//	gluLookAt(0.f, 0.f, 100.f,		0.f, 0.f ,0.f,		0.,1.,0.);

     float x = ofMap(mouseX,0,ofGetWidth(), -1000,1000);
    float y = ofMap(mouseY,0,ofGetHeight(), -1000,1000);

    gluLookAt(x,y, 0, x,y, -100, 0, 1, 0);

   // glDisable(GL_DEPTH_TEST);
//    glEnable(GL_DEPTH_TEST);
//    glEnable(GL_BLEND);
//    glBlendFunc(GL_SRC_ALPHA,GL_ONE);

      for(int i = 0; i < 100000 ; i++) {

      obj[i].draw();
    }

}

//--------------------------------------------------------------
void testApp::keyPressed  (int key){

}

//--------------------------------------------------------------
void testApp::keyReleased(int key){

}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::resized(int w, int h){

}

