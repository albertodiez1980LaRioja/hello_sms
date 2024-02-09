#include <stdio.h>
#include "SMSlib.h"
#include "PSGlib.h"
#include "bank1.h"
#include "bank2.h"

#define SPRITE_TILES_POSITION sonictiles_inc_size/32


void init(){
  SMS_init();
}

void loadGrapVRAM(){
  SMS_init();
  //SMS_setSpriteMode(SPRITEMODE_NORMAL);
  SMS_setSpriteMode(SPRITEMODE_TALL);
  SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
  SMS_displayOn();
  SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
  SMS_loadBGPalette(sonicpalette_inc);
  //SMS_loadSpritePalette(alexVariosPaleta_inc);
  SMS_loadSpritePalette(palleteAlex_inc);
  SMS_loadTiles(sonictiles_inc,0,sonictiles_inc_size);
  //SMS_loadTiles(alexAndando_inc,256/*SPRITE_TILES_POSITION*/,alexAndando_inc_size);
  SMS_loadTiles(spriteAlex_inc,256/*SPRITE_TILES_POSITION*/,spriteAlex_inc_size);
  SMS_loadTileMap(0,0,sonictilemap_inc,sonictilemap_inc_size);
}

int player_x=50;
int player_v_x=0;
int player_y=50;
int frame_player = 0;
int delay_frame_player = 15;

draw_main_character(){
  unsigned char i,j;
  unsigned char numSprites;
  //frame_player=0;
  for(numSprites=0;numSprites<1;numSprites++){
    for(j=0;j<2;j++) {
      for(i=0;i<2;i++) {
        //SMS_addSprite(player_x+(i<<3),player_y+(j<<4)+numSprites*30, 2*frame_player + 2*j + i);  
        SMS_addSprite(player_x+(i<<3),player_y+(j<<4)+numSprites*30, 8*frame_player + 4*j + i*2 );  
        //SMS_addSprite(player_x+(i<<3)+20,player_y+(j<<3)+numSprites*30,2*frame_player + 8*j + i);  
        //SMS_addSprite(player_x+(i<<3)+40,player_y+(j<<3)+numSprites*30,2*frame_player + 8*j + i);  
        //SMS_addSprite(player_x+(i<<3)+60,player_y+(j<<3)+numSprites*30,2*frame_player + 8*j + i);  
        //SMS_addSprite(player_x+(i<<3)+80,player_y+(j<<3),2*frame_player + 8*j + i);  
      }   
    }
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
  SMS_setBGScrollX(scroll_x);
  SMS_setBGScrollY(scroll_y);
  SMS_init();
  //SMS_setSpriteMode(SPRITEMODE_NORMAL);
  //SMS_setSpriteMode(SPRITEMODE_TALL);
  /* Do nothing */
  //PSGPlay(titulo_psg);
  //PSGPlay(nuestro_psg);
  PSGPlay(titulo_psg);
  SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
  for(;;) {
    if(SMS_queryPauseRequested ()){
      SMS_resetPauseRequest ();
      while(!SMS_queryPauseRequested ()){
        SMS_waitForVBlank();
        PSGFrame();
      }
      SMS_resetPauseRequest();
    }
    unsigned int index=0;

    int keys = SMS_getKeysHeld();
    if(keys & PORT_A_KEY_LEFT){
      player_v_x=-1; 
    }
    else if(keys & PORT_A_KEY_RIGHT){
      player_v_x=1; 
    }
    else
      player_v_x=0; 
    //player_v_x=1; 
    player_x = player_x + player_v_x;
    if(player_v_x != 0)
      delay_frame_player++;
    else{
      delay_frame_player=15;
      frame_player=1;
    }
    if(delay_frame_player%16==0){
      frame_player++;
      if(frame_player>3){
        frame_player=0;
        
      }
    }
    SMS_initSprites();
    draw_main_character();
    SMS_finalizeSprites();
    SMS_waitForVBlank();
    SMS_copySpritestoSAT();
    PSGFrame();
    SMS_displayOff();
    if(scroll_y%2==0)
      scroll_x += 1;
    scroll_y++;
    if(scroll_y==224)
      scroll_y=0;
    
    SMS_setBGScrollX(scroll_x);
    //SMS_setBGScrollY(scroll_y);
    SMS_displayOn();
  }
}

SMS_EMBED_SEGA_ROM_HEADER(9999,0);
SMS_EMBED_SDSC_HEADER_AUTO_DATE(1,0,"raphnet","basic example","A simple example");
