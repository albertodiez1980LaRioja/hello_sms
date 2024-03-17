#include "SMSlib.h" 
//#include "./lib/entities.c"



#define EN_SUELO 2
#define SALTANDO 4
#define PUÑETAZO 8
#define PUÑETAZO_SALTANDO 16




int vY = 0, finSalto;
unsigned char maxSalto = 255;
T_entidad alex = {30, 20, 0, 0, EN_SUELO};

void moveAlexOLD(int keys)
{
  if ((keys & PORT_A_KEY_DOWN) && alex.state == EN_SUELO){
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


  if (alex.state == PUÑETAZO) {
    alex.lastChangeFrame++;
    if (alex.lastChangeFrame % 16 == 0)
    {
      alex.state = EN_SUELO;
      if (!alex.oriented)
        alex.frame = 0;
      if (alex.oriented)
        alex.frame = 8;
    }
    return;
  }

    if (alex.state == PUÑETAZO_SALTANDO) {
    alex.lastChangeFrame++;
    if (alex.lastChangeFrame % 16 == 0)
    {
      alex.state = SALTANDO;
      if (!alex.oriented)
        alex.frame = 5;
      else
        alex.frame = 13; 
    }
    return;
  }

  int player_v_x = 0;
  if ((keys & PORT_A_KEY_LEFT) && alex.x > 8 )
  {
    player_v_x = -1;
    alex.oriented = 1;
    if (alex.frame < 8 || alex.frame > 11)
        alex.frame = 8;
  }
  else if ((keys & PORT_A_KEY_RIGHT) && alex.x <240)
  {
    player_v_x = 1;
    alex.oriented = 0;
  }
  else { // parado
    player_v_x = 0;
    alex.frame = 4;
    if (alex.oriented)
        alex.frame = 12;
    alex.lastChangeFrame = 15;
  }
  alex.x = alex.x + player_v_x;
  if (player_v_x != 0){
    alex.lastChangeFrame++;
    if (alex.lastChangeFrame % 16 == 0)
    {
        alex.frame++;
        if (alex.frame > 3 && !alex.oriented)
            alex.frame = 0;
        if (alex.frame > 11 && alex.oriented)
            alex.frame = 8;
            
    }
  }
  if ((keys & PORT_A_KEY_1) && alex.state == EN_SUELO) {
    alex.state = SALTANDO;
    finSalto = alex.y - 70;
    vY = -2;
  }
  if (alex.state == SALTANDO || alex.state == PUÑETAZO_SALTANDO) {
    if(alex.state == SALTANDO) {
      if (!alex.oriented)
        alex.frame = 6;
      else
        alex.frame = 14;
    }
    if(alex.y == EN_SUELO || alex.y == 1 || alex.y < finSalto) {
      vY = 2;
    }
    if ((alex.y == 150 || alex.y == 151) && vY > 0) {
      alex.state = EN_SUELO;
      vY = 0;
      alex.frame = 0;
    }
  }
  alex.y += vY;
  if ((keys & PORT_A_KEY_2) && alex.state == EN_SUELO){
    alex.state = PUÑETAZO;
    if (!alex.oriented)
    alex.frame = 5;
    else
     alex.frame = 13; 
    alex.lastChangeFrame = 0;
  }
  if ((keys & PORT_A_KEY_2) && alex.state == SALTANDO){
    alex.state = PUÑETAZO_SALTANDO;
    if (!alex.oriented)
      alex.frame = 5;
    else
     alex.frame = 13; 
    alex.lastChangeFrame = 0;
  }

}


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