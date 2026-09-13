/* "blinkingCursor", by Tiago Craft. O Som do Pensamento, Feb 2009
this is where i set the basis for my PulsingCircle icon, later used
in applets like "multiAttraction/multiAtracção" or "Mapping/Mapear".
It's also a first approach to gravity simulations.
*/

PulsingCircle rato[];
FloatingCircle corpo;

void setup(){
  size(1024,576);
  frameRate(25);
  noCursor();
  //call cursor constructor
  rato = new PulsingCircle[4];
  for(int i=0; i<rato.length; i++){
    rato[i] = new PulsingCircle();
  }
  //call floating circle constructor
  corpo = new FloatingCircle();
  corpo.setup();
}

void draw(){
  background(100);
  for (int i =0; i<rato.length; i++){
    rato[i].update();
  }
  corpo.update();
}
