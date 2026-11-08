
void proceObst() {
  aparecerObst();
  recorrerObst();
  eliminarObst();
}
void proceArbol() {
  aparecerArbol();
  recorrerArbol();
  eliminarArbol();
}
void proceHelicoptero() {
  aparecerHeli();
  recorrerHeli();
  eliminarHeli();
  dispararHeli();
}
void proceSuministros() {
  aparecerSumi();
  recorrerSumi();
  eliminarSumi();
}

void proceBotiquin() {
  aparecerBoti();
  recorrerBoti();
  eliminarBoti();
}

void proceCamion() {
  for (Camiones p : camion) {
    p.mostrar();
    p.mover();
  }

  dispararCamion();
  if (kilometraje - kGuardadoCamion > 1  && camion.size() == 0) {
    kGuardadoCamion = kilometraje;
    camion.add(new Camiones( array[9] - array[1]/2, height - height/15) );
  }

  for (int i= camion.size() -1; i >= 0; i--) {//eliminar helicoptero
    Camiones camionAux = camion.get(i);
    if (camionAux.vida <= 0 ) {
      camion.remove(i);
      kGuardadoCamion=tiempo;
    }
  }
}


void dispararCamion() {
  for (Camiones p : camion) {
    if (tiempo -p.ultimoDisparo > 1000 && p.pos.y <= height* 2/3) {
      p.ultimoDisparo = tiempo;
      balaEnemigo.add(new Balas(p.pos.x+random(-40, 40), p.pos.y, auto.pos.x, auto.pos.y, 2) );
    }
  }
}
void colisionarConObst() {
  for (Obstaculos g : obst) {
    Movil a = auto;
    if ( !estadoInmune() && hayColision( a.pos.x, a.pos.y, a.ancho, a.alto, g.pos.x, g.pos.y, g.ancho*0.75) )
    {
      a.vida=0;
      a.vel.y=a.vel.y/2;
      auto.ultimaColision=tiempo;
      return;
    }
  }
}

void colisionarConArbol() {
  for (Obstaculos g : arbol) {
    Movil a = auto;
    if ( !estadoInmune() && hayColision( a.pos.x, a.pos.y, a.ancho, a.alto, g.pos.x, g.pos.y, g.ancho) )
    {
      a.vida=a.vida-10;
      a.vel.y=a.vel.y/2;
      auto.ultimaColision=tiempo;
      return;
    }
  }
}






void proceAuto() {
  auto.mover();
  auto.mostrar(jugador);

  float aux = auto.maxVel;
  if (auto.vel.y>=auto.maxVel) auto.vel.y=auto.maxVel;// IF PARA NO SUPERAR MAXIMAS VELOCIDADES

  if ( auto.pos.x -auto.ancho/2<= array[1]*3 || auto.pos.x+auto.ancho/2 >= width - array[1]*3) {//daño si esta en el pasto

    if (tiempo - tAux > 100) {
      auto.vida = auto.vida - 1;
      tAux= tiempo;
    }
  } else auto.maxVel = aux ;
}

void disparar() {
  if (estadodeljuego==1 && auto.cantBalas > 0 && tiempo - auto.ultimoDisparo > auto.coolDown ) {
    balaJugador.add(new Balas(auto.pos.x, auto.pos.y, mouseX, mouseY, 0 ));
    auto.cantBalas--; // se le resta una bala
    auto.ultimoDisparo= tiempo;
  }
}
////////////////////////////////////////////////////////////////////////////
void aparecerObst() {
  if (kilometraje- kGuardadoObst >= random(0.05, 0.15)) {
    kGuardadoObst= kilometraje;
    //posicion inicial en x
    do {
      arrayPorUsar= int(random(3, 8));
    } while (ultArrayUsado == arrayPorUsar);

    ultArrayUsado = arrayPorUsar;
    obst.add( new Obstaculos(  array[arrayPorUsar] +array[1]/2, auto1) );
  }
}
void recorrerObst() {
  for (Obstaculos p : obst) {
    p.mover(auto.vel.y);
    p.mostrar();
  }
}

void eliminarObst() {
  for ( i= obst.size()-1; i >=0; i--) {
    Obstaculos g = obst.get(i);
    if (g.pos.y-g.ancho >=height) obst.remove(i); //desaparecer si se va
  }
}


