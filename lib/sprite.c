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

unsigned char flipArray[256] = {0x00,0x80,0x40,0xc0,0x20,0xa0,0x60,0xe0,0x10,0x90,0x50,0xd0,0x30,0xb0,0x70,0xf0,0x08,0x88,0x48,0xc8,0x28,0xa8,0x68,0xe8,0x18,0x98,0x58,0xd8,0x38,0xb8,0x78,0xf8,0x04,0x84,0x44,0xc4,0x24,0xa4,0x64,0xe4,0x14,0x94,0x54,0xd4,0x34,0xb4,0x74,0xf4,0x0c,0x8c,0x4c,0xcc,0x2c,0xac,0x6c,0xec,0x1c,0x9c,0x5c,0xdc,0x3c,0xbc,0x7c,0xfc,0x02,0x82,0x42,0xc2,0x22,0xa2,0x62,0xe2,0x12,0x92,0x52,0xd2,0x32,0xb2,0x72,0xf2,0x0a,0x8a,0x4a,0xca,0x2a,0xaa,0x6a,0xea,0x1a,0x9a,0x5a,0xda,0x3a,0xba,0x7a,0xfa,0x06,0x86,0x46,0xc6,0x26,0xa6,0x66,0xe6,0x16,0x96,0x56,0xd6,0x36,0xb6,0x76,0xf6,0x0e,0x8e,0x4e,0xce,0x2e,0xae,0x6e,0xee,0x1e,0x9e,0x5e,0xde,0x3e,0xbe,0x7e,0xfe,0x01,0x81,0x41,0xc1,0x21,0xa1,0x61,0xe1,0x11,0x91,0x51,0xd1,0x31,0xb1,0x71,0xf1,0x09,0x89,0x49,0xc9,0x29,0xa9,0x69,0xe9,0x19,0x99,0x59,0xd9,0x39,0xb9,0x79,0xf9,0x05,0x85,0x45,0xc5,0x25,0xa5,0x65,0xe5,0x15,0x95,0x55,0xd5,0x35,0xb5,0x75,0xf5,0x0d,0x8d,0x4d,0xcd,0x2d,0xad,0x6d,0xed,0x1d,0x9d,0x5d,0xdd,0x3d,0xbd,0x7d,0xfd,0x03,0x83,0x43,0xc3,0x23,0xa3,0x63,0xe3,0x13,0x93,0x53,0xd3,0x33,0xb3,0x73,0xf3,0x0b,0x8b,0x4b,0xcb,0x2b,0xab,0x6b,0xeb,0x1b,0x9b,0x5b,0xdb,0x3b,0xbb,0x7b,0xfb,0x07,0x87,0x47,0xc7,0x27,0xa7,0x67,0xe7,0x17,0x97,0x57,0xd7,0x37,0xb7,0x77,0xf7,0x0f,0x8f,0x4f,0xcf,0x2f,0xaf,0x6f,0xef,0x1f,0x9f,0x5f,0xdf,0x3f,0xbf,0x7f,0xff};


T_sprite generateSprite(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]);
//T_sprite generateSpriteNoRAM(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]);

unsigned char buffer64[64];

T_sprite generateSpriteFlip(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]) {
  unsigned char tamano = alto*ancho*2;
  T_sprite sprite = {alto,ancho,tamano,tam/(tamano*32),nextVRAMsprites, 1,0};
  SMS_loadTiles(data,nextVRAMsprites,tam);
  nextVRAMsprites = nextVRAMsprites + (tamano*sprite.numFrames);
  // now put the flip sprite
  unsigned char x, y, numFrames = tamano/(alto*ancho);
  int offset = 0;
  while(numFrames) {
    y=alto;
    while (y) {
      x = ancho;
      offset = offset + x*64 - 64; // voy al principio del último tile
      while(x) {
        unsigned char i=0;
        int offset2 = offset;
        while(i<64){
          buffer64[i] = flipArray[data[offset2]];
          offset2++;
          i++;
        }
        SMS_loadTiles(&buffer64,nextVRAMsprites,64);
        offset = offset - 64; // voy al anterior tile
        nextVRAMsprites += 2;
        x--;
      }
      offset = offset + x*64 + 64;
      y--;
    }
    numFrames--;
  }
  return sprite;
}



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