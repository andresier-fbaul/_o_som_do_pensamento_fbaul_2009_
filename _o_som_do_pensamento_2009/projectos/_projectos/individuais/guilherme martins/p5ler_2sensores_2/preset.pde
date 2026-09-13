class Preset{

  //  float  pacote[] = new float [8];

  String  texto[];

  Preset(){

    texto = loadStrings("default_presets.txt");
    if(texto==null){
      texto = new String[0]; 
    }
  } 


  void writePresets(){

    saveStrings("preset-"+hour()+"-"+minute()+".txt", texto);
    println("--saved : "+"preset-"+hour()+"-"+minute()+".txt");


  }

  void addPreset(int pack[]){

    String data = "";
    data += ""+pack[0]+" "+pack[1]+" "+pack[2]+" "+pack[3]+" "+pack[4]+" "+pack[5]+" "+pack[6]+" "+pack[7];
    //   data += "\n";

    texto =  append(texto, data);
    println("--added : "+data);

  }


  int[] returnPreset(int num){
    int index = (int) constrain(num, 0 , texto.length);
    String data = texto[index];
    String info[] = split(data,' ');
    int rval[] = new int[8];
    for(int i=0;i<8;i++)
      rval[i] = int(info[i]);

    return rval; 
  }

  void recallPreset(int num){

    int index = (int) constrain(num, 0 , texto.length);
    String data = texto[index];
    String info[] = split(data,' ');

    val[0] = cotovelo_dir = int(info[0]);
    val[1] = ombro_dir = int(info[1]);
    val[2] = omoplata_dir = int(info[2]);
    val[3] = cotovelo_esq = int(info[3]);
    val[4] = ombro_esq = int(info[4]);
    val[5] = omoplata_esq = int(info[5]);
    val[6] = pescoco = int(info[6]);
    val[7] = cintura = int(info[7]);

  }

  void interpPresets(int na, int nb, float percent){

    int preseta[] = returnPreset(na);//new int[8];
    int presetb[] = returnPreset(nb);//new int[8];
    int presetret[] = new int[8];
    
 
    println("");
   for(int i=0;i<8;i++) {
      presetret[i] = (int)((1.0-percent) * preseta[i] + percent * presetb[i]);
      
      print(presetret[i] + " ");
   
      // send to serial
  
    }



  }


}