void aparecerArbol() {
  if (kilometraje - kGuardadoArbol >= random(0.02, 0.05)) {
    kGuardadoArbol= kilometraje ;
    //posicion inicial en x

    //primero saca una prob de 50 50 si(?) es menor que 0.5 saca el primer random, y si no(:) , saca el segundo.d
    // ?  si pasa esto entonces pasa esto
    // : si no paso lo anterior entonces pasa esto
    float numeroAleatorio= random(1) < 0.5 ? random(0, 2) : random(9, 12);
    arbol.add( new Obstaculos(  array[int(numeroAleatorio)] +array[1]/2, arbusto1 ) );
  }
}
void recorrerArbol() {
  for (Obstaculos p : arbol) {
    p.mover(auto.vel.y);
    p.mostrar();
  }
}
void eliminarArbol() {
  for ( i= arbol.size()-1; i >=0; i--) {
    Obstaculos g = arbol.get(i);
    if (g.pos.y-g.ancho >=height) arbol.remove(i);
  }
}
void aparecerHeli() {
  if ( kilometraje -kGuardadoHeli >= 0.5) {//aparecer helicoptero
    kGuardadoHeli= kilometraje ;
    int direccionHelipX = int(random(2));//ver si va a la derecha o a la izquierda
    if (direccionHelipX == 0) direccionHelipX=-1; // si es cero que vaya a la izquierda
    do {
      helicoptero.add( new Enemigos (random(array[1], array[11]), height/9, 1 * direccionHelipX, heliImg, helice) ); //posicion inicial en x
    } while (random(1) < 0.2);
  }
}
void recorrerHeli() {

  for (int i= helicoptero.size() -1; i>= 0; i--) {//ejecutar helicoptero
    Enemigos p = helicoptero.get(i);
    p.mostrar();
    p.mover();
    if (p.pos.x >= array[1] ) p.vel.x = p.vel.x * -1 ;
    if (p.pos.x <= array[11]) p.vel.x = p.vel.x * -1 ;
  }
}

void eliminarHeli() {
  for (int i= helicoptero.size() -1; i >= 0; i--) {//eliminar helicoptero
    Enemigos enemigoAux = helicoptero.get(i);
    if (enemigoAux.vida <= 0 ) {
      helicoptero.remove(i);
    }
  }
}
void dispararHeli() {
  for (Enemigos p : helicoptero) {
    if (tiempo -p.ultimoDisparo > random(3000, 9000) ) {
      p.ultimoDisparo = tiempo;
      balaEnemigo.add(new Balas(p.pos.x+random(-40, 40), p.pos.y, auto.pos.x, auto.pos.y, 2) );
    }
  }
}

void aparecerSumi() {
  if (kilometraje - kGuardadoMuni >= random(0.5, 2)) {   //APARECER
    kGuardadoMuni = kilometraje;
    do {
      arrayPorUsar= int(random(3, 8));
    } while (ultArrayUsado == arrayPorUsar);
    ultArrayUsado = arrayPorUsar;
    muni.add( new Suministros(  array[arrayPorUsar] +array[1]/2, municion1 ) );
  }
}

void recorrerSumi() {
  for ( Suministros p : muni) { //MOSTRAR
    p.mover(auto.vel.y);
    p.mostrar();
  }
}

void eliminarSumi() {
  for ( i=muni.size() -1; i >= 0; i--) {  //ELIMINAR
    Suministros m = muni.get(i);
    if ( hayColision(auto.pos.x, auto.pos.y, auto.ancho, auto.alto, m.pos.x, m.pos.y, m.ancho) ) {
      auto.cantBalas = auto.cantBalas + 10;
      muni.remove(i);
    }
    if (m.pos.y - m.alto >= height) muni.remove(i);
  }
}

void aparecerBoti() {
  if (kilometraje - kGuardadoBoti >= random(0.5, 3)) {   //APARECER
    kGuardadoBoti = kilometraje;
    do {
      arrayPorUsar= int(random(3, 8));
    } while (ultArrayUsado == arrayPorUsar);
    ultArrayUsado = arrayPorUsar;
    botiquin.add( new Suministros(  array[arrayPorUsar] +array[1]/2, botiquin1 ) );
  }
}

void recorrerBoti() {
  for ( Suministros p : botiquin) { //MOSTRAR
    p.mover(auto.vel.y);
    p.mostrar();
  }
}

void eliminarBoti() {
  for ( i=botiquin.size() -1; i >= 0; i--) {  //ELIMINAR
    Suministros m =botiquin.get(i);
    if ( hayColision(auto.pos.x, auto.pos.y, auto.ancho, auto.alto, m.pos.x, m.pos.y, m.ancho) ) {
      auto.vida= auto.vida + 20;
      if (auto.vida>=100) auto.vida=100;
      botiquin.remove(i);
      return;
    }
    if (m.pos.y - m.alto >= height) {
      botiquin.remove(i);
      return;
    }
  }
}
