class Suministros extends Obstaculos{
  
  Suministros(float posInicioX,PImage imagen){
     super(posInicioX,imagen);
     
  }
  void mostrar(){
    fill(245,237,7);
    imageMode(CENTER);
    image(imagen,pos.x ,pos.y , array[1], array[1]);
//rect(pos.x,pos.y, array[1],array[1]); 
   
  }
}
