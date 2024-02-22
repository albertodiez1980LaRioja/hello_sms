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
T_sprite generateSpriteNoRAM(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]);

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