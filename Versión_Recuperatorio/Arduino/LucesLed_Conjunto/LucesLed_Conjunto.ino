int ledArgR = 10;   // Pin rojo de la tira Argentina
int ledArgG = 9;    // Pin verde de la tira Argentina
int ledArgB = 11;   // Pin azul de la tira Argentina

int ledFrR = 5;     // Pin rojo de la tira Francia
int ledFrG = 3;     // Pin verde de la tira Francia
int ledFrB = 6;     // Pin azul de la tira Francia

int potArg = A0;    // Potenciómetro Argentina
int potFrancia = A1; // Potenciómetro Francia


void setup() {
  pinMode(ledArgR, OUTPUT);
  pinMode(ledArgG, OUTPUT);
  pinMode(ledArgB, OUTPUT);
  
  pinMode(ledFrR, OUTPUT);
  pinMode(ledFrG, OUTPUT);
  pinMode(ledFrB, OUTPUT);

  pinMode(switchArg, INPUT_PULLUP);  // Configura A1 como entrada con resistencia interna
  pinMode(switchFra, INPUT_PULLUP); 
  
  Serial.begin(9600);
}

void loop() {
  int valorPotArg = analogRead(potArg);     // Lee valor de potenciómetro Argentina
  int valorPotFrancia = analogRead(potFrancia); // Lee valor de potenciómetro Francia
  
  // Efecto de latido en Argentina
  aplicarLatido(valorPotArg, ledArgR, ledArgG, ledArgB);

  // Efecto de latido en Francia
  aplicarLatido(valorPotFrancia, ledFrR, ledFrG, ledFrB);
  
  delay(50); // Pequeño retraso para evitar sobrecarga del serial
}

// Función para aplicar el efecto de latido a todos los colores
void aplicarLatido(int valorPot, int pinR, int pinG, int pinB) {
  int intensidadR = 0, intensidadG = 0, intensidadB = 0;
  
  // Control de los rangos para el color rojo
  if (valorPot >= 1 && valorPot <= 200 || valorPot >= 400 && valorPot <= 600) {
    intensidadR = abs(sin(millis() / 2000.0) * 255);  // Efecto de latido rojo
  }

  // Control de los rangos para el color azul
  if (valorPot >= 200 && valorPot <= 400 || valorPot >= 600 && valorPot <= 800) {
    intensidadB = abs(sin(millis() / 2000.0) * 255);  // Efecto de latido azul
  }

  // Control de los rangos para el color blanco
  if (valorPot == 0 || (valorPot >= 800 && valorPot <= 1000)) {
    intensidadR = intensidadG = intensidadB = abs(sin(millis() / 2000.0) * 255);  // Efecto de latido blanco
  }


  // Escribe la intensidad en los pines correspondientes
  analogWrite(pinR, intensidadR);
  analogWrite(pinG, intensidadG);
  analogWrite(pinB, intensidadB);
}
