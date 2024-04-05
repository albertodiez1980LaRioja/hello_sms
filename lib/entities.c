
#include "./sprite.c"

typedef struct{
  unsigned char x,y,frame,lastChangeFrame,oriented,state;
  unsigned char initSprite, len;
}T_entidad;

void draw_entidad(T_entidad *entidad, T_sprite *sprite);

void draw_entidad(T_entidad *entidad, T_sprite *sprite){
  unsigned char i,j;
  if (sprite->allInRAM == 1){
    if (entidad->initSprite == 255) {
      int frame = sprite->tamano*entidad->frame + sprite->beginVRAM;
      for(j=0;j<sprite->alto;j++) {
        unsigned char desplazado = (j<<2);
        unsigned char jCalculated = desplazado + frame, y = entidad->y+(desplazado<<2);
        for(i=0;i<sprite->ancho;i++) {
          if(i==0 && j==0)
            entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),y, jCalculated + (i<<1) );  
          else
            SMS_addSprite(entidad->x+(i<<3),y, jCalculated + (i<<1) );  
        }
      } 
      entidad->len = (sprite->alto * sprite->ancho + entidad->initSprite)*2;
    }
  }
  else {
    int frame = sprite->tamano*entidad->frame*32;
    if (entidad->initSprite == 255) {
      if (entidad->frame != sprite->frameInVRAM){
        SMS_loadTiles(sprite->data + frame,sprite->beginVRAM,sprite->tamano<<5);
        sprite->frameInVRAM = entidad->frame;
      }
      for(j=0;j<sprite->alto;j++) {
        for(i=0;i<sprite->ancho;i++) {
          if(i==0 && j==0)
            entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),entidad->y+(j<<4), (j<<2) + (i<<1) );  
          else
            SMS_addSprite(entidad->x+(i<<3),entidad->y+(j<<4), (j<<2) + (i<<1) );  
        }   
      }
      entidad->len = sprite->alto * sprite->ancho + entidad->initSprite;
    }
    else {

    }
  }
}
