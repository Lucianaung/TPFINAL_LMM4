class MusicaFrancia {
  int ultimoVal_F = -1;
  int espera_F = 3;
  int tiempoDeUltimoCambio_F = 0;
  int delay_F = 2000;
  boolean pausaPorSalto_F = false;
  boolean tiempoComienzo_F = false;

  // Rangos de potenciómetro correspondientes a cada canción
  int[][] rangos = {
    {0, 4}, // 1 N 2017
    {4, 12}, // 2 A
    {12, 24}, // 3 N
    {24, 33}, // 4 N
    {33, 47}, // 5 N
    {47, 55}, // 6 A
    {55, 66}, // 7 N
    {66, 77}, // 8 N
    {77, 90}, // 9 N
    {90, 100}, // 10 N
    {100, 110}, // 11 D
    {110, 127}, // 12 D
    {127, 139}, // 13 D
    {139, 154}, // 14 D
    {154, 175}, // 15 D
    {175, 186}, // 16 A 2024
  };

  MusicaFrancia() {
  }

  void reproduccion() {
    float volumeF = map(pot4, 0, 1023, -80, 0); // Mapea el volumen

    // Ajusta el volumen de las canciones que están sonando
    for (int i = 0; i < cancionesF.length; i++) {
      if (cancionesF[i].isPlaying()) {
        cancionesF[i].setGain(volumeF);
      }
    }

    if (!pausaPorSalto_F || (tiempoComienzo_F && millis() - tiempoDeUltimoCambio_F >= delay_F)) {
      pausaPorSalto_F = false;
      tiempoComienzo_F = false;

      // Itera sobre los rangos y reproduce la canción correspondiente
      for (int i = 0; i < rangos.length; i++) {
        if (pot1 <= rangos[i][0] && pot1 > rangos[i][1]) {
          reproduceCancion(i);
          return; // Salir después de reproducir la canción correcta
        }
      }

      // Si no se encuentra un rango, detener la música
      stopAllMusicF();
    }
  }

  void reproduceCancion(int indiceCancion) {
    if (!cancionesF[indiceCancion].isPlaying()) {
      stopAllMusicF();  // Detiene cualquier otra canción

      int posicionGuardada = posicionesCancionesF[indiceCancion];  // Recupera la posición guardada

      if (posicionGuardada > 0) {
        //println("Reanudando canción en la posición: " + posicionGuardada + " ms");
        cancionesF[indiceCancion].cue(posicionGuardada);  // Reanuda desde la posición guardada
      } else {
        //println("Reproduciendo desde el inicio.");
      }

      cancionesF[indiceCancion].play();  // Reproduce la canción

      // Aquí es donde configuramos un temporizador o detector para cuando termine la canción
      // Podemos revisar constantemente si la canción se ha acercado al final para hacer el bucle manualmente
      new Thread(() -> {
        while (cancionesF[indiceCancion].isPlaying()) {
          if (cancionesF[indiceCancion].position() >= cancionesF[indiceCancion].length() - 50) {
            // Cuando se acerca al final (puedes ajustar los 50 ms)
            cancionesF[indiceCancion].cue(0);  // Coloca al principio
            cancionesF[indiceCancion].play();  // Reproduce desde el inicio
          }
        }
      }
      ).start();

      musicaSonando_F = true;
      //println("Reproduciendo: " + discoF + " desde posición: " + posicionesCancionesF[indiceCancion] + " ms");
    }
  }

  // Detiene toda la música y guarda la posición actual de cada canción
  void stopAllMusicF() {
    for (int i = 0; i < cancionesF.length; i++) {
      if (cancionesF[i].isPlaying()) {
        posicionesCancionesF[i] = cancionesF[i].position();  // Guarda la posición actual de la canción
        cancionesF[i].pause();  // Pausa la canción
        //println("Canción " + (i + 1) + " pausada en: " + posicionesCancionesF[i] + " ms");
      }
    }
    musicaSonando_F = false;
  }
}
