class WorkBrowser{
  
  PImage bgimage;
  
  
 WorkBrowser(int [] works){
   
//   bgimage = loadImage("fullsompensamentobackground1024512.jpg");
   bgimage = loadImage("sompensamento1024.jpg");
  // sompensamento1024.jpg
 }
 
 void render(){
   image(bgimage,0,0,width,height);
 }
  
}
