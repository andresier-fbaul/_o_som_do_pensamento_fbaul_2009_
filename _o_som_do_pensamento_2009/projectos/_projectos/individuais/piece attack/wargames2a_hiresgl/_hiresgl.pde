/*

 _hiresgl
 
 tab to save a hires opengl image
 
 main funcs
 
 updateFull() replace all your update funcs
 drawFull() only drawing funcs
 draw_hires draws full hires
 
 
 
 
 
 */



void updateFull(){

  updateCameraPos();

  for(int i=0; i<air.size();i++){
    airborn a = (airborn) air.get(i);
    a.fly(); 
    //    a.justdraw();
    if(!a.active){
      int num = (int) random(10,100);
      explosoes.bang(a.fim, num);
      dstx = 0.3*dstx + a.fim.x*0.7;
      dsty = 0.3*dsty + a.fim.y*0.7;

      incendios.gas(a.cfim);     
      a.cfim.hitcount++;
      air.remove(i);
      i--;
      wx.citynum = wx.citytarget; 

      if(wair==i) ///dri: z<<
        wair = (int) random(air.size());

    }
  }

  wx.justupdate();
  explosoes.justupdate();
  incendios.justupdate();
  atmos.justupdate();



}


void justDrawFull(){
  gl = pgl.beginGL();
  gl.setSwapInterval(1); // vsync
  gl.glClearColor(0.f,0.f,0.f,0.1f);
  //  gl.glClear(  GL.GL_DEPTH_BUFFER_BIT);
  gl.glClear(  GL.GL_DEPTH_BUFFER_BIT  |    GL.GL_COLOR_BUFFER_BIT);

  gl.glDepthMask(false);
  //  camera(cx,cy,cz,cx-cdx*0.25,cy+cdy*0.25,-500,0,1,0);
  float w0 = -width/2;//random(width) + cx;
  float w1 = width/2;//width-w0 + cx;
  float h0 = -height/2;//0;//random(height) + cy;
  float h1 = height/2;//height-h0 + cy;

  //  gl.glFrustum(-width/2 +cx , -width/2+100 +cx, -height/2  , -height/2+100 , 500.01,-500);///cameraZ, 10000);//1000);  
  glu.gluLookAt(cx,cy,cz,cx-cdx*0.25,cy+cdy*0.25,-500,0,1,0);
  //gl.glFrustum(w0,w1,h0,h1 , random(-100), 500);//500.01,-500);///cameraZ, 10000);//1000);  
  //  frustum(w0,w1,h0,h1 , random(-100), 500);//500.01,-500);///cameraZ, 10000);//1000);  
  frustum(w0,w1,h0,h1 , 1000, 0);//500.01,-500);///cameraZ, 10000);//1000);  
  //  glu.gluLookAt(cx,cy,cz,cx-cdx*0.25,cy+cdy*0.25,-500,0,1,0);
  //  gl.glFrustum(-width/2 , width/2 , -height/2  , height/2 , 1000.01,-10000);///cameraZ, 10000);//1000);  

  gl.glDisable( GL.GL_DEPTH_TEST ) ;  //
  gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE_MINUS_SRC_ALPHA);
  gl.glEnable( GL.GL_BLEND ) ;

  float qdx = 2000.0f;
  float qdy = 1000.0f;
  gl.glColor4f(0.0,0.0,0.0, 0.37f);//0.43f);//0.27);//0.52f);
  gl.glBegin(GL.GL_QUADS);
  gl.glVertex3f(cx - qdx, cy - qdy , cz - 10.0f );  
  gl.glVertex3f(cx + qdx, cy - qdy , cz - 10.0f );  
  gl.glVertex3f(cx + qdx, cy + qdy , cz - 10.0f );  
  gl.glVertex3f(cx - qdx, cy + qdy , cz - 10.0f );  
  gl.glEnd();

  gl.glPushAttrib(GL.GL_COLOR_BUFFER_BIT | GL.GL_ENABLE_BIT);
  gl.glHint(GL.GL_LINE_SMOOTH_HINT, GL.GL_NICEST);
  gl.glEnable(GL.GL_LINE_SMOOTH);

  gl.glEnable( GL.GL_BLEND ) ;
  gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE); 
  //  lights();
  tex[0].bind();   
  tex[0].enable();   
  ////
  int divx = 4;
  int divy = 1;
  float dimx = 7500;
  float dimy = 3750;//2812;
  float zpos = -500;
  gl.glColor4f( 1.0f, 1.0f, 1.0f,0.75f);//0.91f);//1.0f);///0.71f);  
  gl.glBegin(GL.GL_QUAD_STRIP);  
  gl.glNormal3f( 0.0f, 0.0f, 1.0f); 

  for(int j=0; j<divy; j++){
    for(int i=0; i<divx; i++){
      float xx = ((float) i / (float) (divx-1) );//* 2.0) ;//% 1.0f;
      float y0 = (float) j / (float) (divy);
      float y1 = (float) (j+1) / (float) (divy);
      float tu = xx > 1.0f ? xx-1.0 : xx;

      gl.glNormal3f( 0.0f, 0.0f, 1.0f); 
      gl.glTexCoord2f(tu, y0);    
      gl.glVertex3f(xx*dimx, y0*dimy, zpos );  
      gl.glNormal3f( 0.0f, 0.0f, 1.0f); 
      gl.glTexCoord2f(tu, y1);    
      gl.glVertex3f(xx*dimx, y1*dimy, zpos);  
    }
  }  
  gl.glEnd();   
  tex[0].disable(); 

  wx.justdraw();
  for(int i=0; i<air.size();i++){
    airborn a = (airborn) air.get(i);
    a.justdraw();
  }

  explosoes.justdraw();
  incendios.justdraw();

  float tal = 0.01f + (cos(frameCount*0.027)*0.25 + 0.25);
  float tal1 = tal + random(-0.02, 0.02);

  int txtx =-50;//-90;//-400;
  int txty = 221;//210;// +250;//-100; 
  gl.glColor4f(1f,1f,1f,tal);//0.01f);
  gl.glRasterPos3i(int(5+cx+txtx),int(10+cy+txty), int(cz-500));
  glut.glutBitmapString(glut.BITMAP_HELVETICA_12, "W A R G A M E S  http://pieceattack.tk ");//+cx+" "+cy+" "+cz);
  gl.glRasterPos3i(int(6+cx+txtx),int(11+cy+txty), int(cz-500));
  gl.glColor4f(0f,0f,1.0f,tal1);//0.1f);
  glut.glutBitmapString(glut.BITMAP_HELVETICA_12, "W A R G A M E S  http://pieceattack.tk ");//+cx+" "+cy+" "+cz);

  atmos.justdraw();

  pgl.endGL();
  gl.glFlush();

  if(RECORDING){   
    saveFrame("wargames-"+frameCount+".png");     
  }
}


