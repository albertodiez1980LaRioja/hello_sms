
#ifndef ALEX_INCLUDED
  #include "alex.h"
#endif


unsigned char canUp(void){
  if (alex.x < 2)
    return 0;
  return 1;
}

unsigned char canDown(void) {
  if (alex.y > 153)
    return 0;
  return 1;
}

unsigned char canLeft(void) {
  if (alex.x < 9)
    return 0;
  return 1;
}

unsigned char canRight(void) {
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
    alex.y--;
    SMS_saveROMBank();
    SMS_mapROMBank(3);
    PSGSFXPlay(salto_psg, SFX_CHANNEL1);
    SMS_restoreROMBank();
    return;
  }
  else if (keys & PORT_A_KEY_1) {
    alex.state = PUÑETAZO_SUELO;
    alex.lastChangeFrame = 15;
  }
  if(alex.state != PUÑETAZO_SUELO) {
    SpriteTableY2[4] = 234;
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
      if (alex.frame > 3)
          alex.frame = 0;
    }
    
    else { // parado
      alex.frame = 4;
      if (alex.oriented)
          alex.frame = 12;
      alex.lastChangeFrame = 10;
    }  
  }
  else{
    if (!alex.oriented) {
      alex.frame = 5;
      //SMS_addSprite (alex.x + 16, alex.y + 9, 9);
      SpriteTableXN2[8] = alex.x + 16;
      SpriteTableXN2[9] = 9;
      SpriteTableY2[4] = alex.y + 9;
    }
    else {
      alex.frame = 13;
      //SMS_addSprite (alex.x - 8,  alex.y + 9, 11);
      SpriteTableXN2[8] = alex.x - 8;
      SpriteTableXN2[9] = 11;
      SpriteTableY2[4] = alex.y + 9;
    }
    alex.lastChangeFrame--;
    if(!alex.lastChangeFrame) {
      alex.state = 0;
      SpriteTableY2[4] = 234;
    }
  }
}

void moveAlexAire(int keys, unsigned char puedeSubir, unsigned char puedeDerecha, unsigned char puedeIzquieda) {
  if (alex.y > maxSalto) {
    alex.y -= 2;
  }
  else if (puedeSubir) {
    alex.y += 2; // bajando
    maxSalto = 255;
  }
  if (keys & PORT_A_KEY_LEFT) {
    if (alex.state != PUÑETAZO_SALTANDO)
      alex.oriented = 1;
    if (puedeIzquieda)
      alex.x -= 2;
  }
  if (keys & PORT_A_KEY_RIGHT) {
    if (alex.state != PUÑETAZO_SALTANDO)
      alex.oriented = 0;
    if (puedeDerecha)
      alex.x += 2;
  }
  if (alex.state == PUÑETAZO_SALTANDO) {
    alex.lastChangeFrame--;
    if  (!alex.lastChangeFrame) {
      alex.state = 0;
      SpriteTableY2[4] = 234;
    }
    if (!alex.oriented) {
      alex.frame = 5;
      //SMS_addSprite (alex.x + 16, alex.y + 9, 9);
      SpriteTableXN2[8] = alex.x + 16;
      SpriteTableXN2[9] = 9;
      SpriteTableY2[4] = alex.y + 9;
    }
    else {
      alex.frame = 13;
      //SMS_addSprite (alex.x - 8,  alex.y + 9, 11);
      SpriteTableXN2[8] = alex.x - 8;
      SpriteTableXN2[9] = 11;
      SpriteTableY2[4] = alex.y + 9;
    }
  }
  else {
    SpriteTableY2[4] = 234;
    if (!alex.oriented)
      alex.frame = 6;
    else
      alex.frame = 14;
    if (keys & PORT_A_KEY_1) {
      alex.state = PUÑETAZO_SALTANDO;
      alex.lastChangeFrame = 20;
    }
  }
  
}

void drawAlex(void) {
  SpriteTableXN2[0] = alex.x;
  SpriteTableXN2[2] = alex.x + 8;
  SpriteTableXN2[4] = alex.x;
  SpriteTableXN2[6] = alex.x + 8;
  SpriteTableY2[0] = alex.y;
  SpriteTableY2[1] = alex.y;
  SpriteTableY2[2] = alex.y + 16;
  SpriteTableY2[3] = alex.y + 16;
  if (alex.frame != lastFrame) {
    SMS_loadTiles(alex.sprite->data + alex.frame *256, alex.sprite->beginVRAM, 255);
    lastFrame = alex.frame;
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
  //drawAlex();
}