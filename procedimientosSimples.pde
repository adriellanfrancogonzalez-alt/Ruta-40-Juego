void todaLaRuta() {
  rectMode(CENTER);
  background(100);
  float anchoPasto=array[1]*3;//pasto de los bordes
  fill(50, 180, 30);

  rect(anchoPasto/2, height/2, anchoPasto, height);

  rect(width-anchoPasto/2, height/2, anchoPasto, height);

  fill(255);

  fill(200, 200, 0);
  rect(width/2-width/180, 0, width/150, height*2);//linea amarilla ruta
  rect(width/2+width/180, 0, width/150, height*2);//linea amarilla ruta
  procedimientoLineaRuta();
}

void textos() {

  textAlign(CENTER);
  fill(0, 0, 0);
  textSize(width/25);
  if (auto.vel.y == auto.maxVel || auto.vel.y == -5) fill(255, 0, 0);
  text("vel: "+ abs(int(auto.vel.y)), array[1], height -height/10);
  fill(0, 0, 0);
  text("vida: "+ int(auto.vida), array[1], height- height/5);
  if (auto.cantBalas==0) fill(255, 0, 0);
  text("balas: "+ auto.cantBalas, array[1], height-height/3.5);
  fill(0, 0, 0);
  if (estadodeljuego==1 && auto.cantBalas > 0 && millis() - auto.ultimoDisparo < auto.coolDown)
    text( int((millis() - auto.ultimoDisparo ) / 100 ) + "/10", array[1], height-height/2);


  text("Tiempo: " + int(millis()/1000), array[11], height- height/10);
  text("km: "+ abs(int(kilometraje)), array[11], height- height/5);
}

void procedimientoLineaRuta() {
  rectMode(CENTER);

  for (int i=0; i<cantLineaRuta; i++)
  {
    lineaRuta1[i].bajar(auto.vel.y, cantLineaRuta);
    lineaRuta1[i].mostrar();
    lineaRuta2[i].bajar(auto.vel.y, cantLineaRuta);
    lineaRuta2[i].mostrar();

    lineaRuta3[i].bajar(auto.vel.y, cantLineaRuta);
    lineaRuta3[i].mostrar();
    lineaRuta4[i].bajar(auto.vel.y, cantLineaRuta);
    lineaRuta4[i].mostrar();
  }
}

void pantallaDeProgramador() {
  textSize(width/50);
  if (is_f) {
    for (int i=0; i<array.length; i++) point(array[i], height/2);
    for (int i=0; i<array.length; i++) point(i/2, height/2);
    fill(200);

    fill(0);
    for (int i=0; i<array.length; i++) text(i, array[i], height/2, 20);
    for (int i=0; i<helicoptero.size(); i++) {
      Enemigos aux= helicoptero.get(0);
      text(aux.vida, width/6, height/3);
    }
  }
}


void balasProce() {

  // BALAS DEL JUGADOR
  for (int i = balaJugador.size() - 1; i >= 0; i--) {
    Balas p = balaJugador.get(i);
    p.mover();

    // Si la bala salió completamente de la pantalla, eliminarla
    if (p.pos.x + p.r/2 < 0 || //sale izq
      p.pos.x - p.r/2 > width || // sale derecha
      p.pos.y + p.r/2 < 0 || //sale arriba
      p.pos.y - p.r/2 > height) { //sale abajo

      balaJugador.remove(i);
    } else {
      p.mostrar();
    }
  }

  // BALAS DEL ENEMIGO
  for (int i = balaEnemigo.size() - 1; i >= 0; i--) {
    Balas p = balaEnemigo.get(i);
    p.mover();

    // Si la bala salió completamente de la pantalla, eliminarla
    if (p.pos.x + p.r/2 < 0 ||
      p.pos.x - p.r/2 > width ||
      p.pos.y + p.r/2 < 0 ||
      p.pos.y - p.r/2 > height) {

      balaEnemigo.remove(i);
    } else {
      p.mostrar();
    }
  }
}
