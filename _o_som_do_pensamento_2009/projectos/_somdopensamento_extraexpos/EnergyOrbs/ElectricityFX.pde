class ElectricityFX {
	
	 void GenerateArc(PApplet stage, int x1, int y1, int x2, int y2, int lineWidth)
	  {
	    ArrayList points = new ArrayList();
	    int cx,cy,ox,oy;
	    float angle;
	    int stepLength;
	    int distanceEnd;
	    
	    // Initialize
	    cx = x1;
	    cy = y1;
	    ox = x1;
	    oy = y1;
	    
	    points.add(new Point2D(x1,y1));
	    
	    while ((ox!=x2)&&(oy!=y2))
	    {
	      distanceEnd = PApplet.round(PApplet.dist(cx,cy,x2,y2));
	      stepLength = PApplet.round(10+stage.random(-5,5));
	      
	      if (distanceEnd < stepLength) // Se j� estiver perto o suficiente do fim
	      {
	        ox = x2;
	        oy = y2;
	      }
	      else // Se ainda estiver longe do fim
	      {
	        // Angulo do ponto actual at� ao ponto final
	        angle = PApplet.atan2(y2-cy, x2-cx);
	        
	        // Alterar ligeiramente o angulo de uma forma aleat�ria
	        angle += stage.random(-1, 1);
	        
	        ox = PApplet.round(cx + PApplet.cos(angle)*stepLength);
	        oy = PApplet.round(cy + PApplet.sin(angle)*stepLength);
	      }
	      // Adicionado novo ponto � cadeia
	      points.add(new Point2D(ox,oy));
	      
	      // Ponto actual passa a ser calculado
	      cx = ox;
	      cy = oy;
	    }
	    
	    stage.noFill();
	    stage.stroke(200,200,255);
	    //stage.strokeJoin(PApplet.ROUND);
	    stage.strokeWeight(2);
	    this.DrawArc(stage,points,true);
	    stage.fill(255);
	    
	    /*stage.stroke(0,168,255,20);
	    stage.strokeJoin(PApplet.ROUND);
	    stage.strokeWeight(25);
	    ElectricityFX.DrawArc(stage,points,false);
	    
	    stage.stroke(0,168,255,50);
	    stage.strokeJoin(PApplet.ROUND);
	    stage.strokeWeight(15);
	    ElectricityFX.DrawArc(stage,points,false);
	    
	    //filter(BLUR,4);
	    

	    /*stroke(210,230,255,255);
	    strokeJoin(ROUND);
	    strokeWeight(1);
	    this.DrawArc(points,true);*/
	    
	  }
	  
	  void DrawArc(PApplet stage, ArrayList points, boolean delete)
	  {
	    Point2D pt;
	    stage.beginShape();
	    if (delete) // Se for para apagar a lista ao mesmo tempo que desenha
	    {
	      while (points.size() != 0)
	      {
	        pt = (Point2D)(points.get(0));
	        stage.vertex(pt.x,pt.y);
	        points.remove(0);
	      }
	    }
	    else
	    {
	      for (int i=0 ; i < points.size() ; i++)
	      {
	        pt = (Point2D)(points.get(i));
	        stage.vertex(pt.x,pt.y);
	      }
	    }
	    stage.endShape();
	    
	  }
	  
	  float Distance(int x1, int y1, int x2, int y2)
	  {
	    return PApplet.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
	  }

}
