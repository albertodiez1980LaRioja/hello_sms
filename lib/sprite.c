#include "../SMSlib.h"
#define SPRITE_TILES_POSITION 256
int nextVRAMsprites = SPRITE_TILES_POSITION;

typedef struct{
  unsigned char alto, ancho; // sprites de alto y ancho
  unsigned char tamano; // alto*ancho*(2 si es tall)
  unsigned char numFrames;
  
  int beginVRAM;
  unsigned char allInRAM;
  const unsigned char *data;
  unsigned char frameInVRAM;
}T_sprite;


T_sprite generateSprite(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]);
//T_sprite generateSpriteNoRAM(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]);

T_sprite generateSprite(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]) {
  unsigned char tamano = alto*ancho*2;
  T_sprite sprite = {alto,ancho,tamano,tam/(tamano*32),nextVRAMsprites, 1,0};
  SMS_loadTiles(data,nextVRAMsprites,tam);
  nextVRAMsprites = nextVRAMsprites + (tamano*sprite.numFrames);
  return sprite;
}


T_sprite generateSpriteNoRAM(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]) {
  unsigned char tamano = alto*ancho*2;
  T_sprite sprite = {alto,ancho,tamano,tam/(tamano*32),nextVRAMsprites, 0,0};
  sprite.data = data;
  sprite.frameInVRAM = 0;
  SMS_loadTiles(data,nextVRAMsprites,tamano*32);
  nextVRAMsprites = nextVRAMsprites + (tamano);
  return sprite;
}


typedef struct{
  unsigned int vx,vy, x, y;
  unsigned int initSprite, len; // len == 0 => free
}T_HardwareSprite;

#define MAX_HARDWARE_SPRITES 64
T_HardwareSprite hardwareSprites[MAX_HARDWARE_SPRITES];

unsigned int addHardwareSprite(unsigned int x,unsigned int y,unsigned int vx,unsigned int vy,unsigned int lx,
  unsigned int ly,unsigned int *tiles) {
  unsigned int i = MAX_HARDWARE_SPRITES;
  while (i) {
    if (!hardwareSprites[i].len) {
      T_HardwareSprite *p = &hardwareSprites[i]; 
      p->x = x;
      p->y = y;
      p->vx = vx;
      p->vy = vy;
      unsigned int iTile = 0;
      for (int iy=0;iy<ly;iy++) {
        for (int ix=0;ix<lx;ix++){
          if(ix==0 && iy == 0) {
            p->initSprite = SMS_addSprite(x,y, tiles[iTile]);
          }
          else {
            SMS_addSprite(x,y, tiles[iTile]);
          }
          iTile++;
          x += 8;
        }
        y += 16;
      }
      p->len = p->initSprite + lx*ly;
      return i;
    }
    i--;
  }
  return i;
}


#define MAXSPRITES 64
unsigned char *SpriteTableY2;
unsigned char *SpriteTableXN2;
unsigned char *SpriteNextFree2;



void initSpritesVariables (void);

void initSpritesVariables (void) {
    unsigned int i = MAX_HARDWARE_SPRITES;
    while (i) {
      hardwareSprites[i].len = 0;
      i--;
    }
      __asm
        ld hl, #_SpriteNextFree
        ld (#_SpriteNextFree2), hl
        ld hl, #_SpriteTableY
        ld (#_SpriteTableY2), hl
        ld hl, #_SpriteTableXN
        ld (#_SpriteTableXN2), hl
         //xor a, a
         //ld a, (#_SpriteNextFree)
         //inc a
         //ld (#_SpriteNextFree),a
    __endasm;
    //*SpriteNextFree2 = 0;
    //SpriteTableXN2[0] = 10;
}

#define SMS_SATAddress    ((unsigned int)0x7F00)
/* declare various I/O ports in SDCC z80 syntax */
/* define VDPControlPort */
__sfr __at 0xBF VDPControlPort;
/* define VDPStatusPort */
__sfr __at 0xBF VDPStatusPort;
/* define VDPDataPort */
__sfr __at 0xBE VDPDataPort;
/* define VDPVcounter */
__sfr __at 0x7E VDPVCounterPort;
/* define VDPHcounter */
__sfr __at 0x7F VDPHCounterPort;



void copySpritestoSAT (void) {
  SMS_setAddr(SMS_SATAddress);
  __asm
    ld a,(#_SpriteNextFree)
    or a
    jr z,_no_sprites
    ld b,a
    ld c,#_VDPDataPort
    ld hl,#_SpriteTableY
_next_spriteY:
    outi                    ; 16 cycles
    jr nz,_next_spriteY     ; 12 cycles = 28 (VRAM safe on GG too)
    cp #64                  ;  7 cycles
    jr z,_no_sprite_term    ;  7 cycles
    ld a,#0xD0              ;  7 cycles   =>  VRAM safe
    out (c),a
_no_sprite_term:
  __endasm;
  SMS_setAddr(SMS_SATAddress+128);
  __asm
    ld c,#_VDPDataPort
    ld a,(#_SpriteNextFree)
    add a,a
    ld b,a
    ld hl,#_SpriteTableXN
_next_spriteXN:
    outi                    ; 16 cycles
    jr nz,_next_spriteXN    ; 12 cycles = 28 (VRAM safe on GG too)
    ret

_no_sprites:
    ld a,#0xD0
    out (#_VDPDataPort),a
  __endasm;
}