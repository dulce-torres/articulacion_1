int valor_potenciometro = 0;
void setup(){
  Serial.begin(9600);
}

void loop(){
  valor_potenciometro = analogRead(A0);
  Serial.println(valor_potenciometro);
  delay(100);
}
