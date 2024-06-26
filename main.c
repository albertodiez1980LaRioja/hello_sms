#include <stdio.h>
#ifndef SMSlib_INCLUDED
  #define SMSlib_INCLUDED
  #include "SMSlib.h" 
#endif


#include "PSGlib.h"
#include "bank1.h"
#include "bank2.h"
//#include "bank3.h"
#include "./lib/entities.c"
#include "./alex.c"


#define NUM_PAJAROS 19
T_entidad pajaros[NUM_PAJAROS];
T_sprite spriteAlex = {2, 2, 8, 0, 0, 0};
T_sprite spritePajaro = {2, 2, 8, 0, 0, 0};

T_sprite spritePuno = {2, 2, 8, 0, 0, 0};
unsigned int numSprites;

void inicializaPajaros(void);

void loadGrapVRAM(void);

void dibujaPajaros(void);

void playMusic(void);

void disableSprites(void);


void main(void)
{
  unsigned char scroll_x = 0;
  unsigned char scroll_y = 0;
  /* Clear VRAM */
  SMS_VRAMmemsetW(0, 0x0000, 16384);

  /* load a standard font character set into tiles 0-95,
   * set BG palette to B/W and turn on the screen */
  // SMS_autoSetUpTextRenderer();

  /* Set the target of the next background write */
  // SMS_setNextTileatXY(4,5);

  /* printf() is available */
  printf("Hello, World! [1/3]");

  // SMS_printatXY(4,12,"Hello, World! [3/3]");
  
  /* Turn on the display */
  SMS_displayOn();
  SMS_setBGScrollX(scroll_x);
  SMS_setBGScrollY(scroll_y);
  SMS_init();
  initSpritesVariables();
  loadGrapVRAM();
  // SMS_setSpriteMode(SPRITEMODE_NORMAL);
  // SMS_setSpriteMode(SPRITEMODE_TALL);
  /* Do nothing */
  // PSGPlay(titulo_psg);
  // PSGPlay(nuestro_psg);
  char banco = SMS_getROMBank();
  SMS_mapROMBank(3);
  PSGPlay(special_psg);
  //PSGPlay(B0_Final_psg);
  SMS_mapROMBank(banco);
  SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
  SMS_VDPturnOnFeature(VDPFEATURE_EXTRAHEIGHT);
  //SMS_VDPturnOnFeature(VDPFEATURE_224LINES);
  SMS_VDPturnOnFeature(VDPFEATURE_240LINES);
  SMS_setFrameInterruptHandler(playMusic);
  
  for (;;)
  {

    if (SMS_queryPauseRequested())
    {
      char banco = SMS_getROMBank();
      SMS_mapROMBank(3);
      PSGPlay(emeraldhill_psg);
      SMS_mapROMBank(banco);
      SMS_resetPauseRequest();
      while (!SMS_queryPauseRequested())
      {
        SMS_waitForVBlank();
        //PSGFrame();
        //PSGFXFrame();
      }
      SMS_resetPauseRequest();
      //PSGPlay(titulo_psg);
    }
    unsigned int index = 0;

    unsigned int keys = SMS_getKeysHeld();
    if(keys & PORT_A_KEY_2)
      keys = keys  ^ PORT_A_KEY_2;
    if(keys & PORT_A_KEY_1)
      keys = keys  ^ PORT_A_KEY_1;

    keys = keys | (SMS_getKeysPressed() & (PORT_A_KEY_2 | PORT_A_KEY_1));
    
    //SMS_initSprites();
    moveAlex(keys);
    
    dibujaPajaros();

    // SMS_autoSetUpTextRenderer();
    // SMS_printatXY(4,12,"Hello, World! [3/3]");
    
    SMS_waitForVBlank();
    drawAlex();
    //SMS_initSprites();
    //SMS_displayOff();
    //UNSAFE_SMS_copySpritestoSAT();
    //SMS_displayOn();
    copySpritestoSAT();
    //SMS_copySpritestoSAT();
    //copySpritestoSAT();
    //disableSprites();
    //PSGFrame();
    //PSGSFXFrame();
    SMS_setBGScrollX(scroll_x);
    // SMS_setBGScrollY(scroll_y);
    SMS_displayOn();
  }
}

SMS_EMBED_SEGA_ROM_HEADER(9999, 0);
SMS_EMBED_SDSC_HEADER_AUTO_DATE(1, 0, "SEGA", "basic example", "A simple example");

void disableSprites(void) {
  unsigned int i = 0;
  ///i = 10;
  while (i < 64) {
    SMS_updateSpritePosition(i,10,240); 
    i++;
  }
  numSprites = 0;
}


void playMusic(void) {
  char banco = SMS_getROMBank();
  SMS_mapROMBank(3);
  PSGFrame();
  //SMS_mapROMBank(3);
  PSGSFXFrame();
  SMS_mapROMBank(banco);
}

