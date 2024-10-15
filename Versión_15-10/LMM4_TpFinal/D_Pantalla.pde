class Pantalla {
  Pantalla () {
  }

  void pantallaP() {
    if (switchState.equals("A")) {
      image(videos[0], 0, 0, width, height);
      videos[0].loop();
      videos[1].stop();
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
    } else {
      println("Estado no reconocido del switch: " + switchState);
    }
  }

  //void mostrarVideo(int index) {
  //  println("Entrando a mostrarVideo con índice: " + index);
  //  for (int i = 0; i < videos.length; i++) { // Detiene otros videos si están en reproducción
  //    if (i != index && videos[i].isPlaying()) {
  //      println("Deteniendo video: " + i);
  //      videos[i].stop();
  //    }
  //  }

  //  // Reproduce el video seleccionado si no está reproduciéndose
  //  if (!videos[index].isPlaying()) {
  //    println("Reproduciendo video: " + index);
  //    videos[index].loop(); // Asegúrate de que el video se reproduzca en bucle
  //  }

  //  // Muestra el video en la pantalla
  //  image(videos[index], 0, 0, width, height); // Ajusta la posición y tamaño según necesites
  //}

  void movieEvent(Movie m) {
    m.read(); // Para asegurarse de que el video se actualice
  }
}
