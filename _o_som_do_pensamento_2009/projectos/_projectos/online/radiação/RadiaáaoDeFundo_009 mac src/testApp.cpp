#include "testApp.h"
#include "stdio.h"

//--------------------------------------------------------------
testApp::testApp(){

}

//--------------------------------------------------------------
void testApp::setup(){

    joyx = 0;//joystic
	joyy = 0;
	joyz = 0;
	joynumbuttons = 12;
    joybuttons = new bool[joynumbuttons];
	for(int i=0;i<joynumbuttons;i++){
		joybuttons[i] = false;
	}

recording = false;


     grelhax = 25;
     grelhay = 25;
     grelhaz = 50;
     objcount = grelhax*grelhay*grelhaz;

     obj = new Objecto[objcount];

int w = 0;
  for(int i = 0; i < grelhax; i++) {
    for(int j = 0; j < grelhay; j++) {
      for(int k = 0; k < grelhaz; k++) {


        float x = ofMap (i , 0, grelhax-1, -6250,6250 );
        float y = ofMap (j , 0, grelhay-1, -6200,6250);
        float z = ofMap (k , 0, grelhaz, 0,ZMAX);//-8000);












 //       float inverso;
        float cor = CLAMP( ofMap (z , ZMAX , 0 , 0, 255)  , 0 , 255)    ;// (z/255)+255;

        float green = CLAMP( ofMap (z , ZMAX , 0 , 0, 350)  , 0, 350);

        float red = CLAMP( ofMap (z , ZMAX , 0 , 0, 300)  , 0 , 300) ;

        float blue;

        obj[w].init(x,y,z,cor,red, green, blue);// = new Objecto(x,y,z,rad,cor);
        //println("obj "+x+" "+y+" "+z+" "+rad+" "+cor);
        w++;


      }
    }
  }

 // println(w);



}

//--------------------------------------------------------------
void testApp::update(){

    long double s = 50.000000000f;//ofMap(mouseX,0,ofGetWidth(),0.,1000.0f);

        if (joybuttons[0]==true){

        s=0;
	}

    if (joybuttons[2]==true){

        s=100;
	}

  for(int i = 0; i < objcount ; i++) {

      obj[i].update(s);
    }









}

//----------------------------------------------billboarding
//
//void testApp::billboardSphericalBegin(float camX, float camY, float camZ,float objPosX, float objPosY, float objPosZ) {
//
//	float lookAt[3],objToCamProj[3],upAux[3];
//	float modelview[16],angleCosine;
//
//	glPushMatrix();
//
//// objToCamProj is the vector in world coordinates from the
//// local origin to the camera projected in the XZ plane
//	objToCamProj[0] = camX - objPosX ;
//	objToCamProj[1] = 0;
//	objToCamProj[2] = camZ - objPosZ ;
//
//// This is the original lookAt vector for the object
//// in world coordinates
//	lookAt[0] = 0;
//	lookAt[1] = 0;
//	lookAt[2] = 1;
//
//
//// normalize both vectors to get the cosine directly afterwards
//	mathsNormalize(objToCamProj);
//
//// easy fix to determine wether the angle is negative or positive
//// for positive angles upAux will be a vector pointing in the
//// positive y direction, otherwise upAux will point downwards
//// effectively reversing the rotation.
//
//	mathsCrossProduct(upAux,lookAt,objToCamProj);
//
//// compute the angle
//	angleCosine = mathsInnerProduct(lookAt,objToCamProj);
//
//// perform the rotation. The if statement is used for stability reasons
//// if the lookAt and objToCamProj vectors are too close together then
//// |angleCosine| could be bigger than 1 due to lack of precision
//   if ((angleCosine < 0.99990) && (angleCosine > -0.9999))
//      glRotatef(acos(angleCosine)*180/3.14,upAux[0], upAux[1], upAux[2]);
//
//// so far it is just like the cylindrical billboard. The code for the
//// second rotation comes now
//// The second part tilts the object so that it faces the camera
//
//// objToCam is the vector in world coordinates from
//// the local origin to the camera
//	objToCam[0] = camX - objPosX;
//	objToCam[1] = camY - objPosY;
//	objToCam[2] = camZ - objPosZ;
//
//// Normalize to get the cosine afterwards
//	mathsNormalize(objToCam);
//
//// Compute the angle between objToCamProj and objToCam,
////i.e. compute the required angle for the lookup vector
//
//	angleCosine = mathsInnerProduct(objToCamProj,objToCam);
//
//
//// Tilt the object. The test is done to prevent instability
//// when objToCam and objToCamProj have a very small
//// angle between them
//
//	if ((angleCosine < 0.99990) && (angleCosine > -0.9999))
//		if (objToCam[1] < 0)
//			glRotatef(acos(angleCosine)*180/3.14,1,0,0);
//		else
//			glRotatef(acos(angleCosine)*180/3.14,-1,0,0);
//
//}



