// Variables donde almacenaremos los valores de los cuatro potenciómetros
long valor1;
long valor2;
long valor3;
long valor4;

// Pines para el switch
const int pinA1 = 2; // Conectado a la posición A1 del switch
const int pinA2 = 3; // Conectado a la posición A2 del switch

int estadoA1; // Estado del pin A1
int estadoA2; // Estado del pin A2

void setup() {
  // Inicializamos la comunicación serial
  Serial.begin(9600);

  // Definir los pines del switch como entradas
  pinMode(pinA1, INPUT_PULLUP);
  pinMode(pinA2, INPUT_PULLUP);
}

void loop() {
  // Leemos los valores de los potenciómetros
  valor1 = analogRead(A0);
  valor2 = analogRead(A1);
  valor3 = analogRead(A2);
  valor4 = analogRead(A3);

  // Leemos los estados del switch
  estadoA1 = digitalRead(pinA1); // Leer el pin de A1
  estadoA2 = digitalRead(pinA2); // Leer el pin de A2

  // Determinar la posición del switch
  String posicionSwitch = "Centro";  // Asumimos que está en el centro por defecto
  if (estadoA1 == LOW) {
    posicionSwitch = "A1"; // Switch en la posición izquierda (A1)
  }
  else if (estadoA2 == LOW) {
    posicionSwitch = "A2"; // Switch en la posición derecha (A2)
  }

  // Enviamos los valores de los potenciómetros y la posición del switch
  Serial.print(valor1);
  Serial.print(",");
  Serial.print(valor2);
  Serial.print(",");
  Serial.print(valor3);
  Serial.print(",");
  Serial.print(valor4);
  Serial.print(",");
  Serial.println(posicionSwitch); // Enviamos la posición del switch
  
  // Añadimos un delay para evitar saturar el puerto serial
  delay(100);
}
