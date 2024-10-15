import processing.serial.*;
import ddf.minim.*;
import ddf.minim.effects.*;
import processing.video.*;

Serial myPort;
Minim minim;
MusicaArgentina musicaArgentina;
MusicaFrancia musicaFrancia;
Pantalla pantalla;

AudioPlayer[] cancionesA;  // Arreglo para almacenar las canciones
AudioPlayer[] cancionesF;  // Arreglo para almacenar las canciones
Movie [] videos = new Movie[3];  // Arreglo para almacenar los videos


int[] potValues = new int[4];  // Arreglo para los valores de los 4 potenciómetros
String switchState = "";  // Estado del switch

int pot1, pot2, pot3, pot4;
boolean musicaSonando_A = false; // Indicador de si la música está sonando
boolean musicaSonando_F = false; // Indicador de si la música está sonando

void setup() {
  //size(500, 778);
    fullScreen();

  myPort = new Serial (this, "COM3", 9600);
  minim = new Minim(this);

  //videos = new Movie[3];
  videos[0] = new Movie(this, "b_0.mp4");
  videos[1] = new Movie(this, "b_1.mp4");
  videos[2] = new Movie(this, "b_2.mp4");

  musicaArgentina = new MusicaArgentina();
  musicaFrancia = new MusicaFrancia();




  int numeroCanciones = 16; // Número de canciones a cargar
  cancionesA = new AudioPlayer[numeroCanciones]; // Inicializa el arreglo

  // Genera los nombres de archivos dinámicamente y carga las canciones
  for (int i = 0; i < numeroCanciones; i++) {
    String nombreArchivoA = "a_" + i + ".wav";  // Genera nombres como f_0.wav, f_1.wav, etc.
    cancionesA[i] = minim.loadFile(nombreArchivoA); // Carga el archivo
    println("Cargando: " + nombreArchivoA);
  }

  cancionesF = new AudioPlayer[numeroCanciones]; // Inicializa el arreglo
  for (int i = 0; i < numeroCanciones; i++) {
    String nombreArchivoF = "f_" + i + ".wav";  // Genera nombres como f_0.wav, f_1.wav, etc.
    cancionesF[i] = minim.loadFile(nombreArchivoF); // Carga el archivo
    println("Cargando: " + nombreArchivoF);
  }
}

void draw() {
  if (switchState.equals("A")) {
      image(videos[1], 0, 0, width, height);
      videos[1].loop();
      videos[0].stop();
      videos[2].stop();
    } else if (switchState.equals("A1")) {
      image(videos[1], 0, 0, width, height);
      videos[1].loop();
      videos[0].stop();
      videos[2].stop();
    } else if (switchState.equals("A2")) {
      image(videos[2], 0, 0, width, height);
      videos[2].loop();
      videos[0].stop();
      videos[1].stop();
    }

  fill(0);
  textAlign(CENTER);
  textSize(24);

  //String[] textos = {
  //  "Pua de Argentina: " + pot1,
  //  "Pua de Francia: " + pot2,
  //  "Volumen de Argentina: " + pot3,
  //  "Volumen de Francia: " + pot4,
  //  "Switch: " + switchState
  //};

  //// Dibujar cada línea de texto
  //for (int i = 0; i < textos.length; i++) {
  //  text(textos[i], width / 2, (height / 2 - 200) + (i * 100)); // Ajusta 20 píxeles entre cada línea
  //}


  musicaArgentina.reproduccion();
  musicaFrancia.reproduccion();
  //pantalla.pantallaP();
}

void movieEvent(Movie m) {
  m.read();
}

void serialEvent(Serial puerto) {
  String inString = puerto.readStringUntil('\n');  // Lee la cadena hasta el salto de línea
  if (inString != null) {
    inString = trim(inString);  // Limpia espacios en blanco
    String[] splitValues = split(inString, ',');  // Divide la cadena en valores separados por comas

    if (splitValues.length == 5) {  // Asegúrate de recibir 4 valores de potenciómetros + 1 del switch
      for (int i = 0; i < 4; i++) {
        potValues[i] = int(splitValues[i]);  // Convierte cada valor de potenciómetro a entero
      }

      pot1 = potValues[0];
      pot2 = potValues[1];
      pot3 = potValues[2];
      pot4 = potValues[3];
      switchState = splitValues[4];  // Toma el valor del switch
      println("Pot1: " + pot1 + ", Pot2: " + pot2 + ", Pot3: " + pot3 + ", Pot4: " + pot4 + ", Switch: " + switchState); // Para verificar los valores
    }
  }
}
