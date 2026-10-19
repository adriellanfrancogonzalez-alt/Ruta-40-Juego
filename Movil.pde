class Movil {
  PVector pos;
  PVector vel;
  float ancho=array[1]*0.75, alto=height/7;
  float acele=0.1;
  float maxVel;
  float vida=100;
  float ultimaColision=0;//el milisengundo guardado en el que ocurrio la ultima colision
  int cantBalas= 20;
  float ultimoDisparo;
  float coolDown=200;// tiempo que tarda en disparar
  float maxBalas=20;
  Movil() {
    pos= new PVector(width/2.5, height-height/7);
    vel= new PVector(7, 0);
  }
  void mover() {
    if ((is_a || is_LEFT) && pos.x>0) pos.x=pos.x-vel.x;//izquierda

    if ((is_d || is_RIGHT) && pos.x<width-ancho)pos.x=pos.x+vel.x;  //derecha

    if (is_w || is_UP )  vel.y=vel.y+acele;//ACELERAR
    else//desacelerar si no se toca nada
    {
      if (abs(vel.y) <= 7.2)vel.y = 7;
  //    if (vel.y<5) vel.y=vel.y+0.1;  eliminar
//      if (vel.y>5) vel.y=vel.y-0.1;   eliminar 
//SON REDUNDANTES Y EL IF DE ARRIBA LAS REEMPLAZA
    }

   
  }

  void mostrar() {
    if ( !estadoInmune() )
      fill(200, 130, 100);

    if ( estadoInmune() )
      fill(200, 130, 100, 100);

    rect(pos.x, pos.y, ancho, alto);
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
    circle(0, 0, ancho/1.5);
    rect(ancho/14, -alto/10, alto/1.5, ancho/3); 
    //ellipse(0, 0, 24, 24); // La base de la torreta
    rectMode(CENTER);
    popMatrix();
    
    
    
    if(auto.cantBalas>= auto.maxBalas) auto.maxBalas=20;
  }
}
