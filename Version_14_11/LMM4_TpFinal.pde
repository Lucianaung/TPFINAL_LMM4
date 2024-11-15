import ddf.minim.*;
import processing.serial.*;
import processing.video.*;

//Serial myPort;
Minim minim;
MusicaArgentina musicaArgentina;
MusicaFrancia musicaFrancia;
//ControlPantallas controlPantallas;
Movie[] videos;

AudioPlayer[] cancionesA;  // Arreglo para canciones de Argentina
AudioPlayer[] cancionesF;  // Arreglo para canciones de Francia

int[] potValues = new int[4];  // Valores de los 4 potenciómetros
int pot1, pot2, pot3, pot4;
boolean musicaSonando_A = false;
boolean musicaSonando_F = false;
String switchState = "A";  // Estado inicial del switch

int[] posicionesCancionesA;
int[] posicionesCancionesF;
ControlPantallas controlPantallas;



void setup() {
  size(500, 788);//788
  //fullScreen();
  //String portName = Serial.list()[0];  // Selecciona el puerto donde está Arduino
  //myPort = new Serial(this, portName, 9600); // Abre la conexión serial a 9600 baudios
  minim = new Minim(this);
  videos = new Movie[6];  // Inicializa el arreglo de videos

  // Cargar videos directamente en el arreglo
  videos[0] = new Movie(this, "v_0.mp4"); // Arg N
  videos[1] = new Movie(this, "v_1.mp4"); // Arg A
  videos[2] = new Movie(this, "v_2.mp4"); // Arg D
  videos[3] = new Movie(this, "v_3.mp4"); // Fra N
  videos[4] = new Movie(this, "v_4.mp4"); // Fra A
  videos[5] = new Movie(this, "v_5.mp4"); // Fra D

  controlPantallas = new ControlPantallas(videos);

  // Inicializa potenciómetros y estado
  pot1 = 1023;
  pot2 = 1023;
  pot3 = 0;
  pot4 = 0;
  switchState = "A";
  
  
  int numeroCanciones = 16; // Número de canciones a cargar

  cancionesA = new AudioPlayer[numeroCanciones]; // Inicializa el arreglo
  posicionesCancionesA = new int[cancionesA.length];  // Inicializa el array para las posiciones

  // Carga las canciones A
  for (int i = 0; i < numeroCanciones; i++) {
    String nombreArchivoA = "a_" + i + ".wav";  // Genera nombres como f_0.wav, f_1.wav, etc.
    cancionesA[i] = minim.loadFile(nombreArchivoA); // Carga el archivo
    //println("Cargando: " + nombreArchivoA);
  }

  cancionesF = new AudioPlayer[numeroCanciones]; // Inicializa el arreglo
  posicionesCancionesF = new int[cancionesF.length];  // Inicializa el array para las posiciones

  // Carga las canciones F
  for (int i = 0; i < numeroCanciones; i++) {
    String nombreArchivoF = "f_" + i + ".wav";  // Genera nombres como f_0.wav, f_1.wav, etc.
    cancionesF[i] = minim.loadFile(nombreArchivoF); // Carga el archivo
    //println("Cargando: " + nombreArchivoF);
  }


  musicaArgentina = new MusicaArgentina(posicionesCancionesA);
  musicaFrancia = new MusicaFrancia();
}

void draw() {
  if (controlPantallas != null) {
    controlPantallas.dibujarVideos();
  } else {
    println("controlPantallas no está inicializado");
    return; // Salir si es nulo
  }


  //cancionesLuces();
  //verificarReproduccionCanciones();
  musicaArgentina.reproduccion();
  musicaFrancia.reproduccion();
  //textoPantalla();

  println("Pot1ARGENTINA: " + pot1 + " / " + "Pot3VOLUMEN::A: " + pot3 +
    " / " + "Pot2FRANCIA: " + pot2 + " / " + "Pot4VOLUMEN::F: " + pot4 + " / " + "switchState: " + switchState);
}

void movieEvent(Movie m) {
  m.read();
}

//void serialEvent(Serial puerto) {
// String inString = puerto.readStringUntil('\n');  // Lee la cadena hasta el salto de línea
// if (inString != null) {
// inString = trim(inString);  // Limpia espacios en blanco
// String[] splitValues = split(inString, ',');  // Divide la cadena en valores separados por comas

