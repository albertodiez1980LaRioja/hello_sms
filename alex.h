#ifndef SMSlib_INCLUDED
  #define SMSlib_INCLUDED
  #include "SMSlib.h" 
#endif

#ifndef BANK2_INCLUDED
  #define BANK2_INCLUDED
  #include "bank2.h"
#endif

#ifndef PSGLIB_INCLUDED
  #define PSGLIB_INCLUDED
  #include "PSGlib.h"
#endif

#ifdef ENTITIES_INCLUDED
  #define ENTITIES_INCLUDED
  #include "lib/entities.c"
#endif

#define ALEX_INCLUDED


#define PUÑETAZO 8
#define PUÑETAZO_SALTANDO 16
#define PUÑETAZO_SUELO 32

unsigned char maxSalto = 255;
T_entidad alex = {30, 150, 0, 0, 0,0, 255};
unsigned char lastFrame = 255;


extern unsigned char canUp(void);

unsigned char canDown(void);

unsigned char canLeft(void); 

unsigned char canRight(void);

void moveAlexSuelo(int keys); 

void moveAlexAire(int keys, unsigned char puedeSubir, unsigned char puedeDerecha, unsigned char puedeIzquieda);
  
void drawAlex(void);

void moveAlex(int keys);