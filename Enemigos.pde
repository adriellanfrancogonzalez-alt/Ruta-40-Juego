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






/* como calcular la velocidad del avion:
 dist(pos.x, pos.y, w/2, h/2);
 
 void mover(){
 
 float d= dist(lo d arriba);
 d= map (d, 0 , width/2, 0.1,5); // paneamos la magnitud
 vel.mag(d); // se lo agregamos al PVector
 pos.add(vel);
 }
 
 */
class Aviones {
  PVector pos, vel;
  float ancho=width/5, alto=width/5;
  float finalX, finalY, dx, dy, inicioX, inicioY;
  float vida=100;
  float ultimaColision=0;//el milisengundo guardado en el que ocurrio la ultima colision
  float ultimoDisparo=0;
  PImage AviImg;
  boolean faseInicio=true;
  Aviones(float nInicioX, float nInicioY, float nFinalX, float nFinalY) {
    pos= new PVector(nInicioX, nInicioY);
    finalX=nFinalX;
    finalY=nFinalY;
    dx = finalX - inicioX;
    dy = finalY - inicioY;

    float h= dist(inicioX, inicioY, finalX, finalY);
    if (h!=0) vel= new PVector(dx/h, dy/h);
  }

  void mover() {
    
   // float m = dist(pos.x, pos.y, width/2, height/2);
    //  vel.setMag(m/50);
      pos.add(vel);
    //if (faseInicio) {
     // float m = dist(pos.x, pos.y, width/2, height/2);
     // vel.setMag(m/50);
    //  pos.add(vel);
   // }
   // if (!faseInicio) {
      //float m = dist(width/2-50, height/2-50, pos.x, pos.y);
   //   vel.setMag(m/50);
   //   pos.add(vel);
  //  }
  }
  void mostrar() {
    line(pos.x,pos.y , finalX,finalY);
    circle(width/2,height/2,10);
    rectMode(CENTER);
    circle(pos.x,pos.y,ancho);
  }
}