void justDrawFullFrustrum(float w0, float w1, float h0, float h1){
  gl = pgl.beginGL();
  gl.setSwapInterval(1); // vsync
  gl.glClearColor(0.f,0.f,0.f,0.1f);
  //  gl.glClear(  GL.GL_DEPTH_BUFFER_BIT);
  gl.glClear(  GL.GL_DEPTH_BUFFER_BIT  |    GL.GL_COLOR_BUFFER_BIT);
  gl.glDepthMask(false);

  //  camera(cx,cy,cz,cx-cdx*0.25,cy+cdy*0.25,-500,0,1,0);
  //  gl.glFrustum(left,right,up,down,near,far);

//  float xx = map (w0,-width/2,width/2, -500,500


  glu.gluLookAt(cx+w0*10,cy+h0*10,cz,cx+w1-cdx*0.25,cy+h0+cdy*0.25,-500,0,1,0);
  frustum(w0,w1,h0,h1 , 15000, -500);//500.01,-500);///cameraZ, 10000);//1000);  


  gl.glDisable( GL.GL_DEPTH_TEST ) ;  //
  gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE_MINUS_SRC_ALPHA);
  gl.glEnable( GL.GL_BLEND ) ;

  float qdx = 2000.0f;
  float qdy = 1000.0f;
  gl.glColor4f(0.0,0.0,0.0, 0.37f);//0.43f);//0.27);//0.52f);
  gl.glBegin(GL.GL_QUADS);
  gl.glVertex3f(cx - qdx, cy - qdy , cz - 10.0f );  
  gl.glVertex3f(cx + qdx, cy - qdy , cz - 10.0f );  
  gl.glVertex3f(cx + qdx, cy + qdy , cz - 10.0f );  
  gl.glVertex3f(cx - qdx, cy + qdy , cz - 10.0f );  
  gl.glEnd();

  gl.glPushAttrib(GL.GL_COLOR_BUFFER_BIT | GL.GL_ENABLE_BIT);
  gl.glHint(GL.GL_LINE_SMOOTH_HINT, GL.GL_NICEST);
  gl.glEnable(GL.GL_LINE_SMOOTH);

  gl.glEnable( GL.GL_BLEND ) ;
  gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE); 

  //  lights();
  tex[0].bind();   
  tex[0].enable();   
  ////
  int divx = 4;
  int divy = 1;
  float dimx = 7500;
  float dimy = 3750;//2812;
  float zpos = -500;
  gl.glColor4f( 1.0f, 1.0f, 1.0f,0.75f);//0.91f);//1.0f);///0.71f);  
  gl.glBegin(GL.GL_QUAD_STRIP);  
  gl.glNormal3f( 0.0f, 0.0f, 1.0f); 
  for(int j=0; j<divy; j++){
    for(int i=0; i<divx; i++){
      float xx = ((float) i / (float) (divx-1) );//* 2.0) ;//% 1.0f;
      float y0 = (float) j / (float) (divy);
      float y1 = (float) (j+1) / (float) (divy);
      float tu = xx > 1.0f ? xx-1.0 : xx;
      gl.glNormal3f( 0.0f, 0.0f, 1.0f); 
      gl.glTexCoord2f(tu, y0);    
      gl.glVertex3f(xx*dimx, y0*dimy, zpos );  
      gl.glNormal3f( 0.0f, 0.0f, 1.0f); 
      gl.glTexCoord2f(tu, y1);    
      gl.glVertex3f(xx*dimx, y1*dimy, zpos);  
    }
  }  
  gl.glEnd();   
  tex[0].disable(); 
  wx.justdraw();
  for(int i=0; i<air.size();i++){
    airborn a = (airborn) air.get(i);
    a.justdraw();
  }
  explosoes.justdraw();
  incendios.justdraw();

  float tal = 0.01f + (cos(frameCount*0.027)*0.25 + 0.25);
  float tal1 = tal + random(-0.02, 0.02);

  int txtx =-50;//-90;//-400;
  int txty = 221;//210;// +250;//-100; 
  gl.glColor4f(1f,1f,1f,tal);//0.01f);
  gl.glRasterPos3i(int(5+cx+txtx),int(10+cy+txty), int(cz-500));
  glut.glutBitmapString(glut.BITMAP_HELVETICA_12, "W A R G A M E S  http://pieceattack.tk ");//+cx+" "+cy+" "+cz);
  gl.glRasterPos3i(int(6+cx+txtx),int(11+cy+txty), int(cz-500));
  gl.glColor4f(0f,0f,1.0f,tal1);//0.1f);
  glut.glutBitmapString(glut.BITMAP_HELVETICA_12, "W A R G A M E S  http://pieceattack.tk ");//+cx+" "+cy+" "+cz);

  atmos.justdraw();

  pgl.endGL();
  gl.glFlush();
}



