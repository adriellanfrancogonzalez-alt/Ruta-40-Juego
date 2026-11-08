class Movil {
  PVector pos;
  PVector vel;
  float ancho=array[1]*0.75, alto=height/7;
  float acele=0.1;
  float maxVel= 8;
  float vida=100;
  float ultimaColision=0;//el milisengundo guardado en el que ocurrio la ultima colision
  int cantBalas= 20;
  float ultimoDisparo;
  float coolDown=200;// tiempo que tarda en disparar
  float maxBalas=20;
  float tAux=0; //este tiempo se usa para hacer que baje despues de un segundo de estar adelante el auto en la funcion mover

  Movil() {
    pos= new PVector(width/2.5, height-height/7);
    vel= new PVector(height/175, maxVel); // puse height/175 para que la velocidad cambie si cambia el alto
  }
  void mover() {
    maxVel  = log( ( millis() / 100) +1)  / log(3) + 8;

    if ((is_a || is_LEFT) && pos.x>0) pos.x = pos.x - vel.x;//izquierdaw

    if ((is_d || is_RIGHT) && pos.x < width-ancho) pos.x = pos.x + vel.x;  //derecha
    if (!estadoInmune() ) vel.y=vel.y+acele;
    if (is_w || is_UP )  pos.y=pos.y-2;
    if (is_s || is_DOWN ) pos.y=pos.y+2;
    if ( pos.y <= height/2) {
      if (is_w || is_UP )  vel.y=vel.y + 0.01;
      pos.y=height/2;
    }
  }

  void mostrar(PImage imagen) {

    if ( !estadoInmune() )
      fill(200, 130, 100);
    println(vel.y);
    if ( estadoInmune() )
      fill(200, 130, 100, 100);
    imageMode(CENTER);
    image(imagen, pos.x, pos.y, ancho, alto);
    fill(0);



    pushMatrix();
    // 2. Trasladar el origen de coordenadas a la posición exacta del auto
    translate(auto.pos.x, auto.pos.y);
    float angulo = atan2(mouseY - auto.pos.y, mouseX - auto.pos.x); // O auto.pos.y según el ámbito de la clase
    // 3. Rotar el lienzo en dirección al mouse
    rotate(angulo);

    // 4. Dibujar la torreta (ejemplo: una base circular y un cañón rectangular)
    fill(80);

    //strokeWeight(2);
    rectMode(CORNER);
    //circle(0, 0, ancho/1.5);
    //rect(ancho/14, -alto/10, alto/1.5, ancho/3);
    imageMode(CENTER);
    image(torreta, 0, 0, alto, ancho);
    //ellipse(0, 0, 24, 24); // La base de la torreta
    rectMode(CENTER);
    popMatrix();



    if (auto.cantBalas>= auto.maxBalas) auto.maxBalas=20;
  }
}

class Enemigos {
  PVector pos, vel;
  float ancho=width/20, alto=width/20;
  float vida=100;
  float ultimaColision=0;//el milisengundo guardado en el que ocurrio la ultima colision
  float ultimoDisparo=0;
  PImage heliImg, helice;
  float anguloHelice=0;
  Enemigos(float posInicioX, float posInicioY, float velX, PImage NuevaImagen, PImage NuevaHelice) {
    pos= new PVector(posInicioX, posInicioY);
    vel= new PVector(velX, 0);
    heliImg=NuevaImagen;
    heliImg.resize(int(ancho), int(alto*2.5));
    helice= NuevaHelice;
    helice.resize(int(ancho*2), int(ancho*2) );
  }

  void mover() {
    pos.add(vel);
  }
  void mostrar() {
    if (is_f) rect(pos.x, pos.y, ancho, alto);
    tint(255, vida*3.5);
    imageMode(CENTER);
    image(heliImg, pos.x, pos.y );

    pushMatrix();//helice
    translate(pos.x, pos.y);
    tint(255, vida*0.8);
    anguloHelice=anguloHelice+0.1;
    rotate(anguloHelice);
    image(helice, 0, 0);
    popMatrix();
    noTint();
  }
}





