
void setup_sketch0(){
  background(0);
  hint(ENABLE_NATIVE_FONTS);
  font2 = createFont("Arial", 18);
  scale_factor2 = height/table_size;
  
  tuioClient2  = new TuioProcessing(this);
}


void draw_sketch0(){
  
  //background(0);
  //fill(random(255),random(255),random(255));
  //ellipse(random(width),random(height),random(500),random(500));
  
  textFont(font2,18*scale_factor2);
  float obj_size2 = object_size2*scale_factor2; 
  float cur_size2 = cursor_size2*scale_factor2; 
   
  Vector tuioObjectList2 = tuioClient2.getTuioObjects();
  for (int i=0;i<tuioObjectList2.size();i++) {
     TuioObject tobj2 = (TuioObject)tuioObjectList2.elementAt(i);
     stroke(0);
     fill(0);
     pushMatrix();
     translate(tobj2.getScreenX(width),tobj2.getScreenY(height));
     rotate(tobj2.getAngle());
     rect(-obj_size2/2,-obj_size2/2,obj_size2,obj_size2);
     popMatrix();
     fill(255);
     text(""+tobj2.getSymbolID(), tobj2.getScreenX(width), tobj2.getScreenY(height));
   }
   
   Vector tuioCursorList2 = tuioClient2.getTuioCursors();
   for (int i=0;i<tuioCursorList2.size();i++) {
      TuioCursor tcur2 = (TuioCursor)tuioCursorList2.elementAt(i);
      Vector pointList2 = tcur2.getPath();
      
      if (pointList2.size()>0) {
         float d;
        d = random(1,100);
        strokeWeight(d*0.9);
        stroke(255,255,255, 50);

        TuioPoint start_point2 = (TuioPoint)pointList2.firstElement();;
        for (int j=0;j<pointList2.size();j++) {
           TuioPoint end_point2 = (TuioPoint)pointList2.elementAt(j);
           line(start_point2.getScreenX(width),start_point2.getScreenY(height),end_point2.getScreenX(width),end_point2.getScreenY(height));
           start_point2 = end_point2;
        }
        
        stroke(255,255,255, 50);
        fill(192,192,192);
        ellipse( tcur2.getScreenX(width), tcur2.getScreenY(height),cur_size2,cur_size2);
        fill(0);
        text(""+ tcur2.getCursorID(),  tcur2.getScreenX(width)-5,  tcur2.getScreenY(height)+5);
      
    }
   }
   
 
}

