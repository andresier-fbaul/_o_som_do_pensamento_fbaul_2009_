

class Fire{
 
 float px,py;
 float angle;
 int life=100;//255;
 int diameter=10;
 int player = -1;

 Fire( float x, float y, float a, int p) {
   px = x; py = y; angle = a;///7a = angle; 
   player = p;
 }
 
 void go(){

  int colide = checkcollision();
  
  if(colide == -1)  
    life--; 
  else {
     PLAYER[colide].life -= life;
     life -= life;// 
  }
    
  
    px += 2*cos(angle);
    py += 2*sin(angle);    
 }
 
 
 int checkcollision(){
      
   /// cheap check foes
     for(int i = 0; i < foelist.size(); i++) {
         Foe f = (Foe) foelist.get(i);               
         float dx = f.px - px; float dy = f.py - py; // vector
         float dlen = abs(dx)+abs(dy); 
         if(dlen<20) {
          // eliminate fire & foe
          life = 0;
          f.life = 0; 
          PLAYER[player].score++;
         }

     }
   
   
   int result = -1;
   
   for(int i = 0; i < PLAYER.length; i++) {
     
     float sumrad = PLAYER[i].diameter/2 + diameter/2;
     float dx = PLAYER[i].px - px; float dy = PLAYER[i].py - py; // vector
     float dlen = abs(dx)+abs(dy); 
     if (dlen < sumrad + 2) { // contact
       return i;
     }
     
   }
 
   return result;
   
 }
 
 
 
 void render(){
  
  fill(250,100,0,life); 
  ellipse(px,py,diameter,diameter); 
 }
  
  
}
