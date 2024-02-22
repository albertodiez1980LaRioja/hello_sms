;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.0 #14549 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___SMS__SDSC_signature
	.globl ___SMS__SDSC_descr
	.globl ___SMS__SDSC_name
	.globl ___SMS__SDSC_author
	.globl ___SMS__SEGA_signature
	.globl _main
	.globl _dibujaPajaros
	.globl _loadGrapVRAM
	.globl _inicializaPajaros
	.globl _moveAlex
	.globl _SMS_VRAMmemsetW
	.globl _SMS_VRAMmemcpy
	.globl _SMS_resetPauseRequest
	.globl _SMS_queryPauseRequested
	.globl _SMS_getKeysHeld
	.globl _SMS_loadSpritePalette
	.globl _SMS_loadBGPalette
	.globl _SMS_copySpritestoSAT
	.globl _SMS_finalizeSprites
	.globl _SMS_initSprites
	.globl _SMS_waitForVBlank
	.globl _SMS_setSpriteMode
	.globl _SMS_setBGScrollY
	.globl _SMS_setBGScrollX
	.globl _SMS_VDPturnOffFeature
	.globl _SMS_VDPturnOnFeature
	.globl _SMS_init
	.globl _PSGFrame
	.globl _PSGPlay
	.globl _printf
	.globl _spritePajaro
	.globl _spriteAlex
	.globl _alex
	.globl _vY
	.globl _nextVRAMsprites
	.globl _pajaros
	.globl _finSalto
	.globl _SMS_SRAM
	.globl _SRAM_bank_to_be_mapped_on_slot2
	.globl _ROM_bank_to_be_mapped_on_slot0
	.globl _ROM_bank_to_be_mapped_on_slot1
	.globl _ROM_bank_to_be_mapped_on_slot2
	.globl _generateSprite
	.globl _generateSpriteNoRAM
	.globl _draw_entidad
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_ROM_bank_to_be_mapped_on_slot2	=	0xffff
_ROM_bank_to_be_mapped_on_slot1	=	0xfffe
_ROM_bank_to_be_mapped_on_slot0	=	0xfffd
_SRAM_bank_to_be_mapped_on_slot2	=	0xfffc
_SMS_SRAM	=	0x8000
_finSalto::
	.ds 2
_pajaros::
	.ds 84
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_nextVRAMsprites::
	.ds 2
_vY::
	.ds 2
_alex::
	.ds 6
_spriteAlex::
	.ds 10
_spritePajaro::
	.ds 10
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;./lib/./sprite.c:18: T_sprite generateSprite(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]) {
;	---------------------------------
; Function generateSprite
; ---------------------------------
_generateSprite::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-10
	add	iy, sp
	ld	sp, iy
	ld	e, a
	ld	d, l
;./lib/./sprite.c:19: unsigned char tamano = alto*ancho*2;
	push	de
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00103$:
	add	hl, hl
	jr	NC, 00104$
	add	hl, de
00104$:
	djnz	00103$
	pop	de
	ld	c, l
	sla	c
;./lib/./sprite.c:20: T_sprite sprite = {alto,ancho,tamano,tam/(tamano*32),nextVRAMsprites, 1,0};
	ld	-10 (ix), d
	ld	-9 (ix), e
	ld	-8 (ix), c
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	ex	de, hl
	ld	l, 6 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, 7 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	__divsint
	pop	bc
	ld	-7 (ix), e
	ld	a, (_nextVRAMsprites+0)
	ld	-6 (ix), a
	ld	a, (_nextVRAMsprites+1)
	ld	-5 (ix), a
	ld	-4 (ix), #0x01
	xor	a, a
	ld	-3 (ix), a
	ld	-2 (ix), a
	ld	-1 (ix), #0x00
;./lib/./sprite.c:21: SMS_loadTiles(data,nextVRAMsprites,tam);
	ld	e, 8 (ix)
	ld	d, 9 (ix)
	ld	hl, (_nextVRAMsprites)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	set	6, h
	push	bc
	push	hl
	ld	l, 6 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, 7 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ex	(sp), hl
	call	_SMS_VRAMmemcpy
	pop	bc
;./lib/./sprite.c:22: nextVRAMsprites = nextVRAMsprites + (tamano*sprite.numFrames);
	ld	e, -7 (ix)
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00105$:
	add	hl, hl
	jr	NC, 00106$
	add	hl, de
00106$:
	djnz	00105$
	ex	de, hl
	ld	hl, #_nextVRAMsprites
	ld	a, (hl)
	add	a, e
	ld	(hl), a
	inc	hl
	ld	a, (hl)
	adc	a, d
	ld	(hl), a
;./lib/./sprite.c:23: return sprite;
	ld	hl, #14
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0
	add	hl, sp
	ld	bc, #10
	ldir
;./lib/./sprite.c:24: }
	ld	sp, ix
	pop	ix
	ret