void updateCameraPos(){

  //  float dx=0,dy=0;
  if(camom==0) {
    //cam mouse
    cdx = mouseX-width/2;
    cdy = mouseY-height/2;
    float d = abs(cdx)+abs(cdy);
    if(d>250){
      float f = 0.01;
      cx = (1.0f-f)*cx + f*(cx+cdx);
      cy = (1.0f-f)*cy + f*(cy+cdy);
    }

    float Zf = 1.5f;
    if(mousePressed){
      if(mouseButton==LEFT)
        cz+=Zf;//0.1;
      else
        cz-=Zf;//0.1; 
    }
  }

  if(camom==1){

    if(wair < air.size()){
      airborn ab = (airborn) air.get(wair);
      dstx = ab.now.x;
      dsty = ab.now.y;
    }
    float f = 0.01;
    cx = (1.0f-f)*cx + f*(dstx);
    cy = (1.0f-f)*cy + f*(dsty);   
    float Zf = 1.5f;
    if(mousePressed){
      if(mouseButton==LEFT)
        cz+=Zf;
      else
        cz-=Zf; 
    }

  }

  // cam bounds
  float zpct = map(cz,wmin20.z,wmax1000.z,0.,1.);
  boolean side = zpct > 0.5 ? true : false;
  PVector bmin = interp(wmin20,wmin1000,zpct);
  PVector bmax = interp(wmax20,wmax1000,zpct);

  if(cx <= bmin.x)   cx = bmin.x; 
  if(cy <= bmin.y)   cy = bmin.y; 
  if(cz <= bmin.z)   cz = bmin.z; 
  if(cx >= bmax.x)   cx = bmax.x; 
  if(cy >= bmax.y)   cy = bmax.y; 
  if(cz >= bmax.z)   cz = bmax.z; 

}





