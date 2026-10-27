// VERSION 8.2
// SE AGREGARON GRAFICOS

/*
Preguntas para el profe:
 puedo poner el calculo de la velocidad de la bala en el contructor de la misma???
 
 
 
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
float tGuardadoObst=0;
LineasRuta[] lineaRuta1= new LineasRuta[cantLineaRuta];
LineasRuta[] lineaRuta2= new LineasRuta[cantLineaRuta];
LineasRuta[] lineaRuta3= new LineasRuta[cantLineaRuta];
LineasRuta[] lineaRuta4= new LineasRuta[cantLineaRuta];
Movil auto;

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
int tGuardadoHeli=0;
int tGuardadoMuni=0;
int tGuardadoArbol=0;
int tGuardadoBoti=0;
int ultArrayUsado=0;
int estadodeljuego = 0;
int tComenzarPartida = 0;
int tiempo=0;//este tiempo es el de la partida, no el millis
float tAux=0;

int arrayPorUsar=0;
void setup() {
  size(800, 600);
  //fullScreen();
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
  kilometraje = (millis() - tComenzarPartida)* 0.0001;
  tiempo=millis()- tComenzarPartida;

  // MENÚ INICIAL
  if (estadodeljuego == 0) {
    background(20, 100, 120);
    fill(255);
    textSize(80);
    text("Ruta 40", width/2, height/4);
    fill(0, 100, 0);
    rect(width/2, height/2, width/4, height/7);
    textSize(30);
    fill(0, 200, 0);
    text("Jugar", width/2, height/2);
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
    auto.mover();
    auto.mostrar(jugador);
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




    // SI MUERE GAME OVER
    if (auto.vida < 1 && estadodeljuego == 1)estadodeljuego = 2;
  }

  // PANTALLA GAME OVER
  if (estadodeljuego == 2) {
    noLoop();
    rectMode(CENTER);
    background(50, 0, 0);
    fill(100, 0, 0);
    rect(width/2, height/2+height/6, width/3, height/7);
    textSize(height/10);
    fill(255);
    text("GAME OVER", width/2, height/2);
    textSize(height/20);
    text("Volver a Jugar", width/2, height- height/3);
    textSize(height/20);
    text("Tu kilometraje: " + int(kilometraje), width/2, height-height/6);
  }


  if ( estadoInmune() ) {
    rectMode(CENTER);
    fill(255, 0, 0, 80);
    rect(width/2, height/2, width, height);
  }
  pantallaDeProgramador();
}