//----------------------------------------------------------------------------------
void testApp::button(){


update();
}
//--------------------------------------------------------------
void testApp::draw(){


//mesmonofim   para gravar imagems


//codigo dos botoes



    if (joybuttons[1]==true){

        camz+=500;
	}

float trasfrante = 0;
	if(andartras)
		trasfrante = 400;
	if(andarfrente)
		trasfrante = -400;
camz=camz+trasfrante;

    if (joybuttons[3]==true){

        camz-=500;
	}

    if (camz>20000){

        camz=20000;
	}

    if (camz<-40000){

        camz=-40000;
	}


//----------------------------------------------------

        //low pass filter x
//        float lowfilter = 0.1;
//        float highfilter = 1;
//        float desiredCamx = ofMap(joyx,-1000,1000,-20000,20000);
//        float f = desiredCamx > -7500 & desiredCamx < 7500 ? lowfilter : highfilter;//0.15;
//        camx=f*desiredCamx + (1.f-f)*camx;
//-------------------------------------------------------------



//------------------------------------------------------------------

	float camxx = ofMap(joyx,-1000,1000,-100,100);

	if(camxx<0)
		camxx=-(camxx*camxx*camxx*camxx);
	else
		camxx=(camxx*camxx*camxx*camxx);


	camx=camx+ofMap(camxx,-100000000,100000000,-400,400);

//------------------------código andré----------------------
	float xaxis = 0;
	if(esquerda)
		xaxis = -200;
	if(direita)
		xaxis =  200;
camx=camx+xaxis;

			float yaxis = 0;
	if(cima)
		yaxis = 200;
	if(baixo)
		yaxis = -200;

	camy=camy+yaxis;//ofMap(camxx,-100000000,100000000,-400,400);
//------------------------------------------------------------------------




//	camx=camx+ofMap(joyx,-1000,1000,-389,389);



        if (camx<-20000)
        camx=-20000;

	    if (camx>20000)
        camx=20000;

//----------------------------------------------------------

        //low pass filter y
//        float desiredCamy = ofMap(joyy,1000,-1000,-20000,20000);//este é o meu       //este é o teu ofMap(joyy,-255,255,-100,100);
//        float g = desiredCamy > -7500 & desiredCamy < 7500 ? lowfilter : highfilter;
//        camy=g*desiredCamy + (1.f-g)*camy;
//-------------------------------------------------------

//-------------------------------------------------------
	float camyy = ofMap(joyy,255,0,-100,100);

	if(camyy<0)
		camyy=-(camyy*camyy*camyy*camyy);
	else
		camyy=(camyy*camyy*camyy*camyy);


	camy=camy+ofMap(camyy,-100000000,100000000,-389,389);
//-------------------------------------------------------------------






//		camy = camy + ofMap (joyy,255,0,-400,400);



	    if (camy>20000)
        camy=20000;

		if (camy<-20000)
        camy=-20000;




    ofBackground(0,0,0);

    //camera
    float fov = 60.f;//120.f;//90.f;
	float w = ofGetWidth();
	float h = ofGetHeight();
	float ratio = w/h;
	float z = 1.0f;
	float Z = 10000000.0f;//50000.0f;//20000.0f;

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(fov, ratio, z, Z);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
//	gluLookAt(0.f, 0.f, 100.f,		0.f, 0.f ,0.f,		0.,1.,0.);

     float x = ofMap(mouseX,0,ofGetWidth(), -10000,10000);
    float y = ofMap(mouseY,0,ofGetHeight(), -10000,10000);

    gluLookAt( camx , camy , camz , camx+ofMap(joyz,-255,255,-250,250) , camy , camz-1000 , 0 , 0.5 , 0 );















   // glDisable(GL_DEPTH_TEST);
    glEnable(GL_DEPTH_TEST);
//    glEnable(GL_BLEND);
//      glBlendFunc(GL_SRC_ALPHA,GL_ONE);

      for(int i = 0; i < objcount ; i++) {

      obj[i].draw();
    }

////billboarding
//// restores the modelview matrix
//glPopMatrix();


       if(recording){

               ofImage frame;
               frame.grabScreen(0,0,ofGetWidth(), ofGetHeight());
               string fileName = "rADIACAO-" + ofToString(ofGetDay()) +"-"+
               ofToString(ofGetDay())  +"-"+
               ofToString(ofGetHours())  +"-"+
               ofToString(ofGetMinutes())  +"-"+
               ofToString(ofGetFrameNum()) + ".png";

               frame.saveImage(fileName);
               recording=false;
       }

            //para gravar imagems
}
//--------------------------------------------------------------
void testApp::joystick(unsigned int buttonMask, int x, int y, int z) {

	// retrieve each button by masking the int with powers of two
	for(int i=0;i<joynumbuttons;i++){
		joybuttons[i] =  (buttonMask & (1<<i));
	}

	joyx = x;
	joyy = y;
	joyz = z;

}
//--------------------------------------------------------------
void testApp::keyPressed  (int key){

	printf("key is %c with %ld", (char)key,key);

	// no meu mac o cursor tem os codigos 356 esquerda atŽ 359 baixo
	if(key==356)
		esquerda = true;
	if(key==357)
		cima = true;
	if(key==358)
		direita = true;
	if(key==359)
		baixo = true;

	//botoes
	if(key=='x')
		olharesq = true;
	if(key=='c')
		olhardir = true;
	if(key=='z')
		andartras = true;
	if(key=='a')
		andarfrente = true;



 if(key=='s'){
        recording^=true;
       }
}

//--------------------------------------------------------------
void testApp::keyReleased(int key){
	// no meu mac o cursor tem os codigos 356 esquerda atŽ 359 baixo
	if(key==356)
		esquerda = false;
	if(key==357)
		cima = false;
	if(key==358)
		direita = false;
	if(key==359)
		baixo = false;

	//botoes
	if(key=='x')
		olharesq = false;
	if(key=='c')
		olhardir = false;
	if(key=='z')
		andartras = false;
	if(key=='a')
		andarfrente = false;

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

