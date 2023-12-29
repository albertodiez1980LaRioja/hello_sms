#include <stdio.h>
#include "SMSlib.h"
#include "bank1.h"

void init(){
  SMS_init();
}

void loadGrapVRAM(){
  SMS_loadBGPalette(sonicpalette_inc);
  SMS_loadTiles(sonictiles_inc,0,sonictiles_inc_size);
  SMS_loadTileMap(0,0,sonictilemap_inc,sonictilemap_inc_size);
}

void main(void)
{
  /* Clear VRAM */
  SMS_VRAMmemsetW(0, 0x0000, 16384);

  /* load a standard font character set into tiles 0-95,
   * set BG palette to B/W and turn on the screen */
  //SMS_autoSetUpTextRenderer();

  /* Set the target of the next background write */
  //SMS_setNextTileatXY(4,5);

  /* printf() is available */
  printf("Hello, World! [1/3]");

  /* When formatting is not needed, SMS_print is faster */
  //SMS_setNextTileatXY(4,11);
  //SMS_print("Hello, World! [2/5535]");

  /* The above (setting XY and then printing is common, so
   * the SMS_printatXY macro is there for convenience */
  //SMS_printatXY(4,12,"Hello, World! [3/3]");

  //init();
  loadGrapVRAM();
  /* Turn on the display */
  SMS_displayOn();


  /* Do nothing */
  for(;;) {

  }
}

SMS_EMBED_SEGA_ROM_HEADER(9999,0);
SMS_EMBED_SDSC_HEADER_AUTO_DATE(1,0,"raphnet","basic example","A simple example");
