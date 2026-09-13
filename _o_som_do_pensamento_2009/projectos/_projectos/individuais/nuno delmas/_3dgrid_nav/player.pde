


class Player{

  v3 pos,look,up;
  v3 dir, mouse,screencenter;
  float mousez;

  float fov = 90.f;
  float w,h;
  float ratio;// = w/h;
  float z = 1.0f;
  float Z = 100000.0f;///Z_MAX;//50000.0f;//20000.0f;

  float fogstart=0.1;
  float fogend=0.7;
  float[] fogdensity={ 
    10.5e-7   };
  float[] fogcolor = {
    1.,1.,1.1,1.00  };

  Player(){
    pos = new v3 (0,0,-1000);
    look = new v3(pos);
    look.add(0,0,-1000);
    up = new v3(0,1,0);
    dir = new v3();
    mouse = new v3();
    w = (float)width;
    h = (float)height;
    ratio = w/h;
    screencenter = new v3(w/2f,h/2f,0f);
  }

  void run(){
    update();
    camera_go(); 
  }

  void update(){
    mouse.x = mouseX; 
    mouse.y = mouseY; 

    if (mousePressed) {
      mousez = (mouseButton==LEFT?(mouse.z-5):(mouse.z+5)) ;
    } 
    else if(!mousePressed) {
      if (mousez > 0)
        mousez--;
      else if (mousez < 0 )
        mousez++;
    }

      pos.z += mousez * 10.1f;


    v3 d = new v3();
    if( mouse.lento( screencenter, d   ) > 50) {
      d.mult(0.52); 
      pos.add(d);
//       println("d "+d.x+" "+d.y+" "+d.z);        
//      println("pos "+pos.x+" "+pos.y+" "+pos.z);        
//      println("look "+look.x+" "+look.y+" "+look.z);        
    }

     v3 ltgt = new v3(pos); 
      ltgt.add(0,0,-10000f);
      look.ease(ltgt,0.05);



  }
  void camera_go(){
    
    gl.glMatrixMode(GL.GL_PROJECTION);
    gl.glLoadIdentity();
    glu.gluPerspective(fov, ratio, z, Z);
    gl.glMatrixMode(GL.GL_MODELVIEW);
    gl.glLoadIdentity();
    gl.glScalef( 1, -1, 1); 
    glu.gluLookAt(pos.x,pos.y,pos.z, look.x,look.y,look.z,up.x,up.y,up.z);
    // fog
    gl.glEnable (GL.GL_FOG);
    gl.glFogi (GL.GL_FOG_MODE, GL.GL_EXP);//LINEAR);//GL.GL_EXP//GL.GL_EXP2);
    gl.glFogfv (GL.GL_FOG_COLOR, FloatBuffer.wrap(fogcolor)); 
    gl.glFogfv (GL.GL_FOG_DENSITY, FloatBuffer.wrap(fogdensity));//FloatBuffer.wrap(density));  
    gl.glHint (GL.GL_FOG_HINT,GL.GL_FASTEST);//GL_FASTEST //GL_DONT_CARE
    gl.glFogf (GL.GL_FOG_START, fogstart);//12000);//90);
    gl.glFogf (GL.GL_FOG_END, fogend);//27000);//700);   


  }


}


