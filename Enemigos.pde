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
 Camiones(float posInicioX, float posInicioY){
   pos = new PVector(posInicioX, posInicioY);
   vel = new PVector( 0 , -2);
 }
  void mover() {
    pos.add(vel);
    
    if(pos.y <= height/3 ) vel.y=0;
  }
  
  void mostrar(){
    fill(198,198,26,vida*2.5);
    rectMode(CENTER);
     rect(pos.x, pos.y, ancho, alto);
  }

  
  
}
