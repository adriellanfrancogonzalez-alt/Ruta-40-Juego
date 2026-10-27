class Enemigos {
  PVector pos;
  PVector vel;
  float ancho=array[1], alto=width/10;
  float vida=100;
  float ultimaColision=0;//el milisengundo guardado en el que ocurrio la ultima colision
  float ultimoDisparo=0;
  PImage imagen;
float anguloHelice=0;
  Enemigos(float posInicioX, float posInicioY, float velX, PImage NuevaImagen) {
    pos= new PVector(posInicioX, posInicioY);
    vel= new PVector(velX, 0);
    imagen=NuevaImagen;
  }

  void mover() {
    pos.add(vel);
  }
  void mostrar() {
    tint(255, vida*3.5);

    imageMode(CENTER);
    image(imagen, pos.x, pos.y, ancho +heliImg.width/4, alto + heliImg.height/5 );
   /* pushMatrix();
    translate(pos.x, pos.y);
    tint(255, vida*0.8);
    anguloHelice=anguloHelice+0.1;
  
    rotate(anguloHelice);
    image(helice,0, 0, ancho +heliImg.width/4, alto + heliImg.height/5 );
    popMatrix();
    noTint();*/
  }
}
