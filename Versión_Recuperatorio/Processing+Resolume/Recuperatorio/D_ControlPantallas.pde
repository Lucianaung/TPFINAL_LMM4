//class ControlPantallas {
//  Movie[] videos;  // Array para almacenar los videos

//  // Constructor modificado para recibir videos
//  ControlPantallas(Movie[] video) {
//    this.videos = video;
//  }

//  // Método para reproducir video
//  void reproduceVideo(int videoIndex) {
//    if (videoIndex < 0 || videoIndex >= videos.length) {
//      println("Índice de video fuera de rango: " + videoIndex);
//      return;
//    }

//    detenerVideos();

//    videos[videoIndex].loop();  // Reproduce el video en bucle
//    println("Reproduciendo video: " + videoIndex);
//  }

//  // Método para dibujar los videos
//  void dibujarVideos() {
//    background(0);  // Fondo negro
//    for (int i = 0; i < videos.length; i++) {
//      if (videos[i].isPlaying()) {
//        videos[i].read();  // Actualizar el video
//        //translate(width, 0);
//        //rotate(HALF_PI);
//        image(videos[i], 0, 0, width, height);  // Dibujar el video en pantalla 100
//      }
//    }
//  }

//  void detenerVideos() {
//    for (int i = 0; i < videos.length; i++) {
//      if (videos[i].isPlaying()) {
//        videos[i].stop(); // Detiene el video actual
//        //videos[i].dispose(); // Libera los recursos asociados con el video
//      }
//    }
//  }
//}
