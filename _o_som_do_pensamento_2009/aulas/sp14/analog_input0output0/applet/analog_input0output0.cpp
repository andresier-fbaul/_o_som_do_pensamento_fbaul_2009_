/*
 
   analog input 1
 
   ler o pin anal\u00f3gico 0 e fazer o output do valor para o serial directo
 
  */

#include "WProgram.h"
void setup();
void loop();
int valor = 0;    // variavel para o valor
int pin = 5;      // variavel para o pin de entrada do valor

int valorfora = 0;
int pinfora = 5;

void setup() {
  // open the serial port at 9600 bps:
  Serial.begin(9600);
  digitalWrite(13,HIGH); //turn on led
}

void loop() {

  // ler o valor do pin
  valor = analogRead(pin);
  Serial.print(valor, DEC); //modo dec envia os caracteres de cada n\u00famero
  Serial.println(); //escreve o caracter 10 = new line \n
  // escrever um caracter de linefeed
//  Serial.println();                  
  // esperar 10ms at\u00e9 \u00e0 pr\u00f3xima leitura
   delay(10);
   
   //ler do computador e reescrever para l\u00e1 o que chegou
   
   while(Serial.available()>0){
     byte b1 = Serial.read(); //ler byte1
     byte b2 = Serial.read(); //ler byte2
     valorfora = (b2*256)+b1;
     
     Serial.print(valorfora,DEC);
     Serial.println();
     analogWrite(valorfora,pinfora);
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

