

class WorldGrid {
  int  gx,gy,gz; 
  int  num; 
  v3   rdmin,rdmax,rcenter,rdim,rrdim,rdimstride,playergridpos;
  Cell cells[];
  boolean playergridchange=false;
  PImage img;

  WorldGrid(int _x, int _y, int _z){
    gx = _x;
    gy = _y;
    gz = _z;
    num = gz*gy*gx;
    rdmin = new v3( -52000f, -12000f, -55500f);
    rdmax = new v3(  52000f,  12000f,  -2000f);
    rdim = new v3((rdmax.x-rdmin.x),(rdmax.y-rdmin.y),(rdmax.z-rdmin.z)); 
    rrdim = new v3(1f/rdim.x,1f/rdim.y,1f/rdim.z); 
    rdimstride = new v3(rdim); 
    rdimstride.div(new v3((float)gx,(float)gy,(float)gz));
    rcenter = new v3 ( (rdim.x*0.5), (rdim.y*0.5), 0f);//(rdim.z*0.5) );
    playergridpos = new v3();
    img = loadImage("glow1664a.png");
    println("wgrid num "+num);
    cells = new Cell[num];
    for(int i=0;i<num;i++){
      v3 p = new v3();
      p.x = ( i % gx ) * rdimstride.x + rdmin.x;
      p.y = (( i / gy ) % gx) * rdimstride.y + rdmin.y;
      p.z = ( i / (gx*gy) ) * rdimstride.z + rdmin.z;
 //     println("cell pos "+p.x+" "+p.y+" "+p.z);        
      cells[i] = new Cell( p );
    }

  }

  void render(v3 ppos){     

    gl.glEnable(GL.GL_BLEND);
    gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE_MINUS_SRC_ALPHA);
    gl.glBlendFunc(GL.GL_ONE_MINUS_SRC_ALPHA,GL.GL_SRC_ALPHA);
    gl.glDisable(GL.GL_DEPTH_TEST);

    check_player();
    
    gl.glPushMatrix(); 
    gl.glTranslatef(player.w*2,player.h,0);
    noStroke();
    for(int i=0;i<num;i++) cells[i].draw(img); 
    stroke(255,2);
    gl.glColor4f(1f,1f,1f,0.01f);
    if(draw_lines)
      for(int i=0;i<gx-1;i++)
      for(int j=0;j<gy-1;j++)
      for(int k=0;k<gz-1;k++){
       int id =  i + j*gx + k*gy*gx;
       int id1 =  i+1 + j*gx + k*gy*gx;
       int id2 =  i + (j+1)*gx + k*gy*gx;
       int id3 =  i + j*gx + (k+1)*gy*gx;
       
//       gl.glBegin(GL.GL_LINES);
//       gl.glVertex3f(cells[id].pos.x,cells[id].pos.y,cells[id].pos.z);       
//       gl.glVertex3f(cells[id1].pos.x,cells[id1].pos.y,cells[id1].pos.z);       
//      gl.glVertex3f(cells[id].pos.x,cells[id].pos.y,cells[id].pos.z);       
//       gl.glVertex3f(cells[id2].pos.x,cells[id2].pos.y,cells[id2].pos.z);       
//      gl.glVertex3f(cells[id].pos.x,cells[id].pos.y,cells[id].pos.z);       
//       gl.glVertex3f(cells[id3].pos.x,cells[id3].pos.y,cells[id3].pos.z);       
//      gl.glEnd();

       line (cells[id].pos.x,cells[id].pos.y,cells[id].pos.z,
             cells[id1].pos.x,cells[id1].pos.y,cells[id1].pos.z);
       line (cells[id].pos.x,cells[id].pos.y,cells[id].pos.z,
             cells[id2].pos.x,cells[id2].pos.y,cells[id2].pos.z);
       line (cells[id].pos.x,cells[id].pos.y,cells[id].pos.z,
             cells[id3].pos.x,cells[id3].pos.y,cells[id3].pos.z);
        
      }


    gl.glPopMatrix();


  }
  void check_player(){
    v3  ppos = new v3(player.pos);
    int gridposx = (int) floor( ppos.x / rdimstride.x  );
    int gridposy = (int) floor( ppos.y / rdimstride.y  );
    int gridposz = (int) ceil( ppos.z / rdimstride.z  ) + 1;

    if(  gridposx!=(int)playergridpos.x || gridposy!=(int)playergridpos.y || gridposz!=(int)playergridpos.z )
      for(int i=0; i < num; i++) {
        v3 p = new v3();
        p.x = ( i % gx ) * rdimstride.x + rdmin.x + gridposx *rdimstride.x ;
        p.y = (( i / gy ) % gx) * rdimstride.y + rdmin.y + gridposy *rdimstride.y;
        p.z = ( i / (gx*gy) ) * rdimstride.z + rdmin.z + gridposz *rdimstride.z;
  //      println("new cell pos "+p.x+" "+p.y+" "+p.z);        
        cells[i] = new Cell( p );

      }

    playergridpos.set (  (float)gridposx, (float)gridposy, (float)gridposz  );



  }
}

class Cell{
  v3 pos,dim,gridpos;
  float al,alinc,aldir;
  float mn,mx;
  Cell(v3 _p){
    pos = new v3(_p);
    dim = new v3(160,90,0);
    al = 100.1f;
    alinc = random(0.01,5);
    aldir = 1f;
  }
  void draw(PImage img){
    al+=alinc*aldir;
    if(al<10f||al>255)
      aldir*=-1;

    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    tint(255,al);
    beginShape();
    texture(img);
    vertex(-dim.x,-dim.y,0., 0, 0);
    vertex(dim.x,-dim.y,0., img.width,0);
    vertex(dim.x,dim.y,0., img.width,img.height);
    vertex(-dim.x,dim.y,0.,0,img.height);
    endShape();
    popMatrix();

  }

}


