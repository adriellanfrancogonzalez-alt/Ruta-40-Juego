void mousePressed() {
  if (dist(mouseX, mouseY, width/2, height/2) <= height/4 && estadodeljuego==0) {
    estadodeljuego = 1;
    return;
  }
  if (dist(mouseX, mouseY, width/2, height/2 + height/6) <=height/3 && estadodeljuego==2){
    setup();
    loop();
  }
}




//el elemento 1 es el auto que es chocado, y el elemento 2 es el circulo que lo choca
boolean hayColision(float posX1, float posY1, float ancho1, float alto1, float posX2, float posY2, float radio) {
  //CALCULAR EL PUNTO MAS CERCANO, NO SE NECESITA EL ANCHO Y ALTO DEL CIRCULO(ancho2,alto2) asi que lo cambiamos por radio
  PVector puntoC = new PVector(0, 0);
  if (posX2<posX1-ancho1/2) puntoC.x=posX1-ancho1/2;
  else if (posX2>posX1+ancho1/ 2) puntoC.x=posX1+ancho1/2;
  else puntoC.x=posX2;
  if (posY2<posY1-alto1/2) puntoC.y=posY1-alto1/2;
  else if (posY2>posY1+alto1/2) puntoC.y=posY1+alto1/2;
  else puntoC.y=posY2;

  //preguntarse si el punto mas cercano choca con el circulo
  // circle(puntoC.x, puntoC.y, 10);
  if (dist(puntoC.x, puntoC.y, posX2, posY2)<=radio/2 ) {
    return true;
  } else return false;
}
void obstProce() {

  //   calcula el tiempo que paso, si paso mas del tiempo dicho se ejecuta
  if (tiempo- tGuardadoObst >= random(500, 3000)) {
    tGuardadoObst=millis();
    //posicion inicial en x
    do {
      arrayPorUsar= int(random(3, 8));
    } while (ultArrayUsado == arrayPorUsar);
    
    ultArrayUsado = arrayPorUsar;
    obst.add( new Obstaculos(  array[arrayPorUsar] +array[1]/2, auto1) );
  }
  for (Obstaculos p : obst) {
    p.mover(auto.vel.y);
    p.mostrar();
  }

  for ( i= obst.size()-1; i >=0; i--) {
    Obstaculos g = obst.get(i);
    if (g.pos.y-g.ancho >=height) obst.remove(i); //desaparecer si se va
  }
}
void arbolProcedimiento() {

  //   calcula el tiempo que paso, si paso mas del tiempo dicho se ejecuta
  if (tiempo- tGuardadoArbol >= random(200, 1000)) {
    tGuardadoArbol=millis();
    //posicion inicial en x
    
    //primero saca una prob de 50 50 si(?) es menor que 0.5 saca el primer random, y si no(:) , saca el segundo.d
    // ?  si pasa esto entonces pasa esto
    // : si no paso lo anterior entonces pasa esto
float numeroAleatorio= random(1) < 0.5 ? random(0,2) : random(9,12);
    arbol.add( new Obstaculos(  array[int(numeroAleatorio)] +array[1]/2 ,arbusto1 ) );
  }
  for (Obstaculos p : arbol) {
    p.mover(auto.vel.y);
    p.mostrar();
  }

  for ( i= arbol.size()-1; i >=0; i--) {
    Obstaculos g = arbol.get(i);
    if (g.pos.y-g.ancho >=height) arbol.remove(i); 
  }
}
void helicopteroProcedimiento() {
  if (tiempo-tGuardadoHeli >= random(5000, 10000)) {
    tGuardadoHeli= millis();
    int direccionHelipX = int(random(2));//ver si va a la derecha o a la izquierda
    if (direccionHelipX == 0) direccionHelipX=-1; // si es cero que vaya a la izquierda
    helicoptero.add( new Enemigos (random(array[1], array[11]), height/10, 1 * direccionHelipX,heliImg) ); //posicion inicial en x
    if(random(1) < 0.5)helicoptero.add( new Enemigos (random(array[1], array[11]), height/10, 1 * direccionHelipX,heliImg) );
    if(random(1) < 0.25)helicoptero.add( new Enemigos (random(array[1], array[11]), height/10, 1 * direccionHelipX,heliImg) );
    if(random(1) < 0.1)helicoptero.add( new Enemigos (random(array[1], array[11]), height/10, 1 * direccionHelipX,heliImg) );
     if(random(1) < 0.01)helicoptero.add( new Enemigos (random(array[1], array[11]), height/10, 1 * direccionHelipX,heliImg) );//posicion inicial en x
  }
  for (int i= helicoptero.size() -1; i >= 0; i--) {// si el enemigo no tiene vida desaparece
    Enemigos enemigoAux = helicoptero.get(i);
    if (enemigoAux.vida <= 0 ) {
      helicoptero.remove(i);
    }
  }

  for (Enemigos p : helicoptero) {//REBOTAR
    p.mostrar();
    p.mover();
    if (p.pos.x >= array[1]) p.vel.x = p.vel.x * -1 ;
    if (p.pos.x <= array[11]) p.vel.x = p.vel.x * -1 ;
  }
  for (Enemigos p : helicoptero) {//DISPARAR AL JUGADOR

    if (tiempo -p.ultimoDisparo > random(3000, 9000) ) {
      p.ultimoDisparo = millis();



      balaEnemigo.add(new Balas(p.pos.x+random(-40,40), p.pos.y, auto.pos.x, auto.pos.y, 6) );
    }
  }
}

