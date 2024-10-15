// Pines donde están conectadas las patas A1 y A2
const int pinA1 = 2;
const int pinA2 = 3;

// Pines donde están conectadas las LEDs
const int ledBlanca = 7;
const int ledRoja = 6;

void setup() {
  Serial.begin(9600);
  
  // Configuramos los pines como entradas con resistencias pull-up internas
  pinMode(pinA1, INPUT_PULLUP);
  pinMode(pinA2, INPUT_PULLUP);

  // Configuramos los pines de las LEDs como salidas
  pinMode(ledBlanca, OUTPUT);
  pinMode(ledRoja, OUTPUT);

  // Inicialmente apagamos las LEDs
  digitalWrite(ledBlanca, LOW);
  digitalWrite(ledRoja, LOW);
}

void loop() {
  // Leer el estado de A1 y A2
  int estadoA1 = digitalRead(pinA1);
  int estadoA2 = digitalRead(pinA2);

  // Si A1 está conectado (LOW debido a pull-up), encendemos la LED blanca
  if (estadoA1 == LOW && estadoA2 == HIGH) {
    Serial.println("A1");
    digitalWrite(ledBlanca, HIGH); // Encendemos la LED blanca
    digitalWrite(ledRoja, LOW);    // Apagamos la LED roja
  }
  // Si A2 está conectado (LOW debido a pull-up), encendemos la LED roja y apagamos la blanca
  else if (estadoA1 == HIGH && estadoA2 == LOW) {
    Serial.println("A2");
    digitalWrite(ledBlanca, LOW);  // Apagamos la LED blanca
    digitalWrite(ledRoja, HIGH);   // Encendemos la LED roja
  }
  // Si ninguno está conectado, apagamos ambas LEDs
  else if (estadoA1 == HIGH && estadoA2 == HIGH) {
    Serial.println("A");
    digitalWrite(ledBlanca, LOW);  // Apagamos la LED blanca
    digitalWrite(ledRoja, LOW);    // Apagamos la LED roja
  }

  delay(500); // Para evitar múltiples lecturas rápidas
}
