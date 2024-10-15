class MusicaArgentina {
  int ultimoVal_A = -1;
  int espera_A = 3;
  int tiempoDeUltimoCambio_A = 0;
  int delay_A = 2000;
  boolean pausaPorSalto_A = false;
  boolean tiempoComienzo_A = false;
  
  // Rangos de potenciómetro correspondientes a cada canción
  int[][] rangos = {
     {1023, 959}, // Canción 1
    {959, 895},  // Canción 2
    {895, 831},  // Canción 3
    {831, 767},  // Canción 4
    {767, 703},  // Canción 5
    {703, 639},  // Canción 6
    {639, 575},  // Canción 7
    {575, 511},  // Canción 8
    {511, 447},  // Canción 9
    {447, 383},  // Canción 10
    {383, 319},  // Canción 11
    {319, 255},  // Canción 12
    {255, 191},  // Canción 13
    {191, 127},  // Canción 14
    {127, 63},   // Canción 15
  };

  MusicaArgentina() {}

  void reproduccion() {
    float volumeA = map(pot3, 0, 1023, -80, 0); // Mapea el volumen

    // Ajusta el volumen de las canciones que están sonando
    for (int i = 1; i < cancionesA.length; i++) {
      if (cancionesA[i].isPlaying()) {
        cancionesA[i].setGain(volumeA);
      }
    }

    if (!pausaPorSalto_A || (tiempoComienzo_A && millis() - tiempoDeUltimoCambio_A >= delay_A)) {
      pausaPorSalto_A = false;
      tiempoComienzo_A = false;
      
      // Itera sobre los rangos y reproduce la canción correspondiente
      for (int i = 0; i < rangos.length; i++) {
        if (pot1 <= rangos[i][0] && pot1 > rangos[i][1]) {
          reproduceCancion(i + 1, "Disco " + (2024 - i));
          return; // Salir después de reproducir la canción correcta
        }
      }
      
      // Si no se encuentra un rango, detener la música
      stopAllMusicA();
    }
  }

  // Función auxiliar para manejar la reproducción de una canción
  void reproduceCancion(int indiceCancion, String discoA) {
    if (!cancionesA[indiceCancion].isPlaying()) {
      stopAllMusicA();
      cancionesA[indiceCancion].play();
      cancionesA[indiceCancion].loop();
      musicaSonando_A = true;
      println("reproduciendo: " + discoA);
    }
  }
  
  void stopAllMusicA() {
  for (int i = 1; i < cancionesA.length; i++) {
    if (cancionesA[i].isPlaying()) {
      cancionesA[i].pause();
    }
  }
  musicaSonando_A = false;
}
}
