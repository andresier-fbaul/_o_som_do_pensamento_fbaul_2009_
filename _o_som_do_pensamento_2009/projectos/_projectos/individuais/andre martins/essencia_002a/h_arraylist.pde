ArrayList bolas = new ArrayList();

 for(int i=0; i<bolas.size(); i++){
  Bola b = (Bola) bolas.get(i);
  b.render(i);
  
  void init_scene(){
  
   for(int i = 0; i < num_bolas; i++) {
   Bola b = new Bola();
   bolas.add(b);   
   
   //não estou a conseguir associar este array de bolas a cada uma das bolas que aparecem