// hires gl

float             FOV = 60; // Set the initial field of view  
float             cameraZ; 
boolean           HIRESSAVE=false; 
int               NUM_TILES = 3;//12;//3;//12 //memory!! 
int              HIRESfilecount = 0;
String           HIRESfilebase = "hires-";
String           HIRESfilename = HIRESfilebase+HIRESfilecount+".tga";
boolean          hiresinited=false;

void init_hires(){
  cameraZ = (height/2.0) / tan(PI * FOV / 360.0);
  hiresinited  = true;
}


void draw_hires(){  
  if(!hiresinited) init_hires();

  //  int x=0,y=0; 
  //  float left,right,bottom,top; 

  //  background(0); 
  //  camera(width/2.0, height/2.0, cameraZ, width/2.0, height/2.0, 0, 0, 1, 0);  

  //  frustum(-width/2, width/2, -height/2, height/2, cameraZ, 10000);//1000);  
  //  renderScreen(); 
  updateFull();
  justDrawFull();

  if(HIRESSAVE) { 
    loadPixels(); 
    HIRESSAVE=false; 
    saveHIRES(HIRESfilename);       // save
    HIRESfilecount += random(1,10);
    HIRESfilename = HIRESfilebase+HIRESfilecount+".tga";
  } 


}



void saveHIRES(String s) { 

  int x=0,y=0,index=0; 
  float left,right,bottom,top; 

  PImage img = new PImage(width*NUM_TILES,height*NUM_TILES,RGB);  

  for (y = 0; y < NUM_TILES;y++) { 
    for (x = 0; x < NUM_TILES;x++) { 

      println("_hiresgl: saving "+x+"-" + y+"..."); 

      left = (float)(-width/2) + (float)x*width/NUM_TILES; 
      right = (float)(-width/2) + (float)((x+1)*width)/NUM_TILES; 
      bottom = (float)(-height/2) + (float)(y*height)/NUM_TILES; 
      top = (float)(-height/2) + (float)((y+1)*height)/NUM_TILES; 

      //     background(0); 

      //     camera(width/2.0, height/2.0, cameraZ, width/2.0, height/2.0, 0, 0, 1, 0);    


      //      frustum(left, right, bottom, top, cameraZ, 1000); 

      // Call the rendering function 
      //renderScreen(); 
      //justDrawFull();
      justDrawFullFrustrum(left,right,bottom,top);//,  1000, -10000 );

      loadPixels(); 



      // After rendering each tile,   
      // we read the framebuffer contents into our bitmap. 

      for (int i=0; i < height;i++) { 
        //Shift to the correct scanline 
        index = (((y)*height)*(width*NUM_TILES) + (width*x) + i*(width*NUM_TILES)); 
        // Read a line from the framebuffer 
        for(int j=0; j < width;j++) { 
          img.pixels[index+j] = pixels[i*height+j]; 
        } 
      } 

    } 
  } 

  img.save("/Users/a/Desktop/"+s); 
  //  img.save("/home/grimus/processing/test.tga"); 
  //  img.save("/Users/a/Desktop/test.tga"); 
  //  img.save("/Users/a/Desktop/test.png"); 
  //  img.save( savePath()+"test.tif"); 
  // savePath()
}






