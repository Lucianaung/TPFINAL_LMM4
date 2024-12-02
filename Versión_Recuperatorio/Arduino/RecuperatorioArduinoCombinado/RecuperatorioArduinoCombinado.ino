int ledArgR = 10;  // Pin rojo de la tira Argentina
int ledArgG = 9;   // Pin verde de la tira Argentina
int ledArgB = 11;  // Pin azul de la tira Argentina

int ledFrR = 5;  // Pin rojo de la tira Francia
int ledFrG = 3;  // Pin verde de la tira Francia
int ledFrB = 6;  // Pin azul de la tira Francia

int switchPin1 = 13;  // Pin para A1 del switch
int switchPin2 = 12;  // Pin para A2 del switch

int pot1 = A0;           // Potenciómetro Argentina
int pot2 = A1;           // Potenciómetro Francia
int pot3, pot4;  // Variables para los otros potenciometros (A2, A3)
int estadoA1, estadoA2;      // Variables para el estado del switch

void setup() {
  Serial.begin(9600);  // Inicia la comunicación serial

  // Configura pines como salida/entrada
  pinMode(ledArgR, OUTPUT);
  pinMode(ledArgG, OUTPUT);
  pinMode(ledArgB, OUTPUT);

  pinMode(ledFrR, OUTPUT);
  pinMode(ledFrG, OUTPUT);
  pinMode(ledFrB, OUTPUT);

  pinMode(switchPin1, INPUT_PULLUP);  // Configura A1 como entrada con resistencia interna
  pinMode(switchPin2, INPUT_PULLUP);  // Configura A2 como entrada con resistencia interna
}

void loop() {
  int valorPotArg = analogRead(pot2);      // Lee valor de potenciómetro Argentina
  int valorPotFrancia = analogRead(pot1);  // Lee valor de potenciómetro Francia

  // Lee los valores de los otros potenciometros
  pot3 = analogRead(A2);  //volumenFrancia
  pot4 = analogRead(A3);  //volumenArgentina
  //pot1 = analogRead(A0);   //volumenFrancia
  //pot2 = analogRead(A1);  //volumenArgentina


  // Lee el estado de los switches
  estadoA1 = digitalRead(switchPin1);  //Argentina
  estadoA2 = digitalRead(switchPin2);  //Francia

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

  //Efecto de latido en Argentina (con base en pot1)
  aplicarLatidoArgentina(valorPotArg, ledArgR, ledArgG, ledArgB);

  //Efecto de latido en Francia (con base en pot2)
  aplicarLatidoFrancia(valorPotFrancia, ledFrR, ledFrG, ledFrB);

  delay(50);  // Pequeño retraso para evitar sobrecarga del serial
}

void aplicarLatidoArgentina(int valorPot, int pinR, int pinG, int pinB) {
  int intensidadR = 0, intensidadG = 0, intensidadB = 0;

  // Control de los rangos para el color rojo (Argentina)
  if (valorPot >= 854 && valorPot <= 873 || valorPot >= 901 && valorPot <= 913 || valorPot >= 922 && valorPot <= 934 || valorPot >= 995 && valorPot <= 1023) {
    intensidadR = abs(sin(millis() / 2000.0) * 255);  // Efecto de latido rojo
  }

  // Control de los rangos para el color azul (Argentina, entre 200 y 300)
  if (valorPot >= 825 && valorPot <= 854 || valorPot >= 873 && valorPot <= 901 || valorPot >= 913 && valorPot <= 922 || valorPot >= 934 && valorPot <= 970 || valorPot >= 980 && valorPot <= 995) {
    intensidadB = abs(sin(millis() / 2000.0) * 255);  // Efecto de latido azul en Argentina
  }

  // Control de los rangos para el color blanco (Argentina)
  if (valorPot >= 700 && valorPot <= 825 || valorPot >= 970 && valorPot <= 980) {
    intensidadR = intensidadG = intensidadB = abs(sin(millis() / 2000.0) * 255);  // Efecto de latido blanco
  }

  // Escribe la intensidad en los pines correspondientes
  analogWrite(pinR, intensidadR);
  analogWrite(pinG, intensidadG);
  analogWrite(pinB, intensidadB);
}

void aplicarLatidoFrancia(int valorPot, int pinR, int pinG, int pinB) {
  int intensidadR = 0, intensidadG = 0, intensidadB = 0;

  // Control de los rangos para el color rojo (Francia)
  if (valorPot >= 4 && valorPot <= 12 || valorPot >= 43 && valorPot <= 54 || valorPot >= 175 && valorPot <= 186) {
    intensidadR = abs(sin(millis() / 2000.0) * 255);  // Efecto de latido rojo
  }

  // Control de los rangos para el color azul (Francia)
  if (valorPot >= 102 && valorPot <= 175) {
    intensidadB = abs(sin(millis() / 2000.0) * 255);  // Efecto de latido azul en Francia
  }

  // Control de los rangos para el color blanco (Francia)
  if (valorPot >= 54 && valorPot <= 102 || valorPot >= 12 && valorPot <= 43 || valorPot >= 0 && valorPot <= 4) {
    intensidadR = intensidadG = intensidadB = abs(sin(millis() / 2000.0) * 255);  // Efecto de latido blanco
  }

  // Escribe la intensidad en los pines correspondientes
  analogWrite(pinR, intensidadR);
  analogWrite(pinG, intensidadG);
  analogWrite(pinB, intensidadB);
}
