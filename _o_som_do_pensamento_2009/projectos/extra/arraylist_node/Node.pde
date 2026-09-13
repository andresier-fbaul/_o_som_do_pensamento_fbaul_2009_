class Node{
 ArrayList children;
 float x,y;
 int level; 
 float rad;
  
 Node(float _x, float _y, float _rad){
  x=_x; y=_y; rad = _rad;
  children = new ArrayList();
 if(random(1)<0.01) {  
  int num = (int)random(0,3);
  for(int i=0; i < num; i++){
    Node n = new Node(x+random(-200,200),y - random(150,200), rad*0.5);
    if(random(1)<0.01)
      nodes.add(n);
    else
      children.add(n);
  }
}
 }
 
 void make_node(float _x, float _y){
   Node n = new Node(_x,_y-20, rad/2);
   children.add(n); 
 }
 
 void render(){
   stroke(0);
  for(int i=0; i<children.size();i++){
   Node n = (Node)children.get(i);
   line(n.x,n.y, x, y);
   ellipse(n.x,n.y,n.rad,n.rad);
  } 
  noStroke();
  ellipse(x,y,rad,rad);
 }
  
}
