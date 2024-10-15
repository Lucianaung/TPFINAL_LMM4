// Definición de pines para la tira LED y el switch
int ledPin = 9;    // Pin para el color rojo (o tira LED blanca)
int switchPin1 = 2;  // Pin para A1 del switch
int switchPin2 = 3;  // Pin para A2 del switch
int pot1, pot2, pot3, pot4;  // Variables para los potenciometros
int estadoA1, estadoA2;  // Variables para el estado del switch

void setup() {
  Serial.begin(9600);  // Inicia la comunicación serial

  // Configura pines como salida/entrada
  pinMode(ledPin, OUTPUT);  // Configura el pin de la tira LED como salida
  pinMode(switchPin1, INPUT_PULLUP);  // Configura A1 como entrada con resistencia interna
  pinMode(switchPin2, INPUT_PULLUP);  // Configura A2 como entrada con resistencia interna
}

void loop() {
  // Lee el estado del switch
  estadoA1 = digitalRead(switchPin1);
  estadoA2 = digitalRead(switchPin2);

  // Lee los valores de los potenciometros
  pot1 = analogRead(A0);
  pot2 = analogRead(A1);
  pot3 = analogRead(A2);
  pot4 = analogRead(A3);

  // Envía los valores de los potenciometros junto con el estado del switch
  Serial.print(pot1);
  Serial.print(",");
  Serial.print(pot2);
  Serial.print(",");
  Serial.print(pot3);
  Serial.print(",");
  Serial.print(pot4);
  Serial.print(",");

  // Envía el estado del switch
  if (estadoA1 == LOW) {
    Serial.println("A1");
  } else if (estadoA2 == LOW) {
    Serial.println("A2");
  } else {
    Serial.println("A");
  }

  // Controla la tira LED en función del valor de pot1
  if (pot1 >= 800 && pot1 <= 900) {
    digitalWrite(ledPin, HIGH);  // Enciende la tira LED (blanca o roja)
  } else {
    digitalWrite(ledPin, LOW);   // Apaga la tira LED
  }

  delay(100);  // Pausa breve para evitar saturación del puerto serial
}
