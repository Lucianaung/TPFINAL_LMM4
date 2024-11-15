//void verificarReproduccionCanciones() {
//  // Aquí empieza la lógica para asociar canciones y videos
//  if (switchState.equals("A")) {
//    controlPantallas.detenerVideos();
//  } else if (switchState.equals("A1")) { //ARGENTINA

//    // CANCIONES NEUTRALES
//    if (cancionesA[15].isPlaying() || cancionesA[4].isPlaying()) {
//      controlPantallas.detenerVideos(); // Asegúrate de implementar este método en ControlPantallas
//      controlPantallas.reproduceVideo(0);
//    }

//    //CANCIONES DESAMOR
//    if (cancionesA[14].isPlaying() || cancionesA[12].isPlaying() || cancionesA[11].isPlaying() || cancionesA[9].isPlaying() ||
//      cancionesA[7].isPlaying() || cancionesA[6].isPlaying() || cancionesA[5].isPlaying() || cancionesA[3].isPlaying()) {
//      controlPantallas.detenerVideos(); // Asegúrate de implementar este método en ControlPantallas
//      controlPantallas.reproduceVideo(1);
//    }

//    //CANCIONES AMOR
//    if (cancionesA[13].isPlaying() || cancionesA[10].isPlaying() || cancionesA[8].isPlaying() || cancionesA[2].isPlaying() ||
//      cancionesA[1].isPlaying() || cancionesA[0].isPlaying()) {
//      controlPantallas.detenerVideos(); // Asegúrate de implementar este método en ControlPantallas
//      controlPantallas.reproduceVideo(2);
//    }
//  } else if (switchState.equals("A2")) { //FRANCIA
//    // CANCIONES NEUTRALES
//    if (cancionesF[9].isPlaying() || cancionesF[8].isPlaying() || cancionesF[7].isPlaying() || cancionesF[6].isPlaying() ||
//      cancionesF[4].isPlaying() || cancionesF[3].isPlaying() || cancionesF[2].isPlaying() || cancionesF[0].isPlaying()) {
//      controlPantallas.detenerVideos(); // Asegúrate de implementar este método en ControlPantallas
//      controlPantallas.reproduceVideo(3);
//    }

//    //CANCIONES DESAMOR
//    if (cancionesF[14].isPlaying() || cancionesF[13].isPlaying() || cancionesF[12].isPlaying() || cancionesF[11].isPlaying() || cancionesF[10].isPlaying()) {
//      controlPantallas.detenerVideos(); // Asegúrate de implementar este método en ControlPantallas
//      controlPantallas.reproduceVideo(4);
//    }

//    //CANCIONES AMOR
//    if (cancionesF[15].isPlaying() || cancionesF[5].isPlaying() || cancionesF[1].isPlaying()) {
//      controlPantallas.detenerVideos(); // Asegúrate de implementar este método en ControlPantallas
//      controlPantallas.reproduceVideo(5);
//    }
//  } else {
//    controlPantallas.detenerVideos(); // Asegúrate de implementar este método en ControlPantallas
//  }
//}

//void cancionesLuces() {
//  //CANCIONES ARGENTINA
//  if (cancionesA[14].isPlaying() || cancionesA[12].isPlaying() || cancionesA[11].isPlaying() || cancionesA[9].isPlaying() ||
//    cancionesA[7].isPlaying() || cancionesA[6].isPlaying() || cancionesA[5].isPlaying() || cancionesA[3].isPlaying() || cancionesF[14].isPlaying() || cancionesF[13].isPlaying() ||
//    cancionesF[12].isPlaying() || cancionesF[11].isPlaying() || cancionesF[10].isPlaying()) {
//    myPort.write('A'); //Desamor
//  }
//  if (cancionesA[13].isPlaying() || cancionesA[10].isPlaying() || cancionesA[8].isPlaying() || cancionesA[2].isPlaying() ||
//    cancionesA[1].isPlaying() || cancionesA[0].isPlaying() || cancionesF[15].isPlaying() || cancionesF[5].isPlaying() || cancionesF[1].isPlaying()) {
//    myPort.write('B'); //Amor
//  }
//  if (cancionesA[15].isPlaying() || cancionesA[4].isPlaying() || cancionesF[9].isPlaying() || cancionesF[8].isPlaying() || cancionesF[7].isPlaying() || cancionesF[6].isPlaying() ||
//    cancionesF[4].isPlaying() || cancionesF[3].isPlaying() || cancionesF[2].isPlaying() || cancionesF[0].isPlaying()) {
//    myPort.write('C'); //Neutral
//  }

  //CANCIONES FRANCIA
  //if (cancionesF[14].isPlaying() || cancionesF[13].isPlaying() || cancionesF[12].isPlaying() || cancionesF[11].isPlaying() || cancionesF[10].isPlaying()) {
  //  myPort.write('4'); //Desamor
  //} else if (cancionesF[15].isPlaying() || cancionesF[5].isPlaying() || cancionesF[1].isPlaying()) {
  //  myPort.write('5'); //Amor
  //} else {
  //  myPort.write('3'); //Neutral
  //}
//}

//void textoPantalla() {
//  fill(0);
//  textAlign(CENTER);
//  textSize(24);

//  String[] textos = {
//    "Pua de Argentina: " + pot1,
//    "Pua de Francia: " + pot2,
//    "Volumen de Argentina: " + pot3,
//    "Volumen de Francia: " + pot4,
//    "Switch: " + switchState
//  };

//  for (int i = 0; i < textos.length; i++) {
//    text(textos[i], width / 2, (height / 2 - 200) + (i * 100));
//  }
//}