void recibirDispDelJugador() {


  for (int i= balaJugador.size() -1; i>=0; i--) {
    Balas balaAux = balaJugador.get(i);
    for (Enemigos e : helicoptero) {
      //detectar si hay colision
      if ( hayColision( e.pos.x, e.pos.y, e.ancho, e.alto, balaAux.pos.x, balaAux.pos.y, balaAux.r) ) {//paso un segundo desde la ultima colision?
        e.vida=e.vida - balaAux.daño;
        e.ultimaColision = tiempo;
        balaJugador.remove(i);
        break;//si un objeto solo puede producir un impacto, después de procesar ese impacto no sigas buscando otros impactos para el mismo objeto.
      }
    }
  }
}



void recibirDispDelEnemigo() {


  for (int i= balaEnemigo.size() -1; i>=0; i--) {
    Balas b = balaEnemigo.get(i);
    Movil a = auto;

    if (hayColision( a.pos.x, a.pos.y, a.ancho, a.alto, b.pos.x, b.pos.y, b.r) ) {//paso un segundo desde la ultima colision?
      if ( !estadoInmune() ) {
        a.vida=a.vida - b.daño/2;
        a.ultimaColision = tiempo;
      }
      balaEnemigo.remove(i);
      return;
    }
  }
}


void colisionarConObst() {

  for (Obstaculos g : obst) {
    Movil a = auto;
    if ( !estadoInmune() && hayColision( a.pos.x, a.pos.y, a.ancho, a.alto, g.pos.x, g.pos.y, g.ancho*0.75) )
    {

      a.vida=a.vida-10;
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


boolean estadoInmune() {
  return auto.ultimaColision != 0  &&
    millis() - auto.ultimaColision <= 500;
}


void disparar() {
  if (estadodeljuego==1 && auto.cantBalas >0 && millis() - auto.ultimoDisparo > auto.coolDown ) {
    balaJugador.add(new Balas(auto.pos.x, auto.pos.y, mouseX, mouseY));
    auto.cantBalas--; // se le resta una bala
    auto.ultimoDisparo= tiempo;
  }
}

void suministroProcedimiento() {
  if (tiempo- tGuardadoMuni >= random(10000, 12000)) {   //APARECER
    tGuardadoMuni=tiempo;
    do {
      arrayPorUsar= int(random(3, 8));
    } while (ultArrayUsado == arrayPorUsar);
    ultArrayUsado = arrayPorUsar;
    muni.add( new Suministros(  array[arrayPorUsar] +array[1]/2,municion1 ) );
  }

  for ( Suministros p : muni) { //MOSTRAR
    p.mover(auto.vel.y);
    p.mostrar();
  }
  for ( i=muni.size() -1; i >= 0; i--) {  //ELIMINAR
    Suministros m = muni.get(i);
    if ( hayColision(auto.pos.x, auto.pos.y, auto.ancho, auto.alto, m.pos.x, m.pos.y, m.ancho) ) {
      auto.cantBalas = auto.cantBalas + 10;
      muni.remove(i);
      }
       if (m.pos.y - m.alto >= height) muni.remove(i);
    
  }
}

void botiquinProcedimiento() {
  if (tiempo- tGuardadoBoti >= random(10000, 18000)) {   //APARECER
    tGuardadoBoti=tiempo;
    do {
      arrayPorUsar= int(random(3, 8));
    } while (ultArrayUsado == arrayPorUsar);
    ultArrayUsado = arrayPorUsar;
    botiquin.add( new Suministros(  array[arrayPorUsar] +array[1]/2, botiquin1 ) );
  }

  for ( Suministros p : botiquin) { //MOSTRAR
    p.mover(auto.vel.y);
    p.mostrar();
  }
  for ( i=botiquin.size() -1; i >= 0; i--) {  //ELIMINAR
    Suministros m =botiquin.get(i);
    if ( hayColision(auto.pos.x, auto.pos.y, auto.ancho, auto.alto, m.pos.x, m.pos.y, m.ancho) ) {
      auto.vida= auto.vida + 20;
      if(auto.vida>=100) auto.vida=100;
      botiquin.remove(i);
      return;
    }
    if (m.pos.y - m.alto >= height) {
      botiquin.remove(i);
      return;
    }
  }
}

void movilProce(){
  
  if (auto.vel.y>=auto.maxVel) auto.vel.y=auto.maxVel;// IF PARA NO SUPERAR MAXIMAS VELOCIDADES
    if ( auto.pos.x -auto.ancho/2<= array[1]*3 || auto.pos.x+auto.ancho/2 >= width - array[1]*3){
      if(tiempo - tAux > 100) {
        auto.vida = auto.vida - 1;
        tAux= tiempo;
      }      
      auto.maxVel=5; // BAJAR MAXVEL SI TOCA PASTO
    }
    else auto.maxVel= 10; 
  
}
