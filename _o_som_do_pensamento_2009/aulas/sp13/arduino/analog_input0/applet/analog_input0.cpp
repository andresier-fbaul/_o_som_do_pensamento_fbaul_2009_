/*
 
   analog input 1
 
   ler o pin anal\ufffdgico 0 e fazer o output do valor para o serial directo
 
  */

#include "WProgram.h"
void setup();
void loop();
int valor = 0;    // variavel para o valor
int pin = 1;      // variavel para o pin de entrada do valor



void setup() {
  // open the serial port at 9600 bps:
  Serial.begin(9600);
  digitalWrite(13,HIGH); //turn on led
}

void loop() {

  // ler o valor do pin
  valor = analogRead(pin);
  // escrever pelo serial o valor do pin em formato decimal
  // o sensor vai de 0-1024, dividindo por 4, o resultado \ufffd 0-255, j\ufffd vai por um byte
  // mas este LDR, com testes, o valor vai de 30 a 245 
  Serial.print(valor, DEC);
  Serial.println();
//  Serial.print(0, BYTE);

//  Serial.print(valor);
  // escrever um caracter de linefeed
//  Serial.println();                  
  // esperar 10ms at\ufffd \ufffd pr\ufffdxima leitura
   delay(10);
 
 

  // print it out in many formats:
//  Serial.print(analogValue);         // print as an ASCII-encoded decimal
//  Serial.print("\t");                // print a tab character
//  Serial.print(analogValue, DEC);    // print as an ASCII-encoded decimal
//  Serial.print("\t");                // print a tab character
//  Serial.print(analogValue, HEX);    // print as an ASCII-encoded hexadecimal
//  Serial.print("\t");                // print a tab character
//  Serial.print(analogValue, OCT);    // print as an ASCII-encoded octal
//  Serial.print("\t");                // print a tab character
//  Serial.print(analogValue, BIN);    // print as an ASCII-encoded binary
//  Serial.print("\t");                // print a tab character
//  Serial.print(analogValue/4, BYTE); // print as a raw byte value (divide the
                                     // value by 4 because analogRead() returns numbers
                                     // from 0 to 1023, but a byte can only hold values
                                     // up to 255)
//  Serial.print("\t");                // print a tab character    
//  Serial.println();                  // print a linefeed character

}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

