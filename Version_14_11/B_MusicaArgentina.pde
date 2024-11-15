class MusicaArgentina {
  int ultimoVal_A = -1;
  int espera_A = 3;
  int tiempoDeUltimoCambio_A = 0;
  int delay_A = 2000;
  boolean pausaPorSalto_A = false;
  boolean tiempoComienzo_A = false;
  int[] posicionesCancionesA;

  // Rangos de potenciómetro correspondientes a cada canción
  int[][] rangos = {
    {1023, 959}, // 1 A 2017
    {959, 895}, // 2 A 
    {895, 831}, // 3 A 2018
    {831, 767}, // 4 D
    {767, 703}, // 5 N 2019
    {703, 639}, // 6 D
    {639, 575}, // 7 D 2020
    {575, 511}, // 8 D
    {511, 447}, // 9 A 2021
    {447, 383}, // 10 D
    {383, 319}, // 11 A 2022
    {319, 255}, // 12 D
    {255, 191}, // 13 D 2023
    {191, 127}, // 14 A
    {127, 63}, // 15 D 2024
    {63, 0}, // 16 N
  };

  MusicaArgentina(int[] posiciones) {
    if (cancionesA != null && cancionesA.length > 0) {
      if (posiciones != null && posiciones.length == cancionesA.length) {
        this.posicionesCancionesA = posiciones;
      } else {
        this.posicionesCancionesA = new int[cancionesA.length];  // Inicializa con tamaño adecuado
      }
    } else {
      // Manejo del caso donde cancionesA no esté inicializado
      println("Error: cancionesA no está inicializado o es vacío.");
      this.posicionesCancionesA = new int[0];  // Inicializa el array como vacío para evitar otros errores
    }
  }

  // Método para mapear el valor de potenciómetro y ajustar el volumen
  void reproduccion() {
    float volumeA = map(pot3, 0, 1023, -80, 0);  // Mapea el volumen

    // Ajusta el volumen de las canciones que están sonando
    for (int i = 0; i < cancionesA.length; i++) {
      if (cancionesA[i].isPlaying()) {
        cancionesA[i].setGain(volumeA);
      }
    }

    if (!pausaPorSalto_A || (tiempoComienzo_A && millis() - tiempoDeUltimoCambio_A >= delay_A)) {
      pausaPorSalto_A = false;
      tiempoComienzo_A = false;

      int indiceCancion = obtenerIndiceCancion(pot1);
      if (indiceCancion != -1) {
        reproduceCancion(indiceCancion);
      } else {
        stopAllMusicA();
      }
    }
  }

  // Función auxiliar para obtener el índice de la canción en función del valor del potenciómetro
  int obtenerIndiceCancion(int valorPot) {
    for (int i = 0; i < rangos.length; i++) {
      if (valorPot <= rangos[i][0] && valorPot > rangos[i][1]) {
        return i;
      }
    }
    return -1;  // Si no se encuentra un rango adecuado
  }

  // Reproduce la canción correspondiente al índice
  void reproduceCancion(int indiceCancion) {
    if (indiceCancion >= 0 && indiceCancion < cancionesA.length) {
      if (!cancionesA[indiceCancion].isPlaying()) {
        stopAllMusicA();  // Detiene cualquier otra canción

        int posicionGuardada = posicionesCancionesA[indiceCancion];  // Recupera la posición guardada

        if (posicionGuardada >= 0) {
          cancionesA[indiceCancion].cue(posicionGuardada);  // Reanuda desde la posición guardada
        }

        cancionesA[indiceCancion].play();  // Reproduce la canción

        // Control de la pantalla: actualiza el video en función de la canción
        // controlPantallas.reproduceVideo(indiceCancion);

        // Crear un hilo para monitorear la canción y reiniciarla al final
        new Thread(() -> {
          while (cancionesA[indiceCancion].isPlaying()) {
            if (cancionesA[indiceCancion].position() >= cancionesA[indiceCancion].length() - 50) {
              // Cuando se acerca al final, reinicia la canción
              cancionesA[indiceCancion].cue(0);  // Coloca al principio
              cancionesA[indiceCancion].play();  // Reproduce desde el inicio
            }
            try {
              Thread.sleep(100);  // Evita sobrecarga de CPU con un delay pequeño
            }
            catch (InterruptedException e) {
              e.printStackTrace();
            }
          }
        }
        ).start();

        musicaSonando_A = true;
      }
    }
  }

  // Detiene toda la música y guarda la posición actual de cada canción
  void stopAllMusicA() {
    for (int i = 0; i < cancionesA.length; i++) {
      if (cancionesA[i].isPlaying()) {
        posicionesCancionesA[i] = cancionesA[i].position();  // Guarda la posición actual de la canción
        cancionesA[i].pause();  // Pausa la canción
        println("Canción " + (i + 1) + " pausada en: " + posicionesCancionesA[i] + " ms");
      }
    }
    musicaSonando_A = false;
  }
}
