

class v3{
  float x=0,y=0,z=0;
  v3(){ 
  };
  v3(float a, float b, float c)  {
    x=a;
    y=b;
    z=c; 
  };
  v3(v3 p) {
    x = p.x; 
    y=p.y;  
    z=p.z;
  } 
  void set(v3 p) {
    x = p.x; 
    y=p.y;  
    z=p.z;   
  }
  void set(float a, float b, float c)  {
    x=a;
    y=b;
    z=c; 
  };

  void add(float p) { 
    x += p; 
    y+=p;  
    z+=p;   
  }
  void add(float a,float b, float c) { 
    x += a; 
    y+=b;  
    z+=c;   
  }
  void add(v3 p) {
    x += p.x; 
    y+=p.y;  
    z+=p.z;   
  }
  void sub(v3 p) {
    x -= p.x; 
    y-=p.y;  
    z-=p.z;   
  }
  void sub(float a,float b, float c) { 
    x -= a; 
    y-=b;  
    z-=c;   
  }

   void mult(float a, float b, float c) {
    x *= a; 
    y*=b;  
    z*=c;   
  }
 void mult(float a) {
    x *= a; 
    y*=a;  
    z*=a;   
  }
  void mult(v3 a) {
    x *= a.x; 
    y*=a.y;  
    z*=a.z;   
  }
 void div(v3 a) {
    x /= a.x; 
    y/=a.y;  
    z/=a.z;   
  }

  void limit(float a) {
    float len = abs(x)+abs(y)+abs(z);
    if(len > a && len > 0f) {
      len = 1.0f / len;  
      x *= len; 
      y*=len;  
      z*=len;   
      x *= a; 
      y*=a;  
      z*=a;      
    }
  }


  void interp(v3 a, float f) {
    float f1 = 1.0f - f;
    x = x*f1 + a.x*f;
    y = y*f1 + a.y*f; 
    z = z*f1 + a.z*f;   
  }

  v3 interp(v3 a, v3 b, float f) {
    float f1 = 1.0f - f;
    v3 r = new v3();
    r.x = a.x*f1 + b.x*f;
    r.y = a.y*f1 + b.y*f; 
    r.z = a.z*f1 + b.z*f;   
    return r;
  }



  float len() {
    return (abs(x)+abs(y)+abs(z));
  }

  float lento(v3 p) {
    return (abs(p.x-x)+abs(p.y-y)+abs(p.z-z));
  }

 float lento(v3 p, v3 d) {
    d.x = (x-p.x); d.y = y-p.y; d.z = z-p.z;
    return (abs(d.x)+abs(d.y)+abs(d.z));
  }


  void normcity() {
    float a = abs(x)+abs(y)+abs(z);
    if(a>0.){
      a = 1.0/a;
      x *= a; 
      y*=a;  
      z*=a;   
    }
  }

  void zero() {
    x = 0.0f; 
    y=0.0f;  
    z=0.0f;   
  }

  void rnd(float a) {   
    x = random(-a,a); 
    y=random(-a,a);  
    z=random(-a,a);   
  }

  void mutate(float a) {
    x += random(-a,a); 
    y+=random(-a,a);  
    z+=random(-a,a);   
  }





  public v3 xfade (v3 a, v3 b, float amt) {
    float iamt = 1.0-amt;
    v3 v = new v3((iamt*a.x + amt*b.x), (iamt*a.y + amt*b.y), (iamt*a.z + amt*b.z));
    return v;
  }

  public void easexz (v3 b, float amt) {
    //  float iamt = 1.0-amt;
    x += (amt*(b.x -x));
    //   y += (amt*(b.y -y)); 
    z += (amt*(b.z -z));
    //   return v;
  }

  public void ease (v3 b, float amt) {
    //  float iamt = 1.0-amt;
    x += (amt*(b.x -x));
    y += (amt*(b.y -y)); 
    z += (amt*(b.z -z));
    //   return v;
  }

  public v3 cross(v3 a, v3 b) { 
    v3 v = new v3((a.y*b.z - a.z*b.y),(a.z*b.x - a.x*b.z),(a.x*b.y - a.y*b.x));
    return v;
  } 



}




