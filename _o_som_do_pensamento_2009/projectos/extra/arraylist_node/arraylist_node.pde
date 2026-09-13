/// arraylist como colecção dinâmica de elementos
ArrayList nodes;
PFont f;

void setup(){
  size(500,500,P3D);
  f = createFont("sans-serif",12); 
  textFont(f,12);
  nodes = new ArrayList(); //criar uma arraylist vazia
  Node root = new Node(width/2,height-100,100);
  nodes.add(root); // adicionar um elemento
}

int countnodes(){
  int count=0;
  for(int u=0;u<nodes.size();u++){
    Node n = (Node) nodes.get(u);
    count++;
   for(int i=0;i<n.children.size();i++){
     count++;
//     println();
  }
  }
  return count;
}

void draw(){
  camera(200,000,1000, 200, 000, 0, 0, 1, 0);
  background(127);
  noStroke();
   fill(255,50);
  if(mousePressed){
    Node p = new Node(mouseX,mouseY,100);
    nodes.add(p);
  }

  for (int i=0; i<nodes.size();i++){
    Node p = (Node) nodes.get(i);
      p.render();
      if(random(1)<0.01){
        float x = map(((int)random(5)), 0,5,-200,200);
        p.make_node(p.x+x, p.y - p.rad*2); 
      } else if (random(1)<0.005) {
        Node n = new Node(random(width),random(height-height/5,height),random(50,100));
        nodes.add(n);        
        
      }
  }
  
  fill(0);
  text("nodes: "+countnodes(),
        5,height-10);


}