void dibujaPajaros(void)
{
  unsigned char i, i2, j, desplazado, jCalculated, y;
  T_entidad *p;
  unsigned char initPajaros = pajaros[0].initSprite;
  for (i = 0; i < NUM_PAJAROS; i++)
  {
    p = &pajaros[i];
    p->lastChangeFrame++;
    if (p->lastChangeFrame == 20)
    {
      p->frame++;
      if (p->frame > 1)
        p->frame = 0;
      p->lastChangeFrame = 0;
      int frame = spritePajaro.tamano*p->frame + spritePajaro.beginVRAM;
      for(j=0;j<spritePajaro.alto;j++) {
        desplazado = (j<<2);
        jCalculated = desplazado + frame;
        y = p->y+(desplazado<<2);
        for(i2=0;i2<spritePajaro.ancho;i2++) {
          SpriteTableXN2[(i2+initPajaros)*2+1] = jCalculated + (i2<<1);
          if(p->vx < 0)
            SpriteTableXN2[(i2+initPajaros)*2+1] += 12;
        }
      } 
    }
    
    initPajaros +=3;
    i2 = p->initSprite << 1;
    p->x += p->vx;
    if (SpriteTableXN2[i2] >= 230) {
      p->vx = -1;
      p->lastChangeFrame = 19;
    }
    else if(SpriteTableXN2[i2] < 10) {
      p->vx = 1;
      p->lastChangeFrame = 19;
    }
    while(i2<p->len) {
      SpriteTableXN2[i2] += p->vx;
      i2 +=2;
    }
    //alex.y = 50;
    if (alex.state == PUÑETAZO_SALTANDO) {
      unsigned char matar = 1;
      if(SpriteTableXN2[8] > p->x + 24 )
        matar = 0;
      if (matar && (SpriteTableXN2[8] + 16 < p->x))
        matar = 0;
      if(matar && (SpriteTableY2[4] > p->y + 16))
        matar = 0;
      if (matar && (SpriteTableY2[4] + 12 < p->y))
        matar = 0;
      if (matar) {
        // kill the bird
        i2 = p->initSprite;
        while(i2<(p->len>>1)) {
          SpriteTableY2[i2] = 239;
          i2 ++;
        }
      }
    }
  }
}


void loadGrapVRAM(void)
{
  SMS_init();
  
  // SMS_setSpriteMode(SPRITEMODE_NORMAL);
  SMS_setSpriteMode(SPRITEMODE_TALL);
  SMS_displayOn();
  SMS_loadBGPalette(sonicpalette_inc);
  SMS_loadSpritePalette(palleteAlex_inc);
  
  spriteAlex = generateSpriteNoRAM(2, 2, spriteAlex_inc_size, spriteAlex_inc);
  spritePuno = generateSprite(1, 2, puno_inc_size, puno_inc);
  spritePajaro = generateSpriteFlip(3, 1, spritePajaro_inc_size, spritePajaro_inc);
  SMS_initSprites();
  alex.initSprite = 255;
  draw_entidad(&alex, &spriteAlex);
  SMS_addSprite (0, 0, 9); // puno
  inicializaPajaros();
  //SMS_loadTiles(sonictiles_inc, 0, sonictiles_inc_size);
  //SMS_loadTileMap(0, 0, sonictilemap_inc, sonictilemap_inc_size);
  //SMS_loadBGPalette(sonicpalette_inc);

  SMS_loadTiles(tiles_de_prueba2_inc, 0, tiles_de_prueba2_inc_size);
  SMS_loadTileMap(0, 0, tilemap_de_prueba2_inc, tilemap_de_prueba2_inc_size);
  SMS_loadBGPalette(paleta_de_prueba2_inc);
  SMS_setSpritePaletteColor(0,0);
}


void inicializaPajaros(void)
{
  unsigned char i;
  for (i = 0; i < NUM_PAJAROS; i++)
  {
    pajaros[i].x = 15 + (32 * i) % 200;
    pajaros[i].y = 16 * (i / 2);
    pajaros[i].lastChangeFrame = i * 3;
    pajaros[i].initSprite = 255;
    //draw_entidad(&(pajaros[i]), &spritePajaro);
    pajaros[i].x++;
    pajaros[i].lastChangeFrame++;
    pajaros[i].vx = 1;
    pajaros[i].vy = 0;
    if (pajaros[i].lastChangeFrame == 20)
    {
      pajaros[i].frame++;
      if (pajaros[i].frame > 1)
        pajaros[i].frame = 0;
      pajaros[i].lastChangeFrame = 0;
    }
    if(pajaros[i].initSprite == 255) {
      draw_entidad(&(pajaros[i]), &spritePajaro);
    }
  }
}
