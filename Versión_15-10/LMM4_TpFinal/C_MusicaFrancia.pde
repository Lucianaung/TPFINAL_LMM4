class MusicaFrancia {
  int ultimoVal_F = -1;
  int espera_F = 3;
  int tiempoDeUltimoCambio_F = 0;
  int delay_F = 2000;
  boolean pausaPorSalto_F = false;
  boolean tiempoComienzo_F = false;
  
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

  MusicaFrancia() {}

  void reproduccion() {
    float volumeF = map(pot4, 0, 1023, -80, 0); // Mapea el volumen

    // Ajusta el volumen de las canciones que están sonando
    for (int i = 1; i < cancionesF.length; i++) {
      if (cancionesF[i].isPlaying()) {
        cancionesF[i].setGain(volumeF);
      }
    }

    if (!pausaPorSalto_F || (tiempoComienzo_F && millis() - tiempoDeUltimoCambio_F >= delay_F)) {
      pausaPorSalto_F = false;
      tiempoComienzo_F = false;
      
      // Itera sobre los rangos y reproduce la canción correspondiente
      for (int i = 0; i < rangos.length; i++) {
        if (pot2 <= rangos[i][0] && pot2 > rangos[i][1]) {
          reproduceCancion(i + 1, "Disco " + (2024 - i));
          return; // Salir después de reproducir la canción correcta
        }
      }
      
      // Si no se encuentra un rango, detener la música
      stopAllMusicF();
    }
  }

  // Función auxiliar para manejar la reproducción de una canción
  void reproduceCancion(int indiceCancion, String discoF) {
    if (!cancionesF[indiceCancion].isPlaying()) {
      stopAllMusicF();
      cancionesF[indiceCancion].play();
      cancionesF[indiceCancion].loop();
      musicaSonando_F = true;
      println("reproduciendo: " + discoF);
    }
  }
  
  void stopAllMusicF() {
  for (int i = 1; i < cancionesF.length; i++) {
    if (cancionesF[i].isPlaying()) {
      cancionesF[i].pause();
    }
  }
  musicaSonando_F = false;
}
}
