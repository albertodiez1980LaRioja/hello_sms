#include "SMSlib.h" 
//#include "./lib/entities.c"



#define PUÑETAZO 8
#define PUÑETAZO_SALTANDO 16





unsigned char maxSalto = 255;
T_entidad alex = {30, 20, 0, 0, 0};


unsigned char canUp(){
  if (alex.x < 2)
    return 0;
  return 1;
}

unsigned char canDown() {
  if (alex.y > 155)
    return 0;
  return 1;
}

unsigned char canLeft() {
  if (alex.x < 9)
    return 0;
  return 1;
}

unsigned char canRight() {
  if (alex.x > 238)
    return 0;
  return 1;
}

void moveAlexSuelo(int keys) {
  if ((keys & PORT_A_KEY_DOWN)){
    if (keys & PORT_A_KEY_LEFT)
      alex.oriented = 1;
    if (keys & PORT_A_KEY_RIGHT)
      alex.oriented = 0;
    if (!alex.oriented)
      alex.frame = 7;
    else
      alex.frame = 15;
      alex.lastChangeFrame = 15;
    return; // not move
  }
  
  if (keys & PORT_A_KEY_2) {
    if (alex.y > 100)
      maxSalto = alex.y - 100;
    else 
      maxSalto = 0;
    alex.y--;
    return;
  }
  if ((keys & PORT_A_KEY_LEFT) && alex.x > 8 )
  {
    alex.x -= 1;
    alex.oriented = 1;
    alex.lastChangeFrame++;
    if (alex.lastChangeFrame == 11) {
      alex.lastChangeFrame = 0;
      alex.frame++;
    }
    if (alex.frame > 11 || alex.frame < 8)
        alex.frame = 8;
  }
  else if ((keys & PORT_A_KEY_RIGHT) && alex.x <240)
  {
    alex.x += 1;
    alex.oriented = 0;
    alex.lastChangeFrame++;
    if (alex.lastChangeFrame == 11) {
      alex.lastChangeFrame = 0;
      alex.frame++;
    }
    if (alex.frame > 3 || alex.frame < 0)
        alex.frame = 0;
  }
  
  else { // parado
    alex.frame = 4;
    if (alex.oriented)
        alex.frame = 12;
    alex.lastChangeFrame = 10;
  }  
}

void moveAlexAire(int keys, unsigned char puedeSubir, unsigned char puedeDerecha, unsigned char puedeIzquieda) {
  if (keys & PORT_A_KEY_LEFT) {
    alex.oriented = 1;
    if (puedeIzquieda)
      alex.x -= 2;
  }
  if (keys & PORT_A_KEY_RIGHT) {
    alex.oriented = 0;
    if (puedeDerecha)
      alex.x += 2;
  }
  if (!alex.oriented)
    alex.frame = 6;
  else
    alex.frame = 14;
  if (alex.y > maxSalto) {
    alex.y -= 2;
  }
  else {
    alex.y += 2; // bajando
    maxSalto = 255;
  }
}


void moveAlex(int keys) {
  unsigned char puedeBajar = canDown();
  unsigned char puedeSubir = canUp();
  unsigned char puedeDerecha = canRight();
  unsigned char puedeIzquierda = canLeft();
  if (puedeBajar)
    moveAlexAire(keys, puedeSubir, puedeDerecha, puedeIzquierda);
  else
    moveAlexSuelo(keys);
}