;./lib/./sprite.c:26: T_sprite generateSpriteNoRAM(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]) {
;	---------------------------------
; Function generateSpriteNoRAM
; ---------------------------------
_generateSpriteNoRAM::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-12
	add	iy, sp
	ld	sp, iy
	ld	e, a
	ld	d, l
;./lib/./sprite.c:27: unsigned char tamano = alto*ancho*2;
	push	de
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00103$:
	add	hl, hl
	jr	NC, 00104$
	add	hl, de
00104$:
	djnz	00103$
	pop	de
	ld	c, l
	sla	c
;./lib/./sprite.c:28: T_sprite sprite = {alto,ancho,tamano,tam/(tamano*32),nextVRAMsprites, 0,0};
	ld	-12 (ix), d
	ld	-11 (ix), e
	ld	-10 (ix), c
;	spillPairReg hl
;	spillPairReg hl
	ld	-2 (ix), c
	ld	-1 (ix), #0x00
	ld	l, c
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de,hl
	push	de
	ld	l, 6 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, 7 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	__divsint
	ex	de, hl
	pop	de
	ld	-9 (ix), l
	ld	a, (_nextVRAMsprites+0)
	ld	-8 (ix), a
	ld	a, (_nextVRAMsprites+1)
	ld	-7 (ix), a
	ld	-6 (ix), #0x00
	xor	a, a
	ld	-5 (ix), a
	ld	-4 (ix), a
	ld	-3 (ix), #0x00
;./lib/./sprite.c:29: sprite.data = data;
	ld	a, 8 (ix)
	ld	-5 (ix), a
	ld	a, 9 (ix)
	ld	-4 (ix), a
;./lib/./sprite.c:30: sprite.frameInVRAM = 0;
	ld	-3 (ix), #0x00
;./lib/./sprite.c:31: SMS_loadTiles(data,nextVRAMsprites,tamano*32);
	ld	c, 8 (ix)
	ld	b, 9 (ix)
	ld	hl, (_nextVRAMsprites)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	set	6, h
	push	de
	ld	e, c
	ld	d, b
	call	_SMS_VRAMmemcpy
;./lib/./sprite.c:32: nextVRAMsprites = nextVRAMsprites + (tamano);
	ld	hl, #_nextVRAMsprites
	ld	a, (hl)
	add	a, -2 (ix)
	ld	(hl), a
	inc	hl
	ld	a, (hl)
	adc	a, -1 (ix)
	ld	(hl), a
;./lib/./sprite.c:33: return sprite;
	ld	hl, #16
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0
	add	hl, sp
	ld	bc, #10
	ldir
;./lib/./sprite.c:34: }
	ld	sp, ix
	pop	ix
	ret
