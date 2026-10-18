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
