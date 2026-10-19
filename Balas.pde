
class Balas {
  PVector pos;
  PVector vel;
  float r=width/50;
  float daño=35;


  Balas(float inicioX, float inicioY, float finalX, float finalY) {
    pos= new PVector(inicioX, inicioY);
    //normalizamos la hipotenusa y dividimos los catetos por ella para que siempre tengan la misma velocidad
    float dx = finalX - inicioX;
    float dy = finalY - inicioY;
    float h= dist(inicioX, inicioY, finalX, finalY);
    if(h!=0) vel= new PVector(dx/h*32, dy/h*32);
  }

  Balas(float inicioX, float inicioY, float finalX, float finalY,float velocidad) {
    pos= new PVector(inicioX, inicioY);
    //normalizamos la hipotenusa y dividimos los catetos por ella para que siempre tengan la misma velocidad
    float dx = finalX - inicioX;
    float dy = finalY - inicioY;
    float h= dist(inicioX, inicioY, finalX, finalY);
    if(h!=0) vel= new PVector(dx/h * velocidad, dy/h * velocidad);
  }

  void mover() {
    pos.add(vel);
  }

  void mostrar() {
    fill(227, 53, 5);
    circle(pos.x, pos.y, r);
  }
}
