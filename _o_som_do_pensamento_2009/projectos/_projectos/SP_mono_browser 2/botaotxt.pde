

class BotaoTxt extends Botao{

  String autor;
  String titulo;
  PImage img;
  String descricao;
  String executaveis[];
  String displayinfo;


  BotaoTxt(int i,  float _x, float _y, float _w , float _h ){
    super(i,_x,_y,_w,_h); //construtor botao normal

    // ler a info do texto a partir do texto global
    autor = projectos[i*6 + 1];
    titulo = projectos[i*6 + 2];
    img = loadImage(projectos[i*6 + 3]);
    descricao = projectos[i*6 + 4];
    executaveis = split ( projectos[i*6 + 5] , ' '); 
    
    displayinfo = titulo+"\n"+autor;//+"\n"+descricao;
    println("----projecto do "+autor+" "+titulo+" "+descricao+" "+executaveis);

  }

  // overloading state to handle sound here
  void state(){

    super.state();
    
    if(gain>2)
      execute();
    
  }
  
  void execute(){
//   println("execute called!! botao "+id); 

      stat = "loading "+ trim(titulo)+"...";
      stat += "\n\ncarregue em 'esc' para sair do\ntrabalho actual e escolher outro";

      String file = path + executaveis[0];
      open(file);

    //  stat = 
  }
  
  
  void render(){
    state();
    int c0 = on ? coron : coroff;
    fill(c0,map(gain,0,100,10,255));    
    rect(x,y,w,h);
    tint(c0, on?255:100);
    image(img, x-w2,y-h2,w,h);
    fill(255);


    textFont(font);
    text(displayinfo,x-w2,y+h2+10);

// split descricao by \n    
    String[] descList = split(descricao, "\\n");

    textFont(fontsmall);
    float yy=y+h2+45;
    for(int i=0; i<descList.length; i++){
      text(trim(descList[i]),x-w2,yy);
      yy+=(textAscent() + textDescent()) * 1.5;
    }


  }

}


