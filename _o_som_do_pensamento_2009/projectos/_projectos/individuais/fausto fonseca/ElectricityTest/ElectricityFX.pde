public class ElectricityFX
{
  public ElectricityFX()
  {
  }
  
  public void GenerateArc(int x1, int y1, int x2, int y2)
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
      distanceEnd = round(this.Distance(cx,cy,x2,y2));
      stepLength = round(10+random(-2,2));
      
      println(distanceEnd+" "+stepLength);
      
      if (distanceEnd < stepLength) // Se já estiver perto o suficiente do fim
      {
        ox = x2;
        oy = y2;
      }
      else // Se ainda estiver longe do fim
      {
        // Angulo do ponto actual até ao ponto final
        angle = atan2(y2-cy, x2-cx);
        
        // Alterar ligeiramente o angulo de uma forma aleatória
        angle = angle+random(-1, 1);
        
        ox = round(cx + cos(angle)*stepLength);
        oy = round(cy + sin(angle)*stepLength);
      }
      // Adicionado novo ponto à cadeia
      points.add(new Point2D(ox,oy));
      
      // Ponto actual passa a ser calculado
      cx = ox;
      cy = oy;
    }
    
    
    stroke(0,168,255,10);
    strokeJoin(ROUND);
    strokeWeight(30);
    this.DrawArc(points,false);
    
    stroke(0,168,255,20);
    strokeJoin(ROUND);
    strokeWeight(25);
    this.DrawArc(points,false);
    
    stroke(0,168,255,50);
    strokeJoin(ROUND);
    strokeWeight(15);
    this.DrawArc(points,false);
    
    //filter(BLUR,4);
    
    stroke(210,230,255,255);
    strokeJoin(ROUND);
    strokeWeight(1);
    this.DrawArc(points,true);
    
  }
  
  public void DrawArc(ArrayList points, boolean delete)
  {
    Point2D pt;
    
    beginShape();
    noFill();
    if (delete) // Se for para apagar a lista ao mesmo tempo que desenha
    {
      while (points.size() != 0)
      {
        pt = (Point2D)(points.get(0));
        vertex(pt.x,pt.y);
        points.remove(0);
      }
    }
    else
    {
      for (int i=0 ; i < points.size() ; i++)
      {
        pt = (Point2D)(points.get(i));
        vertex(pt.x,pt.y);
      }
    }
    endShape();
    
  }
  
  public float Distance(int x1, int y1, int x2, int y2)
  {
    return sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
  }
}
