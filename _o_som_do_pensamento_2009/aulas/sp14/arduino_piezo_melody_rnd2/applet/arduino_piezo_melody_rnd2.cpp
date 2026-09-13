#include "WProgram.h"
void playTone(int tone, int duration);
void playNote(char note, int duration);
void setup();
void loop();
int speakerPin = 9;

int length = 15; // the number of notes
char notes[] = "ccggaagffeeddc "; // a space represents a rest
int beats[] = { 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 2, 4 };
int tempo = 300;
//brownian tempo
int tempomin = 1;
int tempomax = 100;
int tempodev = 5;

void playTone(int tone, int duration) {
  for (long i = 0; i < duration * 1000L; i += tone * 2) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(tone);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(tone);
  }
}

void playNote(char note, int duration) {
  char names[] = { 'c', 'd', 'e', 'f', 'g', 'a', 'b', 'C' };
//  int tones[] = { 1915, 1700, 1519, 1432, 1275, 1136, 1014, 956 };
  int tones[] = { 215, 317, 519, 732, 875, 1136, 1014, 956 };

  // play the tone corresponding to the note name
  for (int i = 0; i < 8; i++) {
    if (names[i] == note) {
      playTone(tones[i], duration);
    } else {
       
      playTone(440, 100);
 
    }
  }
}

void setup() {
  pinMode(speakerPin, OUTPUT);
}

void loop() {
  for (int i = 0; i < length; i++) {
    
    int num = random(length);
   int num2 = random(length);
    
    if (notes[i] == ' ') {
      delay(beats[num] * tempo); // rest
    } else {
      playNote(notes[num2], beats[num] * tempo);
    }

    // pause between notes
    delay(tempo / 2); 
    
    //update tempo
    tempo = tempo + random(-tempodev,tempodev);
    if(tempo>tempomax)
      tempo=tempomax;
    else if(tempo<tempomin)
      tempo=tempomin;
  }
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

