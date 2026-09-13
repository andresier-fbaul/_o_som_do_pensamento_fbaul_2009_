/// desenhar, pt 1


int NumPts = 20;//5000;
int head = 0;
int Ptx[], Pty[];



void setup(){
  size ( 700, 300 );   
  frameRate(30);
  Ptx = new int[NumPts];
  Pty = new int[NumPts];
  for(int i=0; i < NumPts; i++) {
    Ptx[i] = width/2;
    Pty[i] = height/2;
  }  
}


void draw(){
  background (100);
  for(int i=0; i < NumPts-2; i++) {
    line(Ptx[i],Pty[i] , Ptx[i+1],Pty[i+1] );
//    line(Ptx[i-1],Pty[i-1] , Ptx[i],Pty[i] );
  }
}


void doMouse(){
 Ptx[head] = mouseX;
 Pty[head] = mouseY;
 head = (head + 1) % NumPts;
}

void mousePressed(){
  doMouse();
}

void mouseDragged(){
  doMouse();
}

