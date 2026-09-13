class word {  
  String w = "";
  float x,y;
  boolean visible = false;

  word(String s, float px, float py){
    w = s; 
    x = px;
    y = py;
  }

}



class Wonderland{

  word palavras[];
  int num_palavras;

  Wonderland(){
    
    ///load texto
    String lines[] = loadStrings("alice's_aventures_in_wonderland.txt"); 
    String texto[] = {""};

    for(int i=0; i<lines.length;i++) {
      String  words[] = splitTokens(lines[i]," ,") ;
      for(int j=0; j<words.length;j++) {
        texto = append ( texto, words[j] );
      }
    }
    println("texto com "+texto.length+" palavras" );


    palavras = new word[texto.length];
    num_palavras = texto.length;

    for(int i = 0; i < texto.length; i++) {

        float xpos = i * 200.0f;
        float ypos = random(-((i)%500),(i)%height) + random(-10,10);
        palavras[i] = new word(texto[i], xpos, ypos);      
      
    }


    logic();

  }



  void draw(){
    if(frameCount%30==0)
      logic();
     
    hint(DISABLE_DEPTH_TEST);
  //  stroke(0);
    fill(0);
    
    for(int i=0; i < num_palavras; i++ ) {
      if(!palavras[i].visible)
        continue;
      
      //se for visivel, renderiza:)
      
      text(palavras[i].w,palavras[i].x,palavras[i].y); 
      
    }
    
  }


  void logic(){
   
     for(int i = 0; i <  num_palavras; i++) {
      
        if( (palavras[i].x > (alice.x - 2000)) && (palavras[i].x < (alice.x + 2000)) ){
          palavras[i].visible = true;
        } else {
          palavras[i].visible = false;
        }
       
     }
    
  }


}




