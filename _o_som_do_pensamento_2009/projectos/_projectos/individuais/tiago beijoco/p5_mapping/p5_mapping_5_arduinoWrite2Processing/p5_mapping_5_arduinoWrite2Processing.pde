int pinPot = 0;      // variavel para o pin de entrada do valor
int valorPot = 0;    // variavel para o valor


//int pinLDR = 1;      // variavel para o pin de entrada do valor
//int valorLDR = 0;    // variavel para o valor

void setup() {

  Serial.begin(9600);
  digitalWrite(13,HIGH);
}

void loop() {

// ler valores do Pot 
  valorPot = analogRead(pinPot)/4;

//  ler valores do LDR
//  valorldr = analogRead(pinLDR); 
  
  Serial.print(valorPot, DEC);
  Serial.println(10, BYTE); // line feed
  
//  Serial.print(valorLDR, DEC);
//  Serial.print(9, BYTE); //tab
  delay(10);
}