// if (splitValues.length == 5) {  // Asegúrate de recibir 4 valores de potenciómetros + 1 del switch
// for (int i = 0; i < 4; i++) {
// potValues[i] = int(splitValues[i]);  // Convierte cada valor de potenciómetro a entero
// }

// pot1 = potValues[0];
// pot2 = potValues[1];
// pot3 = potValues[2];
// pot4 = potValues[3];
// switchState = splitValues[4];  // Toma el valor del switch
// println("Pot1: " + pot1 + ", Pot2: " + pot2 + ", Pot3: " + pot3 + ", Pot4: " + pot4 + ", Switch: " + switchState); // Para verificar los valores
// }
// }
// }

//void cancionesLuces() {
//  // CANCIONES ARGENTINA
//  if (cancionesA[14].isPlaying() || cancionesA[12].isPlaying() || cancionesA[11].isPlaying() || cancionesA[9].isPlaying() ||
//    cancionesA[7].isPlaying() || cancionesA[6].isPlaying() || cancionesA[5].isPlaying() || cancionesA[3].isPlaying() ||
//    cancionesF[14].isPlaying() || cancionesF[13].isPlaying() || cancionesF[12].isPlaying() || cancionesF[11].isPlaying() ||
//    cancionesF[10].isPlaying()) {
//    myPort.write('A'); // Desamor
//  }
//  if (cancionesA[13].isPlaying() || cancionesA[10].isPlaying() || cancionesA[8].isPlaying() || cancionesA[2].isPlaying() ||
//    cancionesA[1].isPlaying() || cancionesA[0].isPlaying() || cancionesF[15].isPlaying() || cancionesF[5].isPlaying() ||
//    cancionesF[1].isPlaying()) {
//    myPort.write('B'); // Amor
//  }
//  if (cancionesA[15].isPlaying() || cancionesA[4].isPlaying() || cancionesF[9].isPlaying() || cancionesF[8].isPlaying() ||
//    cancionesF[7].isPlaying() || cancionesF[6].isPlaying() || cancionesF[4].isPlaying() || cancionesF[3].isPlaying() ||
//    cancionesF[2].isPlaying() || cancionesF[0].isPlaying()) {
//    myPort.write('C'); // Neutral
//  }
//}

void keyPressed() {
  // CONTROL CANCIONES ARGENTINA
  if (key == 'W' || key == 'w') {
    pot1 = max(0, pot1 - 10);
  } else if (key == 'Q' || key == 'q') {
    pot1 = min(1023, pot1 + 10);
  }

  // CONTROL CANCIONES FRANCIA
  if (key == 'S' || key == 's') {
    pot2 = max(0, pot2 - 10);  // Baja el valor de pot2, límite mínimo es 0
  } else if (key == 'A' || key == 'a') {
    pot2 = min(1023, pot2 + 10);  // Sube el valor de pot2, límite máximo es 1023
  }

  // CONTROL VOLUMEN ARGENTINA
  if (key == 'X' || key == 'x') {
    pot3 = min(1023, pot3 + 10);  // Sube el valor de Pot3
  } else if (key == 'Z' || key == 'z') {
    pot3 = max(0, pot3 - 10);  // Baja el valor de Pot3
  }

  // CONTROL VOLUMEN FRANCIA
  if (key == 'M' || key == 'm') {
    pot4 = min(1023, pot4 + 10);  // Sube el valor de Pot4
  } else if (key == 'N' || key == 'n') {
    pot4 = max(0, pot4 - 10);  // Baja el valor de Pot4
  }

  if (key == '0') {
    controlPantallas.reproduceVideo(0);
  } else if (key == '1') {
    controlPantallas.reproduceVideo(1);
  } else if (key == '2') {
    controlPantallas.reproduceVideo(2);
  } else if (key == '3') {
    controlPantallas.reproduceVideo(3);
  } else if (key == '4') {
    controlPantallas.reproduceVideo(4);
  } else if (key == '5') {
    controlPantallas.reproduceVideo(5);
  } else if (key == '6') {
    controlPantallas.detenerVideos();
  }
}