class Camiones {
  PVector pos, vel;
  float ancho= array[1], alto=height/5;
  float vida=100;
  float ultimaColision=0;//el milisengundo guardado en el que ocurrio la ultima colision
  float ultimoDisparo=0;
  Camiones(float posInicioX, float posInicioY) {
    pos = new PVector(posInicioX, posInicioY);
    vel = new PVector( 0, -2);
  }
  void mover() {
    pos.add(vel);

    if (pos.y <= height/3 ) vel.y=0;
  }

  void mostrar() {
    fill(198, 198, 26, vida*2.5);
    rectMode(CENTER);
    rect(pos.x, pos.y, ancho, alto);
  }
}

class Balas {
  PVector pos;
  PVector vel;
  float r = width/100;
  float daño = 20;
  int tipo = -1;

  // Constructor para las balas de todos
  Balas(float inicioX, float inicioY, float finalX, float finalY, int tipo) {
    pos = new PVector(inicioX, inicioY);
    this.tipo = tipo;

    float dx = finalX - inicioX;
    float dy = finalY - inicioY;
    float h = dist(inicioX, inicioY, finalX, finalY);
    float velocidad = 0;

    switch(tipo) {
    case 0: //auto
      velocidad = 30;
      r  = r*1.5;
      break;

    case 1: //helicoptero
      velocidad = 5;
      break;

    case 2: //camion
      velocidad = 2;
      break;
    }

    if (h > 0) {
      vel = new PVector(dx/h * velocidad, dy/h * velocidad);
    } else {
      vel = new PVector(0, 0);
    }
  }

  void mover() {
    pos.add(vel);
  }

  void mostrar() {

    switch(tipo) {
    case 0:
      fill(0, 150, 255); // Auto: azul
      break;

    case 1:
      fill(255, 200, 0); // Helicóptero: amarillo
      break;

    case 2:
      fill(0, 200, 100); // Camión: verde
      break;
    }

    circle(pos.x, pos.y, r);
  }
}
class Obstaculos {
  PVector pos;
  PVector vel;
  float alto=auto.alto;
  float ancho=auto.ancho*0.9;
  float tiempoGuardado=0;
  PImage imagen;
  Obstaculos(float posInicioX, PImage imagen1) {
    pos= new PVector(posInicioX, -ancho);
    imagen=imagen1;
    imagen.resize(int(ancho*1.7), int(alto*1.4));
  }

  void  mover(float velAuto) {
    pos.y=pos.y+velAuto; //bajar conforme la velocidad
  }

  void mostrar() {
    fill(0, 0, 0);
    imageMode(CENTER);
        rect(pos.x,pos.y,ancho,alto);
    image(imagen, pos.x, pos.y);

    imageMode(CORNER);
  }
}
class Suministros extends Obstaculos {

  Suministros(float posInicioX, PImage imagen) {
    super(posInicioX, imagen);
  }
  void mostrar() {

    imageMode(CENTER);
    image(imagen, pos.x, pos.y, array[1], array[1]);
    //rect(pos.x,pos.y, array[1],array[1]);
  }
}
class LineasRuta {
  PVector pos;
  PVector vel;
  int tamX=width/200;
  int tamY=width/12;
  int espacio=tamY*2;


  LineasRuta(float velAuto, int i, float posinicioX) { //linea ruta
    pos= new PVector(posinicioX, tamY*2*i);
    vel= new PVector(0, velAuto);
  }


  void  bajar(float velAuto, int cant) { //RUTA
    pos.y=pos.y+velAuto; //bajar conforme la velocidad
    if ((pos.y-tamY/2)>=height) pos.y=pos.y-espacio*cant; //subir al llegar abajo
    if ((pos.y+tamY/2)<=0) pos.y=pos.y+espacio*cant;
  }


  void mostrar() {

    fill(255, 255, 255);
    rect(pos.x, pos.y, tamX, tamY);
  }
}
