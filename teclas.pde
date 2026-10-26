boolean is_w, is_s, is_a, is_d,is_f,is_p;
boolean is_UP, is_DOWN, is_RIGHT, is_LEFT,is_SPACE;


void keyPressed() {
  if (key== 'w' || key== 'W' )is_w=true;
  if (key== 's' ||key== 'S' )is_s=true;
  if (key== 'a' ||key=='A')is_a=true;
  if (key== 'd' ||key== 'D' )is_d=true;
  if (key== 'f' ||key== 'F' )is_f=true;
    if (key== 'p' ||key== 'P' )is_p=true;
  if (keyCode==UP)is_UP=true;
  if (keyCode==DOWN)is_DOWN=true;
  if (keyCode==LEFT)is_LEFT=true;
  if (keyCode==RIGHT)is_RIGHT=true;
  if(keyCode==32)is_SPACE=true;
}




void keyReleased() {
  if (key== 'w' ||key== 'W' )is_w=false;
  if (key== 's' ||key== 'S' )is_s=false;
  if (key== 'a' ||key== 'A' )is_a=false;
  if (key== 'd' ||key== 'D' )is_d=false;
  if (key== 'f' ||key== 'F' )is_f=false;
     if (key== 'p' ||key== 'P' )is_p=false;
  if (keyCode==UP)is_UP=false;
  if (keyCode==DOWN)is_DOWN=false;
  if (keyCode==LEFT)is_LEFT=false;
  if (keyCode==RIGHT)is_RIGHT=false;
  if(keyCode==32)is_SPACE=false;
  
}
