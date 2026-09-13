PFont emptyWordsFont;
int emptyWordsFontSize = 24;
String emptyWordsFontName = "Trebuchet-BoldItalic-" + emptyWordsFontSize + ".vlw";

EmptyWords[] EmptyWordsArray;
int emptyWordsCount = 100;
float DEAD_WORDS_ENERGY = -10;

boolean emptyWordsAlive;

void createEmptyWords(){
  emptyWordsFont = loadFont(emptyWordsFontName);
  
  EmptyWordsArray = new EmptyWords[emptyWordsCount];
  for(int i=0;i<emptyWordsCount; i++)
    EmptyWordsArray[i] = new EmptyWords(emptyWordsFont, emptyWordsFontSize);
    
  emptyWordsAlive = false;
}


void bootEmptyWords() {
  if(emptyWordsAlive)
    return;
  for(int i=0;i<emptyWordsCount; i++)
    EmptyWordsArray[i].sayAgain();
  emptyWordsAlive = true;
}

void drawEmptyWords(float mainAlpha) {
  if(!emptyWordsAlive)
    return;
//print(mainAlpha);  
  for(int i=0;i<emptyWordsCount; i++)
    EmptyWordsArray[i].draw(mainAlpha);
}

void shutdownEmptyWords() {
  for(int i=0;i<emptyWordsCount; i++)
    EmptyWordsArray[i].energy = DEAD_WORDS_ENERGY;
  emptyWordsAlive = false;
}




class EmptyWords {

  float cx,cy;
  float energy, energyDec;
  color col;
  int emptyWordsIndex;
  float fontSize;
  
  PFont emptyWordsFont;
  int emptyWordsFontSize;

  color emptyWordsPalette[] = {0xffffff, 0x000000, 0xE33212}; // 0xF24E31
  String emptyWords[] = {
"see you later - i'll call you",
"sure, i'll call you back tomorrow",
"better late than never",
"hope to see you again",
"hope to see you soon",
"since it's my time to pay let's go mac donalds",
"i hope you understand we have no choice",
"yes i'm also very excited about that project",
"wow",
"excuse me",
"i'm also so happy",
"oh, thank you so much",
"sure, maybe next week",
"i bet you do, i bet you do",
"one can never be sure, one can never be sure",
"glad to meet you too",
"good morning",
"i hope we can still be friends",
"yes, i know you will",
"don't worry",
"certainly"
};

  EmptyWords(PFont _emptyWordsFont, int _emptyWordsFontSize){
    emptyWordsFont = _emptyWordsFont;
    emptyWordsFontSize = _emptyWordsFontSize;
    energy = DEAD_WORDS_ENERGY;
  }


  void sayAgain(){
    emptyWordsIndex = (int)random(0, emptyWords.length);
    col = emptyWordsPalette[(int)random(0,emptyWordsPalette.length)];
    cx = random(0,width);
    cy = random(0,height);
    fontSize=random(emptyWordsFontSize/2,emptyWordsFontSize);
    
    energy = 2.0; // 2...0
    energyDec = random(0.0001, 0.002);
  }


  void draw(float mainAlpha){
    if(energy <= DEAD_WORDS_ENERGY) // dead
      return;
      
    if(energy <= 0.0) // create another
      sayAgain();
    
    float al;
    if(energy >= 1.0)
      al = 2.0-energy;
    else
      al = energy;
// al is now 0..1

    al = al * mainAlpha;

    fill(red(col), green(col), blue(col), al);
    textFont(emptyWordsFont, fontSize);
    textAlign(CENTER);
    text( emptyWords[emptyWordsIndex], cx,cy);
    
    energy-=energyDec;
  }

}

