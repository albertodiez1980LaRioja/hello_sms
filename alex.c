#include "SMSlib.h"
//#include "./lib/entities.c"


int vY = 0, finSalto;
T_entidad alex = {10, 20, 0, 0,0};
void moveAlex(int keys)
{
  if ((keys & PORT_A_KEY_DOWN) && alex.state == 0){
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

  int player_v_x = 0;
  if ((keys & PORT_A_KEY_LEFT) && alex.x > 8 )
  {
    player_v_x = -1;
    alex.oriented = 1;
    if (alex.frame < 8 || alex.frame > 11)
        alex.frame = 8;
        //alex.lastChangeFrame = 0;
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
  if ((keys & PORT_A_KEY_1) && alex.state == 0) {
    alex.state = 1;
    finSalto = alex.y - 70;
    vY = -2;
  }
  if (alex.state == 1) {
    if (!alex.oriented)
      alex.frame = 6; //salto
    else
      alex.frame = 14;
    if(alex.y == 0 || alex.y == 1 || alex.y < finSalto) {
      vY = 2;
    }
    if ((alex.y == 150 || alex.y == 151) && vY > 0) {
      alex.state = 0;
      vY = 0;
      alex.frame = 0;
    }
  }
  alex.y += vY;
    
}
