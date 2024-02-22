#include <stdio.h>
#include "SMSlib.h"
#include "PSGlib.h"
#include "bank1.h"
#include "bank2.h"
#include "./lib/entities.c"
#include "./alex.c"


#define NUM_PAJAROS 14
T_entidad pajaros[NUM_PAJAROS];
T_sprite spriteAlex = {2, 2, 8, 0, 0, 0};
T_sprite spritePajaro = {2, 2, 8, 0, 0, 0};

void inicializaPajaros()
{
  unsigned char i;
  for (i = 0; i < NUM_PAJAROS; i++)
  {
    pajaros[i].x = 15 + 32 * i;
    pajaros[i].y = 15 + 16 * (i / 2);
    pajaros[i].lastChangeFrame = i * 3;
  }
}

void loadGrapVRAM()
{
  SMS_init();
  inicializaPajaros();
  // SMS_setSpriteMode(SPRITEMODE_NORMAL);
  SMS_setSpriteMode(SPRITEMODE_TALL);
  SMS_displayOn();
  SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
  SMS_loadBGPalette(sonicpalette_inc);
  SMS_loadSpritePalette(palleteAlex_inc);
  SMS_loadTiles(sonictiles_inc, 0, sonictiles_inc_size);
  spriteAlex = generateSpriteNoRAM(2, 2, spriteAlex_inc_size, spriteAlex_inc);
  spritePajaro = generateSprite(3, 1, spritePajaro_inc_size, spritePajaro_inc);
  SMS_loadTileMap(0, 0, sonictilemap_inc, sonictilemap_inc_size);
}

void dibujaPajaros()
{
  unsigned char i;
  for (i = 0; i < NUM_PAJAROS; i++)
  {
    pajaros[i].x++;
    pajaros[i].lastChangeFrame++;
    if (pajaros[i].lastChangeFrame == 20)
    {
      pajaros[i].frame++;
      if (pajaros[i].frame > 1)
        pajaros[i].frame = 0;
      pajaros[i].lastChangeFrame = 0;
    }
    draw_entidad(&(pajaros[i]), &spritePajaro);
  }
}


void main(void)
{
  unsigned char scroll_x;
  unsigned char scroll_y;
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

  loadGrapVRAM();
  /* Turn on the display */
  SMS_displayOn();
  SMS_setBGScrollX(scroll_x);
  SMS_setBGScrollY(scroll_y);
  SMS_init();
  // SMS_setSpriteMode(SPRITEMODE_NORMAL);
  // SMS_setSpriteMode(SPRITEMODE_TALL);
  /* Do nothing */
  // PSGPlay(titulo_psg);
  // PSGPlay(nuestro_psg);
  PSGPlay(titulo_psg);
  SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);

  for (;;)
  {

    if (SMS_queryPauseRequested())
    {
      SMS_resetPauseRequest();
      while (!SMS_queryPauseRequested())
      {
        SMS_waitForVBlank();
        PSGFrame();
      }
      SMS_resetPauseRequest();
    }
    unsigned int index = 0;

    int keys = SMS_getKeysHeld();
    moveAlex(keys);
    SMS_initSprites();
    draw_entidad(&alex, &spriteAlex);
    dibujaPajaros();

    SMS_finalizeSprites();
    // SMS_autoSetUpTextRenderer();
    // SMS_printatXY(4,12,"Hello, World! [3/3]");
    SMS_waitForVBlank();
    SMS_copySpritestoSAT();
    PSGFrame();
    SMS_displayOff();
    if (scroll_y % 2 == 0)
      scroll_x += 1;
    scroll_y++;
    if (scroll_y == 224)
      scroll_y = 0;

    SMS_setBGScrollX(scroll_x);
    // SMS_setBGScrollY(scroll_y);
    SMS_displayOn();
  }
}

SMS_EMBED_SEGA_ROM_HEADER(9999, 0);
SMS_EMBED_SDSC_HEADER_AUTO_DATE(1, 0, "raphnet", "basic example", "A simple example");