;./lib/entities.c:10: void draw_entidad(T_entidad *entidad, T_sprite *sprite){
;	---------------------------------
; Function draw_entidad
; ---------------------------------
_draw_entidad::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-17
	add	iy, sp
	ld	sp, iy
	ld	-4 (ix), l
	ld	-3 (ix), h
;./lib/entities.c:12: if (sprite->allInRAM == 1){
	ld	-6 (ix), e
	ld	-5 (ix), d
	ld	c, e
	ld	b, d
	ld	hl, #6
	add	hl, bc
	ld	c, (hl)
;./lib/entities.c:13: int frame = sprite->tamano*entidad->frame + sprite->beginVRAM;
	ld	e, -6 (ix)
	ld	d, -5 (ix)
	ld	a, -4 (ix)
	add	a, #0x02
	ld	-16 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-15 (ix), a
	ld	a, -6 (ix)
	add	a, #0x04
	ld	-14 (ix), a
	ld	a, -5 (ix)
	adc	a, #0x00
	ld	-13 (ix), a
;./lib/entities.c:14: for(j=0;j<sprite->alto;j++) {
	ld	a, -4 (ix)
	add	a, #0x01
	ld	-8 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-7 (ix), a
	ld	a, -6 (ix)
	add	a, #0x01
	ld	-2 (ix), a
	ld	a, -5 (ix)
	adc	a, #0x00
	ld	-1 (ix), a
;./lib/entities.c:23: int frame = sprite->tamano*entidad->frame*32;
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	ld	a, (hl)
	ld	-12 (ix), a
;./lib/entities.c:13: int frame = sprite->tamano*entidad->frame + sprite->beginVRAM;
	inc	de
	inc	de
	ld	a, (de)
	ld	-11 (ix), a
;./lib/entities.c:12: if (sprite->allInRAM == 1){
	dec	c
	jp	NZ,00108$
;./lib/entities.c:13: int frame = sprite->tamano*entidad->frame + sprite->beginVRAM;
	ld	e, -11 (ix)
	ld	h, -12 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00200$:
	add	hl, hl
	jr	NC, 00201$
	add	hl, de
00201$:
	djnz	00200$
	ld	c, l
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	ld	a, (hl)
	add	a, c
	ld	-17 (ix), a
;./lib/entities.c:14: for(j=0;j<sprite->alto;j++) {
	ld	a, -8 (ix)
	ld	-16 (ix), a
	ld	a, -7 (ix)
	ld	-15 (ix), a
	ld	a, -2 (ix)
	ld	-14 (ix), a
	ld	a, -1 (ix)
	ld	-13 (ix), a
	ld	-2 (ix), #0x00
00114$:
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	a,-2 (ix)
	sub	a,(hl)
	jp	NC, 00122$
;./lib/entities.c:15: unsigned char desplazado = (j<<2);
	ld	a, -2 (ix)
	add	a, a
	add	a, a
;./lib/entities.c:16: unsigned char jCalculated = desplazado + frame, y = entidad->y+(desplazado<<2);
	ld	b, a
	add	a, -17 (ix)
	ld	-12 (ix), a
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	ld	c, (hl)
	ld	a, b
	add	a, a
	add	a, a
	add	a, c
	ld	-11 (ix), a
;./lib/entities.c:17: for(i=0;i<sprite->ancho;i++) {
	ld	-1 (ix), #0x00
00111$:
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	ld	a,-1 (ix)
	sub	a,(hl)
	jr	NC, 00115$
;./lib/entities.c:18: SMS_addSprite(entidad->x+(i<<3),y, jCalculated + (i<<1) );  
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	ld	-7 (ix), a
	ld	-10 (ix), a
	ld	-9 (ix), #0x00
	ld	a, -1 (ix)
	ld	-8 (ix), a
	ld	-7 (ix), #0x00
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	e, -10 (ix)
	ld	d, #0x00
	add	hl, de
	ld	b, l
	ld	c, #0x00
	ld	e, -12 (ix)
	ld	d, #0x00
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	add	hl, hl
	add	hl, de
	ld	a, l
	ld	d, #0x00
	or	a, c
	ld	e, a
	ld	a, d
	or	a, b
	ld	d, a
	ld	l, -11 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_addSprite_f
;./lib/entities.c:17: for(i=0;i<sprite->ancho;i++) {
	inc	-1 (ix)
	jr	00111$
00115$:
;./lib/entities.c:14: for(j=0;j<sprite->alto;j++) {
	inc	-2 (ix)
	jp	00114$
00108$:
;./lib/entities.c:23: int frame = sprite->tamano*entidad->frame*32;
	ld	e, -12 (ix)
	ld	h, -11 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00202$:
	add	hl, hl
	jr	NC, 00203$
	add	hl, de
00203$:
	djnz	00202$
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	-10 (ix), l
	ld	-9 (ix), h
;./lib/entities.c:24: if (entidad->frame != sprite->frameInVRAM){
	ld	a, -6 (ix)
	add	a, #0x09
	ld	c, a
	ld	a, -5 (ix)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	e, a
	ld	a, -12 (ix)
	sub	a, e
	jr	Z, 00133$
;./lib/entities.c:25: SMS_loadTiles(sprite->data + frame,sprite->beginVRAM,sprite->tamano<<5);
	ld	l, -11 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	hl
	pop	iy
	ld	e, -6 (ix)
	ld	d, -5 (ix)
	ld	hl, #7
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, -10 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -9 (ix)
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ex	de, hl
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	set	6, h
	push	bc
	push	iy
	call	_SMS_VRAMmemcpy
	pop	bc
;./lib/entities.c:26: sprite->frameInVRAM = entidad->frame;
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	ld	a, (hl)
	ld	(bc), a
;./lib/entities.c:28: for(j=0;j<sprite->alto;j++) {
00133$:
	ld	a, -2 (ix)
	ld	-10 (ix), a
	ld	a, -1 (ix)
	ld	-9 (ix), a
	ld	-1 (ix), #0x00
00120$:
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	a,-1 (ix)
	sub	a,(hl)
	jr	NC, 00122$
;./lib/entities.c:29: for(i=0;i<sprite->ancho;i++) {
	ld	c, #0x00
00117$:
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	b, (hl)
	ld	a, c
	sub	a, b
	jr	NC, 00121$
;./lib/entities.c:30: SMS_addSprite(entidad->x+(i<<3),entidad->y+(j<<4), (j<<2) + (i<<1) );  
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	ld	e, c
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	a, l
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -1 (ix)
	ld	-12 (ix), a
	ld	-11 (ix), #0x00
	add	a, a
	add	a, a
	ex	de, hl
	add	hl, hl
	ex	de, hl
	add	a, e
	ld	e, a
	ld	d, #0x00
	ld	a, e
	or	a, l
	ld	e, a
	ld	a, d
	or	a, h
	ld	d, a
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	ld	a, (hl)
	ld	b, #0x00
	ld	l, -12 (ix)
	ld	h, -11 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	a, l
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, b
	adc	a, h
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	push	bc
	call	_SMS_addSprite_f
	pop	bc
;./lib/entities.c:29: for(i=0;i<sprite->ancho;i++) {
	inc	c
	jr	00117$
00121$:
;./lib/entities.c:28: for(j=0;j<sprite->alto;j++) {
	inc	-1 (ix)
	jr	00120$
00122$:
;./lib/entities.c:34: }
	ld	sp, ix
	pop	ix
	ret
;./alex.c:7: void moveAlex(int keys)
;	---------------------------------
; Function moveAlex
; ---------------------------------
_moveAlex::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	push	af
	ld	-2 (ix), l
	ld	-1 (ix), h
;./alex.c:10: if (keys & PORT_A_KEY_LEFT)
	ld	a, -2 (ix)
	and	a, #0x04
	ld	-6 (ix), a
	ld	-5 (ix), #0x00
;./alex.c:12: if (keys & PORT_A_KEY_RIGHT)
	ld	a, -2 (ix)
	and	a, #0x08
	ld	-4 (ix), a
	ld	-3 (ix), #0x00
;./alex.c:9: if ((keys & PORT_A_KEY_DOWN) && alex.state == 0){
	bit	1, -2 (ix)
	jr	Z, 00109$
	ld	a, (#_alex + 5)
	or	a, a
	jr	NZ, 00109$
;./alex.c:11: alex.oriented = 1;
	ld	hl, #_alex + 4
;./alex.c:10: if (keys & PORT_A_KEY_LEFT)
	xor	a, a
	or	a, -6 (ix)
	jr	Z, 00102$
;./alex.c:11: alex.oriented = 1;
	ld	(hl), #0x01
00102$:
;./alex.c:12: if (keys & PORT_A_KEY_RIGHT)
	xor	a, a
	or	a, -4 (ix)
	jr	Z, 00104$
;./alex.c:13: alex.oriented = 0;
	ld	(hl), #0x00
00104$:
;./alex.c:14: if (!alex.oriented)
	ld	a, (hl)
;./alex.c:15: alex.frame = 7;
;./alex.c:14: if (!alex.oriented)
	ld	-3 (ix), a
	or	a, a
	jr	NZ, 00106$
;./alex.c:15: alex.frame = 7;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x07
	jr	00107$
00106$:
;./alex.c:17: alex.frame = 15;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x0f
00107$:
;./alex.c:18: alex.lastChangeFrame = 15;
	ld	hl, #_alex + 3
	ld	(hl), #0x0f
;./alex.c:19: return; // not move
	jp	00150$
00109$:
;./alex.c:23: if ((keys & PORT_A_KEY_LEFT) && alex.x > 8 )
	xor	a, a
	or	a, -6 (ix)
	jr	Z, 00121$
	ld	hl, #_alex+0
	ld	c, (hl)
	ld	a, #0x08
	sub	a, c
	jr	NC, 00121$
;./alex.c:25: player_v_x = -1;
	ld	-3 (ix), #0xff
;./alex.c:26: alex.oriented = 1;
	ld	hl, #_alex + 4
	ld	(hl), #0x01
;./alex.c:27: if (alex.frame < 8 || alex.frame > 11)
	ld	hl, #_alex + 2
	ld	c, (hl)
	ld	a, c
	sub	a, #0x08
	jr	C, 00111$
	ld	a, #0x0b
	sub	a, c
	jr	NC, 00122$
00111$:
;./alex.c:28: alex.frame = 8;
	ld	(hl), #0x08
	jr	00122$
00121$:
;./alex.c:31: else if ((keys & PORT_A_KEY_RIGHT) && alex.x <240)
	xor	a, a
	or	a, -4 (ix)
	jr	Z, 00117$
	ld	a, (#_alex + 0)
	sub	a, #0xf0
	jr	NC, 00117$
;./alex.c:33: player_v_x = 1;
	ld	-3 (ix), #0x01
;./alex.c:34: alex.oriented = 0;
	ld	hl, #_alex+4
	ld	(hl), #0x00
	jr	00122$
00117$:
;./alex.c:37: player_v_x = 0;
	ld	-3 (ix), #0x00
;./alex.c:38: alex.frame = 4;
	ld	de, #_alex + 2
	ld	a, #0x04
	ld	(de), a
;./alex.c:39: if (alex.oriented)
	ld	a, (#_alex + 4)
	or	a, a
	jr	Z, 00115$
;./alex.c:40: alex.frame = 12;
	ld	a, #0x0c
	ld	(de), a
00115$:
;./alex.c:41: alex.lastChangeFrame = 15;
	ld	hl, #_alex + 3
	ld	(hl), #0x0f
00122$:
;./alex.c:43: alex.x = alex.x + player_v_x;
	ld	bc, #_alex+0
	ld	a, (bc)
	ld	e, -3 (ix)
	add	a, e
	ld	(bc), a
;./alex.c:44: if (player_v_x != 0){
	ld	a, -3 (ix)
	or	a, a
	jr	Z, 00133$
;./alex.c:45: alex.lastChangeFrame++;
	ld	bc, #_alex + 3
	ld	a, (bc)
	inc	a
	ld	(bc), a
;./alex.c:46: if (alex.lastChangeFrame % 16 == 0)
	and	a, #0x0f
	jr	NZ, 00133$
;./alex.c:48: alex.frame++;
	ld	bc, #_alex + 2
	ld	a, (bc)
	inc	a
	ld	e, a
	ld	(bc), a
;./alex.c:49: if (alex.frame > 3 && !alex.oriented)
	ld	a, #0x03
	sub	a, e
	jr	NC, 00125$
	ld	a, (#(_alex + 4) + 0)
;./alex.c:50: alex.frame = 0;
	or	a,a
	jr	NZ, 00125$
	ld	(bc), a
00125$:
;./alex.c:51: if (alex.frame > 11 && alex.oriented)
	ld	a, (bc)
	ld	e, a
	ld	a, #0x0b
	sub	a, e
	jr	NC, 00133$
	ld	a, (#(_alex + 4) + 0)
	or	a, a
	jr	Z, 00133$
;./alex.c:52: alex.frame = 8;
	ld	a, #0x08
	ld	(bc), a
00133$:
;./alex.c:56: if ((keys & PORT_A_KEY_1) && alex.state == 0) {
	bit	4, -2 (ix)
	jr	Z, 00135$
	ld	hl, #_alex + 5
	ld	a, (hl)
	or	a, a
	jr	NZ, 00135$
;./alex.c:57: alex.state = 1;
	ld	(hl), #0x01
;./alex.c:58: finSalto = alex.y - 70;
	ld	hl, #_alex + 1
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #_finSalto
	ld	a, c
	add	a, #0xba
	ld	(hl), a
	inc	hl
	ld	a, b
	adc	a, #0xff
	ld	(hl), a
;./alex.c:59: vY = -2;
	ld	hl, #0xfffe
	ld	(_vY), hl
00135$:
;./alex.c:61: if (alex.state == 1) {
	ld	hl, #(_alex + 5)
	ld	c, (hl)
;./alex.c:66: if(alex.y == 0 || alex.y == 1 || alex.y < finSalto) {
;./alex.c:61: if (alex.state == 1) {
	dec	c
	jr	NZ, 00149$
;./alex.c:62: if (!alex.oriented)
	ld	a, (#_alex + 4)
;./alex.c:63: alex.frame = 6; //salto
	ld	bc, #_alex + 2
;./alex.c:62: if (!alex.oriented)
	or	a, a
	jr	NZ, 00138$
;./alex.c:63: alex.frame = 6; //salto
	ld	a, #0x06
	ld	(bc), a
	jr	00139$
00138$:
;./alex.c:65: alex.frame = 14;
	ld	a, #0x0e
	ld	(bc), a
00139$:
;./alex.c:66: if(alex.y == 0 || alex.y == 1 || alex.y < finSalto) {
	ld	a, (#(_alex + 1) + 0)
	or	a, a
	jr	Z, 00140$
	cp	a, #0x01
	jr	Z, 00140$
	ld	e, a
	ld	d, #0x00
	ld	hl, #_finSalto
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jp	PO, 00334$
	xor	a, #0x80
00334$:
	jp	P, 00141$
00140$:
;./alex.c:67: vY = 2;
	ld	hl, #0x0002
	ld	(_vY), hl
00141$:
;./alex.c:69: if ((alex.y == 150 || alex.y == 151) && vY > 0) {
	ld	a, (#(_alex + 1) + 0)
	cp	a, #0x96
	jr	Z, 00147$
	sub	a, #0x97
	jr	NZ, 00149$
00147$:
	xor	a, a
	ld	iy, #_vY
	cp	a, 0 (iy)
	sbc	a, 1 (iy)
	jp	PO, 00338$
	xor	a, #0x80
00338$:
	jp	P, 00149$
;./alex.c:70: alex.state = 0;
	ld	hl, #(_alex + 5)
	ld	(hl), #0x00
;./alex.c:71: vY = 0;
	ld	hl, #0x0000
	ld	(_vY), hl
;./alex.c:72: alex.frame = 0;
	xor	a, a
	ld	(bc), a
00149$:
;./alex.c:75: alex.y += vY;
	ld	hl, #(_alex + 1)
	ld	c, (hl)
	ld	a, (_vY+0)
	add	a, c
	ld	(#(_alex + 1)),a
00150$:
;./alex.c:77: }
	ld	sp, ix
	pop	ix
	ret
;main.c:15: void inicializaPajaros()
;	---------------------------------
; Function inicializaPajaros
; ---------------------------------
_inicializaPajaros::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;main.c:18: for (i = 0; i < NUM_PAJAROS; i++)
	ld	c, #0x00
00102$:
;main.c:20: pajaros[i].x = 15 + 32 * i;
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ex	de, hl
	ld	hl, #_pajaros
	add	hl, de
	ex	de, hl
	ld	a, c
	rrca
	rrca
	rrca
	and	a, #0xe0
	add	a, #0x0f
	ld	(de), a
;main.c:21: pajaros[i].y = 15 + 16 * (i / 2);
	ld	l, e
	ld	h, d
	inc	hl
	ex	(sp), hl
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	sra	h
	rr	l
	ld	a, l
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x0f
	pop	hl
	push	hl
	ld	(hl), a
;main.c:22: pajaros[i].lastChangeFrame = i * 3;
	inc	de
	inc	de
	inc	de
	ld	a, c
	add	a, a
	add	a, c
	ld	(de), a
;main.c:18: for (i = 0; i < NUM_PAJAROS; i++)
	inc	c
	ld	a, c
	sub	a, #0x0e
	jr	C, 00102$
;main.c:24: }
	ld	sp, ix
	pop	ix
	ret
;main.c:26: void loadGrapVRAM()
;	---------------------------------
; Function loadGrapVRAM
; ---------------------------------
_loadGrapVRAM::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-20
	add	hl, sp
	ld	sp, hl
;main.c:28: SMS_init();
	call	_SMS_init
;main.c:29: inicializaPajaros();
	call	_inicializaPajaros
;main.c:31: SMS_setSpriteMode(SPRITEMODE_TALL);
	ld	l, #0x01
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setSpriteMode
;main.c:32: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:33: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl, #0x0020
	call	_SMS_VDPturnOnFeature
;main.c:34: SMS_loadBGPalette(sonicpalette_inc);
	ld	hl, #_sonicpalette_inc
	call	_SMS_loadBGPalette
;main.c:35: SMS_loadSpritePalette(palleteAlex_inc);
	ld	hl, #_palleteAlex_inc
	call	_SMS_loadSpritePalette
;main.c:36: SMS_loadTiles(sonictiles_inc, 0, sonictiles_inc_size);
	ld	hl, #0x14c0
	push	hl
	ld	de, #_sonictiles_inc
	ld	hl, #0x4000
	call	_SMS_VRAMmemcpy
;main.c:37: spriteAlex = generateSpriteNoRAM(2, 2, spriteAlex_inc_size, spriteAlex_inc);
	ld	hl, #_spriteAlex_inc
	push	hl
	ld	hl, #0x1000
	push	hl
;	spillPairReg hl
;	spillPairReg hl
	ld	a,#0x02
	ld	l,a
	push	hl
	ld	hl, #0x0006
	add	hl, sp
	ex	de,hl
	pop	hl
	push	de
	call	_generateSpriteNoRAM
	pop	af
	pop	af
	pop	af
	ld	de, #_spriteAlex
	ld	hl, #0
	add	hl, sp
	ld	bc, #0x000a
	ldir
;main.c:38: spritePajaro = generateSprite(3, 1, spritePajaro_inc_size, spritePajaro_inc);
	ld	hl, #_spritePajaro_inc
	push	hl
	ld	hl, #0x0180
	push	hl
	ld	l, #0x01
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x03
	push	hl
	ld	hl, #0x0010
	add	hl, sp
	ex	de,hl
	pop	hl
	push	de
	call	_generateSprite
	pop	af
	pop	af
	pop	af
	ld	de, #_spritePajaro
	ld	hl, #10
	add	hl, sp
	ld	bc, #0x000a
	ldir
;main.c:39: SMS_loadTileMap(0, 0, sonictilemap_inc, sonictilemap_inc_size);
	ld	hl, #0x0600
	push	hl
	ld	de, #_sonictilemap_inc
	ld	h, #0x78
	call	_SMS_VRAMmemcpy
;main.c:40: }
	ld	sp, ix
	pop	ix
	ret
;main.c:42: void dibujaPajaros()
;	---------------------------------
; Function dibujaPajaros
; ---------------------------------
_dibujaPajaros::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;main.c:45: for (i = 0; i < NUM_PAJAROS; i++)
	ld	-1 (ix), #0x00
00106$:
;main.c:47: pajaros[i].x++;
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ex	de, hl
	ld	hl, #_pajaros
	add	hl, de
	ex	de, hl
	ld	a, (de)
	inc	a
	ld	(de), a
;main.c:48: pajaros[i].lastChangeFrame++;
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	inc	bc
	ld	a, (bc)
	inc	a
	ld	(bc), a
;main.c:49: if (pajaros[i].lastChangeFrame == 20)
	sub	a, #0x14
	jr	NZ, 00104$
;main.c:51: pajaros[i].frame++;
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	a, (hl)
	inc	a
	ld	-2 (ix), a
	ld	(hl), a
;main.c:52: if (pajaros[i].frame > 1)
	ld	a, #0x01
	sub	a, -2 (ix)
	jr	NC, 00102$
;main.c:53: pajaros[i].frame = 0;
	ld	(hl), #0x00
00102$:
;main.c:54: pajaros[i].lastChangeFrame = 0;
	xor	a, a
	ld	(bc), a
00104$:
;main.c:56: draw_entidad(&(pajaros[i]), &spritePajaro);
	ex	de, hl
	ld	de, #_spritePajaro
	call	_draw_entidad
;main.c:45: for (i = 0; i < NUM_PAJAROS; i++)
	inc	-1 (ix)
	ld	a, -1 (ix)
	sub	a, #0x0e
	jr	C, 00106$
;main.c:58: }
	ld	sp, ix
	pop	ix
	ret
;main.c:61: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;main.c:66: SMS_VRAMmemsetW(0, 0x0000, 16384);
	ld	-1 (ix), #0x00
	ld	-2 (ix), #0x00
	ld	hl, #0x4000
	push	hl
	ld	de, #0x0000
	ld	h, l
	call	_SMS_VRAMmemsetW
;main.c:76: printf("Hello, World! [1/3]");
	ld	hl, #___str_0
	push	hl
	call	_printf
	pop	af
;main.c:80: loadGrapVRAM();
	call	_loadGrapVRAM
;main.c:82: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:83: SMS_setBGScrollX(scroll_x);
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollX
;main.c:84: SMS_setBGScrollY(scroll_y);
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollY
;main.c:85: SMS_init();
	call	_SMS_init
;main.c:91: PSGPlay(titulo_psg);
	ld	hl, #_titulo_psg
	call	_PSGPlay
;main.c:92: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl, #0x0020
	call	_SMS_VDPturnOnFeature
00111$:
;main.c:97: if (SMS_queryPauseRequested())
	call	_SMS_queryPauseRequested
	bit	0,a
	jr	Z, 00105$
;main.c:99: SMS_resetPauseRequest();
	call	_SMS_resetPauseRequest
;main.c:100: while (!SMS_queryPauseRequested())
00101$:
	call	_SMS_queryPauseRequested
	bit	0,a
	jr	NZ, 00103$
;main.c:102: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:103: PSGFrame();
	call	_PSGFrame
	jr	00101$
00103$:
;main.c:105: SMS_resetPauseRequest();
	call	_SMS_resetPauseRequest
00105$:
;main.c:109: int keys = SMS_getKeysHeld();
	call	_SMS_getKeysHeld
;main.c:110: moveAlex(keys);
	ex	de, hl
	call	_moveAlex
;main.c:111: SMS_initSprites();
	call	_SMS_initSprites
;main.c:112: draw_entidad(&alex, &spriteAlex);
	ld	de, #_spriteAlex
	ld	hl, #_alex
	call	_draw_entidad
;main.c:113: dibujaPajaros();
	call	_dibujaPajaros
;main.c:115: SMS_finalizeSprites();
	call	_SMS_finalizeSprites
;main.c:118: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:119: SMS_copySpritestoSAT();
	call	_SMS_copySpritestoSAT
;main.c:120: PSGFrame();
	call	_PSGFrame
;main.c:121: SMS_displayOff();
	ld	hl, #0x0140
	call	_SMS_VDPturnOffFeature
;main.c:122: if (scroll_y % 2 == 0)
	bit	0, -1 (ix)
	jr	NZ, 00107$
;main.c:123: scroll_x += 1;
	inc	-2 (ix)
00107$:
;main.c:124: scroll_y++;
	inc	-1 (ix)
;main.c:125: if (scroll_y == 224)
	ld	a, -1 (ix)
	sub	a, #0xe0
	jr	NZ, 00109$
;main.c:126: scroll_y = 0;
	ld	-1 (ix), #0x00
00109$:
;main.c:128: SMS_setBGScrollX(scroll_x);
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollX
;main.c:130: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:132: }
	jr	00111$
___str_0:
	.ascii "Hello, World! [1/3]"
	.db 0x00
	.area _CODE
__str_1:
	.ascii "raphnet"
	.db 0x00
__str_2:
	.ascii "basic example"
	.db 0x00
__str_3:
	.ascii "A simple example"
	.db 0x00
	.area _INITIALIZER
__xinit__nextVRAMsprites:
	.dw #0x0100
__xinit__vY:
	.dw #0x0000
__xinit__alex:
	.db #0x0a	; 10
	.db #0x14	; 20
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__spriteAlex:
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x08	; 8
	.db #0x00	; 0
	.dw #0x0000
	.db #0x00	; 0
	.dw #0x0000
	.db #0x00	; 0
__xinit__spritePajaro:
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x08	; 8
	.db #0x00	; 0
	.dw #0x0000
	.db #0x00	; 0
	.dw #0x0000
	.db #0x00	; 0
	.area _CABS (ABS)
	.org 0x7FF0
___SMS__SEGA_signature:
	.db #0x54	; 84	'T'
	.db #0x4d	; 77	'M'
	.db #0x52	; 82	'R'
	.db #0x20	; 32
	.db #0x53	; 83	'S'
	.db #0x45	; 69	'E'
	.db #0x47	; 71	'G'
	.db #0x41	; 65	'A'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0x4c	; 76	'L'
	.org 0x7FD8
___SMS__SDSC_author:
	.ascii "raphnet"
	.db 0x00
	.org 0x7FCA
___SMS__SDSC_name:
	.ascii "basic example"
	.db 0x00
	.org 0x7FB9
___SMS__SDSC_descr:
	.ascii "A simple example"
	.db 0x00
	.org 0x7FE0
___SMS__SDSC_signature:
	.db #0x53	; 83	'S'
	.db #0x44	; 68	'D'
	.db #0x53	; 83	'S'
	.db #0x43	; 67	'C'
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xd8	; 216
	.db #0x7f	; 127
	.db #0xca	; 202
	.db #0x7f	; 127
	.db #0xb9	; 185
	.db #0x7f	; 127
