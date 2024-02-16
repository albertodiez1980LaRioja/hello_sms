#include <stdio.h>
#include "SMSlib.h"
#include "PSGlib.h"
#include "bank1.h"
#include "bank2.h"

#define SPRITE_TILES_POSITION 256
int nextVRAMsprites = SPRITE_TILES_POSITION;

typedef struct{
  unsigned char alto, ancho; // sprites de alto y ancho
  unsigned char tamano; // alto*ancho*(2 si es tall)
  unsigned char numFrames;
  int beginVRAM;
}T_sprite;


T_sprite generateSprite(unsigned char alto, unsigned char ancho, int tam,const unsigned char data[]) {
  unsigned char tamano = alto*ancho*2;
  T_sprite sprite = {alto,ancho,tamano,tam/(tamano*32),nextVRAMsprites};
  SMS_loadTiles(data,nextVRAMsprites,tam);
  nextVRAMsprites += tam;
  return sprite;
}

typedef struct{
  unsigned char x,y,frame;
}T_entidad;

T_entidad alex = {10,10, 0};
T_sprite spriteAlex = {2,2,8,0,0};

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
  //SMS_loadTiles(spriteAlex_inc,SPRITE_TILES_POSITION,spriteAlex_inc_size);
  spriteAlex = generateSprite(2,2,spriteAlex_inc_size, spriteAlex_inc);
  spriteAlex = generateSprite(2,2,spriteAlex_inc_size, spriteAlex_inc);
  SMS_loadTileMap(0,0,sonictilemap_inc,sonictilemap_inc_size);
}

int player_x=50;
int player_v_x=0;
int player_y=20;
unsigned char frame_player = 0;
int delay_frame_player = 15;

draw_entidad(T_entidad *entidad, T_sprite *sprite){
  unsigned char i,j;
  int frame = sprite->tamano*entidad->frame + sprite->beginVRAM;
    for(j=0;j<sprite->alto;j++) {
      for(i=0;i<sprite->ancho;i++) {
        SMS_addSprite(entidad->x+(i<<3),entidad->y+(j<<4), frame + (j<<2) + (i<<1) );  
      }   
    }
}

draw_main_character(){
  unsigned char i,j;
  unsigned char numSprites;
  unsigned char sumy=0;
  for(numSprites=0;numSprites<4;numSprites++){
    for(j=0;j<2;j++) {
      for(i=0;i<2;i++) {
        SMS_addSprite(player_x+(i<<3),player_y+(j<<4)+sumy, (frame_player<<3) + (j<<2) + (i<<1) );  
        SMS_addSprite(player_x+(i<<3)+20,player_y+(j<<4)+sumy, (frame_player<<3) + (j<<2) + (i<<1) );  
        SMS_addSprite(player_x+(i<<3)+40,player_y+(j<<4)+sumy, (frame_player<<3) + (j<<2) + (i<<1) );  
        SMS_addSprite(player_x+(i<<3)+60,player_y+(j<<4)+sumy, (frame_player<<3) + (j<<2) + (i<<1) );  
      }   
    }
    sumy = numSprites*30;
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
    //draw_main_character();
    alex.x = player_x;
    alex.y = player_y;
    alex.frame = frame_player;
    draw_entidad(&alex, &spriteAlex);
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
