// VERSION 8.6
// SE AGREGARON GRAFICOS

/*
Preguntas para el profe:
 puedo poner el calculo de la velocidad de la bala en el contructor de la misma???
 
 agregar funcion de recibir disparo , hacer que reciba la bala  el camion
 
 */
PImage torreta;
PFont miFuente;
PImage heliImg;
PImage auto1;
PImage arbusto1;
PImage municion1;
PImage botiquin1;
PImage jugador;
PImage helice;
final int cantLineaRuta=15;
float[] array=new float[12];

LineasRuta[] lineaRuta1= new LineasRuta[cantLineaRuta];
LineasRuta[] lineaRuta2= new LineasRuta[cantLineaRuta];
LineasRuta[] lineaRuta3= new LineasRuta[cantLineaRuta];
LineasRuta[] lineaRuta4= new LineasRuta[cantLineaRuta];
Movil auto;
ArrayList <Camiones> camion;
ArrayList <Obstaculos> obst;
ArrayList <Obstaculos> arbol;
ArrayList <Balas> balaJugador;
ArrayList <Balas> balaEnemigo;
ArrayList <Enemigos> helicoptero;
ArrayList <Suministros> muni;
ArrayList <Suministros> botiquin;
int i, cant=50;
int vel=10;
float kilometraje=0 ; // este si es float
float kGuardadoObst=0;
float kGuardadoCamion=0;
float kGuardadoHeli=0;
float kGuardadoMuni=0;
float kGuardadoArbol=0;
float kGuardadoBoti=0;
int ultArrayUsado=0;
int estadodeljuego = 0;
int tComenzarPartida = 0;
int tiempo=0;//este tiempo es el de la partida, no el millis
float tAux=0;

int arrayPorUsar=0;
void setup() {
  // size(800, 600);
  fullScreen();
   background(0);
  resetearValores();
  torreta= loadImage("data/torreta.png");
  heliImg= loadImage("data/helicoptero.png");
  helice= loadImage("data/helice.png");
  arbusto1= loadImage("data/arbusto1.png");
  auto1= loadImage("data/obstaculo1.png");
  municion1= loadImage("data/municion.png");
  botiquin1= loadImage("data/botiquin.png");
  jugador = loadImage("data/jugador.png");
  miFuente = createFont("Sylfaen", 48);
  textFont(miFuente);
  for (int i=0; i<array.length; i++) array[i]=(width/12)*i ;// array de posiciones de objetos

  rectMode(CENTER);
  textAlign(CENTER);

  auto=new Movil();
  camion  = new ArrayList <Camiones>();
  obst = new ArrayList <Obstaculos>();
  arbol = new ArrayList <Obstaculos>();
  balaJugador = new ArrayList <Balas>();
  balaEnemigo = new ArrayList <Balas>();
  helicoptero = new ArrayList <Enemigos>();
  muni = new ArrayList <Suministros>();
  botiquin = new ArrayList <Suministros>();
  for (int i=0; i<cantLineaRuta; i++) lineaRuta1[i] = new LineasRuta(auto.vel.y, i, array[1]*4);
  for (int i=0; i<cantLineaRuta; i++) lineaRuta2[i] = new LineasRuta(auto.vel.y, i, array[1]*5 );
  for (int i=0; i<cantLineaRuta; i++) lineaRuta3[i] = new LineasRuta(auto.vel.y, i, array[1]*7 );
  for (int i=0; i<cantLineaRuta; i++) lineaRuta4[i] = new LineasRuta(auto.vel.y, i, array[1]*8 );
}

void draw() {
  kilometraje  = kilometraje + auto.vel.y * 0.00005;
  tiempo=millis()- tComenzarPartida ;
  //PUNTAJES
  if (estadodeljuego == -1) {
    background(0);
    fill(255);
    text("PUNTAJES", width/2, height/10);

    if ( boton(width/10, height/15, width/10, height/20, color(200, 0, 0), "INICIO") && mousePressed ) estadodeljuego = 0;
  }
  // MENÚ INICIAL
  if (estadodeljuego == 0) {
       
     fill(20, 100, 120,80);
    rect(width/2, height/2, width, height);

    fill(255);
    textSize(80);
    text("Ruta 40", width/2, height/4);
    if ( boton(width/2, height/2, width/5, height/12, color(0, 160, 0), "JUGAR") && mousePressed ) {
      estadodeljuego = 1;
      mousePressed = false; // para que no se quite una bala apenas se inicia
    }

    if ( boton(width/2, height/1.6, width/5, height/12, color(0, 160, 0), "PUNTAJES") && mousePressed ) estadodeljuego = -1;
  }

  // JUEGO
  if (estadodeljuego == 1) {
    if (mousePressed && estadodeljuego==1) disparar();
    if (is_p) noLoop();
    if (auto.cantBalas>=auto.maxBalas) auto.cantBalas=20;
    todaLaRuta();
    proceObst();
    proceArbol();
    proceSuministros();
    balasProce();

    proceHelicoptero();
    proceBotiquin();
    recibirDispDelEnemigo();
    recibirDispDelJugador();

    proceAuto();
    colisionarConObst();
    colisionarConArbol();
    textos();
    rectMode(CORNER);
    //variable q queremos cambiar, min y max de esa varible y dsp min y max del ancho del rectangulo
    barrasEstado();
    proceCamion();



    // SI MUERE GAME OVER
    if (auto.vida < 1 && estadodeljuego == 1)estadodeljuego = 2;
  }

  // PANTALLA GAME OVER
  if (estadodeljuego == 2) {
    // noLoop();
    rectMode(CENTER);

    fill(50, 0, 0, 5);
    rect(width/2, height/2, width, height);
    textSize(height/10);
    fill(150, 50, 50, 15);
    text("GAME OVER", width/2, height/2);
    textSize(height/20);
    text("Tu kilometraje: " + int(kilometraje), width/2, height-height/6);
    if (boton(width/2, height - height/3, width /3, height/ 6, color(100, 0, 100), "VOLVER A JUGAR") && mousePressed )
    {
      mousePressed = false;
      setup();
      loop();
    }
  }


  if ( estadoInmune() ) {
    rectMode(CENTER);
    fill(255, 0, 0, 80);
    rect(width/2, height/2, width, height);
  }
  pantallaDeProgramador();
}
