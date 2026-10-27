class Obstaculos {
  PVector pos;
  PVector vel;

  float alto=auto.alto;
  float ancho=auto.ancho;
  float tiempoGuardado=0;
  PImage imagen;
  Obstaculos(float posInicioX, PImage imagen1) {
    pos= new PVector(posInicioX, -ancho);
    imagen=imagen1;
  }

  void  mover(float velAuto) {
    pos.y=pos.y+velAuto; //bajar conforme la velocidad
  }

  void mostrar() {
    fill(0, 0, 0);


    imageMode(CENTER);
    rect(pos.x, pos.y, ancho, alto);
    image(imagen, pos.x, pos.y, ancho, alto);
    imageMode(CORNER);
  }
}
