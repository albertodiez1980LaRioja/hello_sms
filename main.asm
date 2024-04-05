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
	.globl _disableSprites
	.globl _playMusic
	.globl _dibujaPajaros
	.globl _loadGrapVRAM
	.globl _inicializaPajaros
	.globl _moveAlex
	.globl _moveAlexAire
	.globl _moveAlexSuelo
	.globl _canRight
	.globl _canLeft
	.globl _canDown
	.globl _canUp
	.globl _PSGSFXFrame
	.globl _PSGFrame
	.globl _PSGSFXPlay
	.globl _PSGPlay
	.globl _SMS_VRAMmemsetW
	.globl _SMS_VRAMmemcpy
	.globl _SMS_setFrameInterruptHandler
	.globl _SMS_resetPauseRequest
	.globl _SMS_queryPauseRequested
	.globl _SMS_getKeysHeld
	.globl _SMS_getKeysPressed
	.globl _SMS_loadSpritePalette
	.globl _SMS_loadBGPalette
	.globl _SMS_updateSpritePosition
	.globl _SMS_addSprite_f
	.globl _SMS_waitForVBlank
	.globl _SMS_setSpriteMode
	.globl _SMS_setBGScrollY
	.globl _SMS_setBGScrollX
	.globl _SMS_VDPturnOffFeature
	.globl _SMS_VDPturnOnFeature
	.globl _SMS_init
	.globl _copySpritestoSAT
	.globl _addHardwareSprite
	.globl _generateSpriteNoRAM
	.globl _printf
	.globl _spritePuno
	.globl _spritePajaro
	.globl _spriteAlex
	.globl _alex
	.globl _maxSalto
	.globl _nextVRAMsprites
	.globl _numSprites
	.globl _pajaros
	.globl _SMS_SRAM
	.globl _SRAM_bank_to_be_mapped_on_slot2
	.globl _ROM_bank_to_be_mapped_on_slot0
	.globl _ROM_bank_to_be_mapped_on_slot1
	.globl _ROM_bank_to_be_mapped_on_slot2
	.globl _SpriteNextFree2
	.globl _SpriteTableXN2
	.globl _SpriteTableY2
	.globl _hardwareSprites
	.globl _generateSprite
	.globl _initSpritesVariables
	.globl _draw_entidad
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_VDPControlPort	=	0x00bf
_VDPStatusPort	=	0x00bf
_VDPDataPort	=	0x00be
_VDPVCounterPort	=	0x007e
_VDPHCounterPort	=	0x007f
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_hardwareSprites::
	.ds 768
_SpriteTableY2::
	.ds 2
_SpriteTableXN2::
	.ds 2
_SpriteNextFree2::
	.ds 2
_ROM_bank_to_be_mapped_on_slot2	=	0xffff
_ROM_bank_to_be_mapped_on_slot1	=	0xfffe
_ROM_bank_to_be_mapped_on_slot0	=	0xfffd
_SRAM_bank_to_be_mapped_on_slot2	=	0xfffc
_SMS_SRAM	=	0x8000
_pajaros::
	.ds 152
_numSprites::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_nextVRAMsprites::
	.ds 2
_maxSalto::
	.ds 1
_alex::
	.ds 8
_spriteAlex::
	.ds 10
_spritePajaro::
	.ds 10
_spritePuno::
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
;./lib/./sprite.c:20: T_sprite generateSprite(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]) {
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
;./lib/./sprite.c:21: unsigned char tamano = alto*ancho*2;
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
;./lib/./sprite.c:22: T_sprite sprite = {alto,ancho,tamano,tam/(tamano*32),nextVRAMsprites, 1,0};
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
;./lib/./sprite.c:23: SMS_loadTiles(data,nextVRAMsprites,tam);
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
;./lib/./sprite.c:24: nextVRAMsprites = nextVRAMsprites + (tamano*sprite.numFrames);
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
;./lib/./sprite.c:25: return sprite;
	ld	hl, #14
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0
	add	hl, sp
	ld	bc, #10
	ldir
;./lib/./sprite.c:26: }
	ld	sp, ix
	pop	ix
	ret
;./lib/./sprite.c:29: T_sprite generateSpriteNoRAM(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]) {
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
;./lib/./sprite.c:30: unsigned char tamano = alto*ancho*2;
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
;./lib/./sprite.c:31: T_sprite sprite = {alto,ancho,tamano,tam/(tamano*32),nextVRAMsprites, 0,0};
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
;./lib/./sprite.c:32: sprite.data = data;
	ld	a, 8 (ix)
	ld	-5 (ix), a
	ld	a, 9 (ix)
	ld	-4 (ix), a
;./lib/./sprite.c:33: sprite.frameInVRAM = 0;
	ld	-3 (ix), #0x00
;./lib/./sprite.c:34: SMS_loadTiles(data,nextVRAMsprites,tamano*32);
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
;./lib/./sprite.c:35: nextVRAMsprites = nextVRAMsprites + (tamano);
	ld	hl, #_nextVRAMsprites
	ld	a, (hl)
	add	a, -2 (ix)
	ld	(hl), a
	inc	hl
	ld	a, (hl)
	adc	a, -1 (ix)
	ld	(hl), a
;./lib/./sprite.c:36: return sprite;
	ld	hl, #16
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0
	add	hl, sp
	ld	bc, #10
	ldir
;./lib/./sprite.c:37: }
	ld	sp, ix
	pop	ix
	ret
;./lib/./sprite.c:48: unsigned int addHardwareSprite(unsigned int x,unsigned int y,unsigned int vx,unsigned int vy,unsigned int lx,
;	---------------------------------
; Function addHardwareSprite
; ---------------------------------
_addHardwareSprite::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-22
	add	iy, sp
	ld	sp, iy
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-14 (ix), e
	ld	-13 (ix), d
;./lib/./sprite.c:50: unsigned int i = MAX_HARDWARE_SPRITES;
	ld	hl, #0x0040
	ex	(sp), hl
;./lib/./sprite.c:51: while (i) {
	ld	-2 (ix), #0x40
	ld	-1 (ix), #0
00109$:
	ld	a, -1 (ix)
	or	a, -2 (ix)
	jp	Z, 00111$
;./lib/./sprite.c:52: if (!hardwareSprites[i].len) {
	ld	c, -2 (ix)
	ld	b, -1 (ix)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	a, #<(_hardwareSprites)
	add	a, -4 (ix)
	ld	-6 (ix), a
	ld	a, #>(_hardwareSprites)
	adc	a, -3 (ix)
	ld	-5 (ix), a
	ld	a, -6 (ix)
	ld	-4 (ix), a
	ld	a, -5 (ix)
	ld	-3 (ix), a
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	de, #0x000a
	add	hl, de
	ld	a, (hl)
	ld	-4 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-3 (ix), a
	or	a, -4 (ix)
	jp	NZ, 00108$
;./lib/./sprite.c:53: T_HardwareSprite *p = &hardwareSprites[i]; 
	ld	a, -6 (ix)
	ld	-2 (ix), a
	ld	a, -5 (ix)
	ld	-1 (ix), a
	ld	a, -2 (ix)
	ld	-20 (ix), a
	ld	a, -1 (ix)
	ld	-19 (ix), a
;./lib/./sprite.c:54: p->x = x;
	ld	a, -20 (ix)
	add	a, #0x04
	ld	-2 (ix), a
	ld	a, -19 (ix)
	adc	a, #0x00
	ld	-1 (ix), a
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, -12 (ix)
	ld	(hl), a
	inc	hl
	ld	a, -11 (ix)
	ld	(hl), a
;./lib/./sprite.c:55: p->y = y;
	pop	de
	pop	hl
	push	hl
	push	de
	ld	de, #0x0006
	add	hl, de
	ld	a, -14 (ix)
	ld	(hl), a
	inc	hl
	ld	a, -13 (ix)
	ld	(hl), a
;./lib/./sprite.c:56: p->vx = vx;
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	a, 4 (ix)
	ld	(hl), a
	inc	hl
	ld	a, 5 (ix)
	ld	(hl), a
;./lib/./sprite.c:57: p->vy = vy;
	pop	hl
	pop	bc
	push	bc
	push	hl
	inc	bc
	inc	bc
	ld	a, 6 (ix)
	ld	(bc), a
	inc	bc
	ld	a, 7 (ix)
	ld	(bc), a
;./lib/./sprite.c:58: unsigned int iTile = 0;
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
;./lib/./sprite.c:59: for (int iy=0;iy<ly;iy++) {
	ld	a, -14 (ix)
	ld	-10 (ix), a
	ld	a, -13 (ix)
	ld	-9 (ix), a
	xor	a, a
	ld	-8 (ix), a
	ld	-7 (ix), a
00116$:
	ld	a, -8 (ix)
	ld	-4 (ix), a
	ld	a, -7 (ix)
	ld	-3 (ix), a
;./lib/./sprite.c:62: p->initSprite = SMS_addSprite(x,y, tiles[iTile]);
	ld	a, -20 (ix)
	add	a, #0x08
	ld	-18 (ix), a
	ld	a, -19 (ix)
	adc	a, #0x00
	ld	-17 (ix), a
;./lib/./sprite.c:59: for (int iy=0;iy<ly;iy++) {
	ld	a, -4 (ix)
	sub	a, 10 (ix)
	ld	a, -3 (ix)
	sbc	a, 11 (ix)
	jp	NC, 00106$
;./lib/./sprite.c:60: for (int ix=0;ix<lx;ix++){
	ld	a, -2 (ix)
	ld	-6 (ix), a
	ld	a, -1 (ix)
	ld	-5 (ix), a
	ld	a, -12 (ix)
	ld	-4 (ix), a
	ld	a, -11 (ix)
	ld	-3 (ix), a
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
00113$:
	ld	a, -2 (ix)
	ld	-16 (ix), a
	ld	a, -1 (ix)
	ld	-15 (ix), a
	ld	a, -16 (ix)
	sub	a, 8 (ix)
	ld	a, -15 (ix)
	sbc	a, 9 (ix)
	jr	NC, 00129$
;./lib/./sprite.c:62: p->initSprite = SMS_addSprite(x,y, tiles[iTile]);
	ld	b, -4 (ix)
	ld	l, -6 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -5 (ix)
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	ex	de,hl
	ld	l, 12 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, 13 (ix)
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, (hl)
	ld	-16 (ix), e
	ld	-15 (ix), b
;./lib/./sprite.c:61: if(ix==0 && iy == 0) {
	ld	a, -1 (ix)
	or	a, -2 (ix)
	jr	NZ, 00102$
	ld	a, -7 (ix)
	or	a, -8 (ix)
	jr	NZ, 00102$
;./lib/./sprite.c:62: p->initSprite = SMS_addSprite(x,y, tiles[iTile]);
	ld	e, -16 (ix)
	ld	d, -15 (ix)
	ld	l, -10 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -9 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_addSprite_f
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	l, -18 (ix)
	ld	h, -17 (ix)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	jr	00103$
00102$:
;./lib/./sprite.c:65: SMS_addSprite(x,y, tiles[iTile]);
	ld	e, -16 (ix)
	ld	d, -15 (ix)
	ld	l, -10 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -9 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_addSprite_f
00103$:
;./lib/./sprite.c:67: iTile++;
	inc	-6 (ix)
	jr	NZ, 00185$
	inc	-5 (ix)
00185$:
;./lib/./sprite.c:68: x += 8;
	ld	a, -4 (ix)
	add	a, #0x08
	ld	-4 (ix), a
	jr	NC, 00186$
	inc	-3 (ix)
00186$:
;./lib/./sprite.c:60: for (int ix=0;ix<lx;ix++){
	inc	-2 (ix)
	jp	NZ,00113$
	inc	-1 (ix)
	jp	00113$
00129$:
	ld	a, -6 (ix)
	ld	-2 (ix), a
	ld	a, -5 (ix)
	ld	-1 (ix), a
	ld	a, -4 (ix)
	ld	-12 (ix), a
	ld	a, -3 (ix)
	ld	-11 (ix), a
;./lib/./sprite.c:70: y += 16;
	ld	a, -10 (ix)
	add	a, #0x10
	ld	-10 (ix), a
	jr	NC, 00188$
	inc	-9 (ix)
00188$:
;./lib/./sprite.c:59: for (int iy=0;iy<ly;iy++) {
	inc	-8 (ix)
	jp	NZ,00116$
	inc	-7 (ix)
	jp	00116$
00106$:
;./lib/./sprite.c:72: p->len = p->initSprite + lx*ly;
	ld	a, -20 (ix)
	add	a, #0x0a
	ld	-2 (ix), a
	ld	a, -19 (ix)
	adc	a, #0x00
	ld	-1 (ix), a
	ld	l, -18 (ix)
	ld	h, -17 (ix)
	ld	a, (hl)
	ld	-4 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-3 (ix), a
	ld	e, 10 (ix)
	ld	d, 11 (ix)
	ld	l, 8 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, 9 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	__mulint
	ld	-8 (ix), e
	ld	-7 (ix), d
	ld	a, -8 (ix)
	add	a, -4 (ix)
	ld	-6 (ix), a
	ld	a, -7 (ix)
	adc	a, -3 (ix)
	ld	-5 (ix), a
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, -6 (ix)
	ld	(hl), a
	inc	hl
	ld	a, -5 (ix)
	ld	(hl), a
;./lib/./sprite.c:73: return i;
	pop	de
	push	de
	jr	00118$
00108$:
;./lib/./sprite.c:75: i--;
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	dec	hl
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	a, -2 (ix)
	ld	-22 (ix), a
	ld	a, -1 (ix)
	ld	-21 (ix), a
	jp	00109$
00111$:
;./lib/./sprite.c:77: return i;
	pop	de
	push	de
00118$:
;./lib/./sprite.c:78: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	pop	af
	pop	af
	pop	af
	jp	(hl)
;./lib/./sprite.c:90: void initSpritesVariables (void) {
;	---------------------------------
; Function initSpritesVariables
; ---------------------------------
_initSpritesVariables::
;./lib/./sprite.c:92: while (i) {
	ld	bc, #0x0040
00101$:
	ld	a, b
	or	a, c
	jr	Z, 00103$
;./lib/./sprite.c:93: hardwareSprites[i].len = 0;
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	de, #_hardwareSprites
	add	hl, de
	ld	de, #0x000a
	add	hl, de
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;./lib/./sprite.c:94: i--;
	dec	bc
	jr	00101$
00103$:
;./lib/./sprite.c:107: __endasm;
	ld	hl, #_SpriteNextFree
	ld	(#_SpriteNextFree2), hl
	ld	hl, #_SpriteTableY
	ld	(#_SpriteTableY2), hl
	ld	hl, #_SpriteTableXN
	ld	(#_SpriteTableXN2), hl
;./lib/./sprite.c:110: }
	ret
;./lib/./sprite.c:127: void copySpritestoSAT (void) {
;	---------------------------------
; Function copySpritestoSAT
; ---------------------------------
_copySpritestoSAT::
;./lib/./sprite.c:128: SMS_setAddr(SMS_SATAddress);
	ld	hl, #0x7f00
	rst	#0x08
;./lib/./sprite.c:144: __endasm;
	ld	a,(#_SpriteNextFree)
	or	a
	jr	z,_no_sprites
	ld	b,a
	ld	c,#_VDPDataPort
	ld	hl,#_SpriteTableY
_next_spriteY:
	outi	; 16 cycles
	jr	nz,_next_spriteY ; 12 cycles = 28 (VRAM safe on GG too)
	cp	#64 ; 7 cycles
	jr	z,_no_sprite_term ; 7 cycles
	ld	a,#0xD0 ; 7 cycles => VRAM safe
	out	(c),a
_no_sprite_term:
;./lib/./sprite.c:145: SMS_setAddr(SMS_SATAddress+128);
	ld	hl, #0x7f80
	rst	#0x08
;./lib/./sprite.c:160: __endasm;
	ld	c,#_VDPDataPort
	ld	a,(#_SpriteNextFree)
	add	a,a
	ld	b,a
	ld	hl,#_SpriteTableXN
_next_spriteXN:
	outi	; 16 cycles
	jr	nz,_next_spriteXN ; 12 cycles = 28 (VRAM safe on GG too)
	ret
_no_sprites:
	ld	a,#0xD0
	out	(#_VDPDataPort),a
;./lib/./sprite.c:161: }
	ret
;./lib/entities.c:11: void draw_entidad(T_entidad *entidad, T_sprite *sprite){
;	---------------------------------
; Function draw_entidad
; ---------------------------------
_draw_entidad::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-24
	add	iy, sp
	ld	sp, iy
	ld	-4 (ix), l
	ld	-3 (ix), h
;./lib/entities.c:13: if (sprite->allInRAM == 1){
	ld	-6 (ix), e
	ld	-5 (ix), d
	ld	c, e
	ld	b, d
	ld	hl, #6
	add	hl, bc
	ld	c, (hl)
;./lib/entities.c:14: if (entidad->initSprite == 255) {
	ld	a, -4 (ix)
	add	a, #0x06
	ld	-19 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-18 (ix), a
	ld	l, -19 (ix)
	ld	h, -18 (ix)
	ld	b, (hl)
;./lib/entities.c:15: int frame = sprite->tamano*entidad->frame + sprite->beginVRAM;
	ld	a, -6 (ix)
	add	a, #0x02
	ld	-21 (ix), a
	ld	a, -5 (ix)
	adc	a, #0x00
	ld	-20 (ix), a
	ld	a, -4 (ix)
	add	a, #0x02
	ld	-17 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-16 (ix), a
	ld	a, -6 (ix)
	add	a, #0x04
	ld	-15 (ix), a
	ld	a, -5 (ix)
	adc	a, #0x00
	ld	-14 (ix), a
;./lib/entities.c:16: for(j=0;j<sprite->alto;j++) {
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
;./lib/entities.c:26: entidad->len = (sprite->alto * sprite->ancho + entidad->initSprite)*2;
	ld	a, -4 (ix)
	add	a, #0x07
	ld	-24 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-23 (ix), a
;./lib/entities.c:14: if (entidad->initSprite == 255) {
	inc	b
	ld	a, #0x01
	jr	Z, 00253$
	xor	a, a
00253$:
	ld	-13 (ix), a
;./lib/entities.c:13: if (sprite->allInRAM == 1){
	dec	c
	jp	NZ,00120$
;./lib/entities.c:14: if (entidad->initSprite == 255) {
	ld	a, -19 (ix)
	ld	-10 (ix), a
	ld	a, -18 (ix)
	ld	-9 (ix), a
	ld	a, -13 (ix)
	or	a, a
	jp	Z, 00134$
;./lib/entities.c:15: int frame = sprite->tamano*entidad->frame + sprite->beginVRAM;
	ld	l, -21 (ix)
	ld	h, -20 (ix)
	ld	e, (hl)
	ld	l, -17 (ix)
	ld	h, -16 (ix)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00256$:
	add	hl, hl
	jr	NC, 00257$
	add	hl, de
00257$:
	djnz	00256$
	ld	c, l
	ld	l, -15 (ix)
	ld	h, -14 (ix)
	ld	a, (hl)
	add	a, c
	ld	-11 (ix), a
;./lib/entities.c:16: for(j=0;j<sprite->alto;j++) {
	ld	a, -2 (ix)
	ld	-13 (ix), a
	ld	a, -1 (ix)
	ld	-12 (ix), a
	ld	-2 (ix), #0x00
00126$:
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	a, (hl)
	ld	-1 (ix), a
	ld	a, -2 (ix)
	sub	a, -1 (ix)
	jp	NC, 00106$
;./lib/entities.c:17: unsigned char desplazado = (j<<2);
	ld	a, -2 (ix)
	add	a, a
	add	a, a
;./lib/entities.c:18: unsigned char jCalculated = desplazado + frame, y = entidad->y+(desplazado<<2);
	ld	b, a
	add	a, -11 (ix)
	ld	-19 (ix), a
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	ld	c, (hl)
	ld	a, b
	add	a, a
	add	a, a
	add	a, c
	ld	-18 (ix), a
;./lib/entities.c:19: for(i=0;i<sprite->ancho;i++) {
	ld	-1 (ix), #0x00
00123$:
	ld	l, -13 (ix)
	ld	h, -12 (ix)
	ld	a,-1 (ix)
	sub	a,(hl)
	jr	NC, 00127$
;./lib/entities.c:21: entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),y, jCalculated + (i<<1) );  
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	e, (hl)
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	a, -19 (ix)
	ld	-15 (ix), a
	ld	-14 (ix), #0x00
	ld	a, -18 (ix)
	ld	-17 (ix), a
	ld	-16 (ix), #0x00
	ld	d, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	sla	c
	rl	b
	add	hl, de
	ex	de, hl
	ld	l, -15 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	h,a
	or	a, l
	ld	-15 (ix), a
	ld	a, e
	or	a, h
	ld	-14 (ix), a
;./lib/entities.c:20: if(i==0 && j==0)
	ld	a, -1 (ix)
	or	a, a
	jr	NZ, 00102$
	ld	a, -2 (ix)
	or	a, a
	jr	NZ, 00102$
;./lib/entities.c:21: entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),y, jCalculated + (i<<1) );  
	ld	e, -15 (ix)
	ld	d, -14 (ix)
	ld	l, -17 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_addSprite_f
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	(hl), a
	jr	00124$
00102$:
;./lib/entities.c:23: SMS_addSprite(entidad->x+(i<<3),y, jCalculated + (i<<1) );  
	ld	e, -15 (ix)
	ld	d, -14 (ix)
	ld	l, -17 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_addSprite_f
00124$:
;./lib/entities.c:19: for(i=0;i<sprite->ancho;i++) {
	inc	-1 (ix)
	jp	00123$
00127$:
;./lib/entities.c:16: for(j=0;j<sprite->alto;j++) {
	inc	-2 (ix)
	jp	00126$
00106$:
;./lib/entities.c:26: entidad->len = (sprite->alto * sprite->ancho + entidad->initSprite)*2;
	ld	l, -13 (ix)
	ld	h, -12 (ix)
	ld	e, (hl)
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00259$:
	add	hl, hl
	jr	NC, 00260$
	add	hl, de
00260$:
	djnz	00259$
	ld	c, l
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	a, (hl)
	add	a, c
	add	a, a
	pop	hl
	push	hl
	ld	(hl), a
	jp	00134$
00120$:
;./lib/entities.c:30: int frame = sprite->tamano*entidad->frame*32;
	ld	l, -21 (ix)
	ld	h, -20 (ix)
	ld	a, (hl)
	ld	-12 (ix), a
	ld	l, -17 (ix)
	ld	h, -16 (ix)
	ld	a, (hl)
	ld	-11 (ix), a
	ld	e, a
	ld	h, -12 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00261$:
	add	hl, hl
	jr	NC, 00262$
	add	hl, de
00262$:
	djnz	00261$
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	-10 (ix), l
	ld	-9 (ix), h
;./lib/entities.c:31: if (entidad->initSprite == 255) {
	ld	a, -19 (ix)
	ld	-22 (ix), a
	ld	a, -18 (ix)
	ld	-21 (ix), a
	ld	a, -13 (ix)
	or	a, a
	jp	Z, 00134$
;./lib/entities.c:32: if (entidad->frame != sprite->frameInVRAM){
	ld	a, -6 (ix)
	add	a, #0x09
	ld	-19 (ix), a
	ld	a, -5 (ix)
	adc	a, #0x00
	ld	-18 (ix), a
	ld	l, -19 (ix)
	ld	h, -18 (ix)
	ld	a,-11 (ix)
	sub	a,(hl)
	jr	Z, 00151$
;./lib/entities.c:33: SMS_loadTiles(sprite->data + frame,sprite->beginVRAM,sprite->tamano<<5);
	ld	l, -12 (ix)
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
	ld	c, l
	ld	b, h
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
	ld	l, -15 (ix)
	ld	h, -14 (ix)
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
	call	_SMS_VRAMmemcpy
;./lib/entities.c:34: sprite->frameInVRAM = entidad->frame;
	ld	l, -17 (ix)
	ld	h, -16 (ix)
	ld	a, (hl)
	ld	l, -19 (ix)
	ld	h, -18 (ix)
	ld	(hl), a
;./lib/entities.c:36: for(j=0;j<sprite->alto;j++) {
00151$:
	ld	a, -8 (ix)
	ld	-20 (ix), a
	ld	a, -7 (ix)
	ld	-19 (ix), a
	ld	a, -8 (ix)
	ld	-18 (ix), a
	ld	a, -7 (ix)
	ld	-17 (ix), a
	ld	a, -2 (ix)
	ld	-16 (ix), a
	ld	a, -1 (ix)
	ld	-15 (ix), a
	ld	-2 (ix), #0x00
00132$:
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	e, (hl)
	ld	a, -2 (ix)
	sub	a, e
	jp	NC, 00116$
;./lib/entities.c:37: for(i=0;i<sprite->ancho;i++) {
	ld	-1 (ix), #0x00
00129$:
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	ld	a,-1 (ix)
	sub	a,(hl)
	jp	NC, 00133$
;./lib/entities.c:21: entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),y, jCalculated + (i<<1) );  
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
;./lib/entities.c:39: entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),entidad->y+(j<<4), (j<<2) + (i<<1) );  
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	e, -2 (ix)
	ld	d, #0x00
;./lib/entities.c:21: entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),y, jCalculated + (i<<1) );  
	ld	-10 (ix), a
	ld	-9 (ix), #0x00
;./lib/entities.c:39: entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),entidad->y+(j<<4), (j<<2) + (i<<1) );  
	ld	-8 (ix), c
	ld	-7 (ix), b
	ld	a, #0x03
00264$:
	sla	-8 (ix)
	rl	-7 (ix)
	dec	a
	jr	NZ, 00264$
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	sla	c
	rl	b
	ex	de, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	-14 (ix), e
	ld	-13 (ix), d
	ld	a, -10 (ix)
	add	a, -8 (ix)
	ld	e, a
	ld	a, #0x00
	adc	a, -7 (ix)
	add	hl, bc
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	h,a
	or	a, l
	ld	-12 (ix), a
	ld	a, e
	or	a, h
	ld	-11 (ix), a
;./lib/entities.c:38: if(i==0 && j==0)
	ld	a, -1 (ix)
	or	a, a
	jr	NZ, 00112$
	ld	a, -2 (ix)
	or	a, a
	jr	NZ, 00112$
;./lib/entities.c:39: entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),entidad->y+(j<<4), (j<<2) + (i<<1) );  
	ld	l, -18 (ix)
	ld	h, -17 (ix)
	ld	a, (hl)
	ld	-7 (ix), a
	ld	-10 (ix), a
	ld	-9 (ix), #0x00
	ld	a, -14 (ix)
	add	a, -10 (ix)
	ld	-8 (ix), a
	ld	a, -13 (ix)
	adc	a, -9 (ix)
	ld	-7 (ix), a
	ld	e, -12 (ix)
	ld	d, -11 (ix)
	ld	l, -8 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -7 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_addSprite_f
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), a
	jr	00130$
00112$:
;./lib/entities.c:41: SMS_addSprite(entidad->x+(i<<3),entidad->y+(j<<4), (j<<2) + (i<<1) );  
	ld	l, -20 (ix)
	ld	h, -19 (ix)
	ld	c, (hl)
	ld	b, #0x00
	ld	l, -14 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -13 (ix)
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	e, -12 (ix)
	ld	d, -11 (ix)
	call	_SMS_addSprite_f
00130$:
;./lib/entities.c:37: for(i=0;i<sprite->ancho;i++) {
	inc	-1 (ix)
	jp	00129$
00133$:
;./lib/entities.c:36: for(j=0;j<sprite->alto;j++) {
	inc	-2 (ix)
	jp	00132$
00116$:
;./lib/entities.c:44: entidad->len = sprite->alto * sprite->ancho + entidad->initSprite;
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00266$:
	add	hl, hl
	jr	NC, 00267$
	add	hl, de
00267$:
	djnz	00266$
	ld	c, l
	ld	l, -22 (ix)
	ld	h, -21 (ix)
	ld	a, (hl)
	add	a, c
	pop	hl
	push	hl
	ld	(hl), a
00134$:
;./lib/entities.c:50: }
	ld	sp, ix
	pop	ix
	ret
;./alex.c:20: unsigned char canUp(){
;	---------------------------------
; Function canUp
; ---------------------------------
_canUp::
;./alex.c:21: if (alex.x < 2)
	ld	a, (#_alex + 0)
	sub	a, #0x02
	jr	NC, 00102$
;./alex.c:22: return 0;
	xor	a, a
	ret
00102$:
;./alex.c:23: return 1;
	ld	a, #0x01
;./alex.c:24: }
	ret
;./alex.c:26: unsigned char canDown() {
;	---------------------------------
; Function canDown
; ---------------------------------
_canDown::
;./alex.c:27: if (alex.y > 155)
	ld	hl, #_alex+1
	ld	c, (hl)
	ld	a, #0x9b
	sub	a, c
	jr	NC, 00102$
;./alex.c:28: return 0;
	xor	a, a
	ret
00102$:
;./alex.c:29: return 1;
	ld	a, #0x01
;./alex.c:30: }
	ret
;./alex.c:32: unsigned char canLeft() {
;	---------------------------------
; Function canLeft
; ---------------------------------
_canLeft::
;./alex.c:33: if (alex.x < 9)
	ld	a, (#_alex + 0)
	sub	a, #0x09
	jr	NC, 00102$
;./alex.c:34: return 0;
	xor	a, a
	ret
00102$:
;./alex.c:35: return 1;
	ld	a, #0x01
;./alex.c:36: }
	ret
;./alex.c:38: unsigned char canRight() {
;	---------------------------------
; Function canRight
; ---------------------------------
_canRight::
;./alex.c:39: if (alex.x > 238)
	ld	hl, #_alex+0
	ld	c, (hl)
	ld	a, #0xee
	sub	a, c
	jr	NC, 00102$
;./alex.c:40: return 0;
	xor	a, a
	ret
00102$:
;./alex.c:41: return 1;
	ld	a, #0x01
;./alex.c:42: }
	ret
;./alex.c:44: void moveAlexSuelo(int keys) {
;	---------------------------------
; Function moveAlexSuelo
; ---------------------------------
_moveAlexSuelo::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	push	af
	ld	-2 (ix), l
	ld	-1 (ix), h
;./alex.c:46: if (keys & PORT_A_KEY_LEFT)
	ld	a, -2 (ix)
	and	a, #0x04
	ld	-6 (ix), a
	ld	-5 (ix), #0x00
;./alex.c:48: if (keys & PORT_A_KEY_RIGHT)
	ld	a, -2 (ix)
	and	a, #0x08
	ld	-4 (ix), a
	ld	-3 (ix), #0x00
;./alex.c:45: if ((keys & PORT_A_KEY_DOWN)){
	bit	1, -2 (ix)
	jr	Z, 00109$
;./alex.c:46: if (keys & PORT_A_KEY_LEFT)
	xor	a, a
	or	a, -6 (ix)
	jr	Z, 00102$
;./alex.c:47: alex.oriented = 1;
	ld	hl, #_alex+4
	ld	(hl), #0x01
00102$:
;./alex.c:48: if (keys & PORT_A_KEY_RIGHT)
	xor	a, a
	or	a, -4 (ix)
	jr	Z, 00104$
;./alex.c:49: alex.oriented = 0;
	ld	hl, #_alex+4
	ld	(hl), #0x00
00104$:
;./alex.c:50: if (!alex.oriented)
	ld	a,(#_alex + 4)
;./alex.c:51: alex.frame = 7;
;./alex.c:50: if (!alex.oriented)
	ld	-3 (ix), a
	or	a, a
	jr	NZ, 00106$
;./alex.c:51: alex.frame = 7;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x07
	jr	00107$
00106$:
;./alex.c:53: alex.frame = 15;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x0f
00107$:
;./alex.c:54: alex.lastChangeFrame = 15;
	ld	hl, #_alex + 3
	ld	(hl), #0x0f
;./alex.c:55: return; // not move
	jp	00146$
00109$:
;./alex.c:58: if (keys & PORT_A_KEY_2) {
	bit	5, -2 (ix)
	jr	Z, 00116$
;./alex.c:59: if (alex.y > 100)
	ld	bc, #_alex+1
	ld	a, (bc)
	ld	e, a
	ld	a, #0x64
	sub	a, e
	jr	NC, 00111$
;./alex.c:60: maxSalto = alex.y - 100;
	ld	a, e
	ld	hl, #_maxSalto
	add	a, #0x9c
	ld	(hl), a
	jr	00112$
00111$:
;./alex.c:62: maxSalto = 0;
	ld	hl, #_maxSalto
	ld	(hl), #0x00
00112$:
;./alex.c:63: alex.y--;
	ld	a, (bc)
	dec	a
	ld	(bc), a
;./alex.c:64: alex.y--;
	dec	a
	ld	(bc), a
;./alex.c:65: PSGSFXPlay(salto_psg, SFX_CHANNEL1);
	ld	a, #0x08
	push	af
	inc	sp
	ld	hl, #_salto_psg
	call	_PSGSFXPlay
;./alex.c:66: return;
	jp	00146$
00116$:
;./alex.c:68: else if (keys & PORT_A_KEY_1) {
	bit	4, -2 (ix)
	jr	Z, 00117$
;./alex.c:69: alex.state = PUÑETAZO_SUELO;
	ld	hl, #_alex + 5
	ld	(hl), #0x20
;./alex.c:70: alex.lastChangeFrame = 15;
	ld	hl, #_alex + 3
	ld	(hl), #0x0f
00117$:
;./alex.c:72: if(alex.state != PUÑETAZO_SUELO) {
	ld	hl, #(_alex + 5)
	ld	l, (hl)
;	spillPairReg hl
;./alex.c:76: alex.oriented = 1;
;./alex.c:77: alex.lastChangeFrame++;
	ld	bc, #_alex + 3
;./alex.c:80: alex.frame++;
	ld	de, #_alex + 2
;./alex.c:72: if(alex.state != PUÑETAZO_SUELO) {
	ld	a, l
	sub	a, #0x20
	jr	Z, 00144$
;./alex.c:73: if ((keys & PORT_A_KEY_LEFT) && alex.x > 8 )
	xor	a, a
	or	a, -6 (ix)
	jr	Z, 00135$
	ld	hl, #_alex
	ld	l, (hl)
;	spillPairReg hl
	ld	a, #0x08
	sub	a, l
	jr	NC, 00135$
;./alex.c:75: alex.x -= 1;
	ld	a, l
	dec	a
	ld	(#_alex),a
;./alex.c:76: alex.oriented = 1;
	ld	hl, #(_alex + 4)
	ld	(hl), #0x01
;./alex.c:77: alex.lastChangeFrame++;
	ld	a, (bc)
	inc	a
	ld	(bc), a
;./alex.c:78: if (alex.lastChangeFrame == 11) {
	sub	a, #0x0b
	jr	NZ, 00119$
;./alex.c:79: alex.lastChangeFrame = 0;
	xor	a, a
	ld	(bc), a
;./alex.c:80: alex.frame++;
	ld	a, (de)
	inc	a
	ld	(de), a
00119$:
;./alex.c:82: if (alex.frame > 11 || alex.frame < 8)
	ld	a, (de)
	ld	c, a
	ld	a, #0x0b
	sub	a, c
	jr	C, 00120$
	ld	a, c
	sub	a, #0x08
	jp	NC, 00146$
00120$:
;./alex.c:83: alex.frame = 8;
	ld	a, #0x08
	ld	(de), a
	jp	00146$
00135$:
;./alex.c:85: else if ((keys & PORT_A_KEY_RIGHT) && alex.x <240)
	xor	a, a
	or	a, -4 (ix)
	jr	Z, 00131$
	ld	a, (#_alex + 0)
	cp	a, #0xf0
	jr	NC, 00131$
;./alex.c:87: alex.x += 1;
	inc	a
	ld	(#_alex),a
;./alex.c:88: alex.oriented = 0;
	ld	hl, #(_alex + 4)
	ld	(hl), #0x00
;./alex.c:89: alex.lastChangeFrame++;
	ld	a, (bc)
	inc	a
	ld	(bc), a
;./alex.c:90: if (alex.lastChangeFrame == 11) {
	sub	a, #0x0b
	jr	NZ, 00124$
;./alex.c:91: alex.lastChangeFrame = 0;
	xor	a, a
	ld	(bc), a
;./alex.c:92: alex.frame++;
	ld	a, (de)
	inc	a
	ld	(de), a
00124$:
;./alex.c:94: if (alex.frame > 3 || alex.frame < 0)
	ld	a, (de)
	ld	c, a
	ld	a, #0x03
	sub	a, c
	jr	NC, 00146$
;./alex.c:95: alex.frame = 0;
	xor	a, a
	ld	(de), a
	jr	00146$
00131$:
;./alex.c:99: alex.frame = 4;
	ld	a, #0x04
	ld	(de), a
;./alex.c:100: if (alex.oriented)
	ld	a, (#(_alex + 4) + 0)
	or	a, a
	jr	Z, 00129$
;./alex.c:101: alex.frame = 12;
	ld	a, #0x0c
	ld	(de), a
00129$:
;./alex.c:102: alex.lastChangeFrame = 10;
	ld	a, #0x0a
	ld	(bc), a
	jr	00146$
00144$:
;./alex.c:106: if (!alex.oriented) {
	ld	a, (#(_alex + 4) + 0)
;./alex.c:108: SMS_addSprite (alex.x + 16, alex.y + 9, 9);
;./alex.c:106: if (!alex.oriented) {
	ld	-3 (ix), a
	or	a, a
	jr	NZ, 00139$
;./alex.c:107: alex.frame = 5;
	ld	a, #0x05
	ld	(de), a
;./alex.c:108: SMS_addSprite (alex.x + 16, alex.y + 9, 9);
	ld	hl, #_alex
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #0x0010
	add	hl, de
	ld	d, l
	ld	e, #0x09
	ld	a, (#(_alex + 1) + 0)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	a, #0x09
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	jr	NC, 00289$
	inc	h
00289$:
	push	bc
	call	_SMS_addSprite_f
	pop	bc
	jr	00140$
00139$:
;./alex.c:111: alex.frame = 13;
	ld	a, #0x0d
	ld	(de), a
;./alex.c:112: SMS_addSprite (alex.x - 8,  alex.y + 9, 11);
	ld	a, (#_alex + 0)
	add	a, #0xf8
;	spillPairReg hl
;	spillPairReg hl
	ld	d, a
	ld	e, #0x0b
	ld	a, (#(_alex + 1) + 0)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	a, #0x09
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	jr	NC, 00290$
	inc	h
00290$:
	push	bc
	call	_SMS_addSprite_f
	pop	bc
00140$:
;./alex.c:114: alex.lastChangeFrame--;
	ld	a, (bc)
	dec	a
	ld	(bc), a
;./alex.c:115: if(!alex.lastChangeFrame) {
	or	a, a
	jr	NZ, 00146$
;./alex.c:116: alex.state = 0;
	ld	hl, #(_alex + 5)
	ld	(hl), #0x00
00146$:
;./alex.c:119: }
	ld	sp, ix
	pop	ix
	ret
;./alex.c:121: void moveAlexAire(int keys, unsigned char puedeSubir, unsigned char puedeDerecha, unsigned char puedeIzquieda) {
;	---------------------------------
; Function moveAlexAire
; ---------------------------------
_moveAlexAire::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
	ld	-2 (ix), l
	ld	-1 (ix), h
;./alex.c:122: if (alex.y > maxSalto) {
	ld	hl, #(_alex + 1)
	ld	b, (hl)
;./alex.c:123: alex.y -= 2;
	ld	c, b
;./alex.c:122: if (alex.y > maxSalto) {
	ld	a, (_maxSalto+0)
	sub	a, b
	jr	NC, 00102$
;./alex.c:123: alex.y -= 2;
	dec	c
	dec	c
	ld	hl, #(_alex + 1)
	ld	(hl), c
	jr	00103$
00102$:
;./alex.c:126: alex.y += 2; // bajando
	inc	c
	inc	c
	ld	hl, #(_alex + 1)
	ld	(hl), c
;./alex.c:127: maxSalto = 255;
	ld	iy, #_maxSalto
	ld	0 (iy), #0xff
00103$:
;./alex.c:130: if (alex.state != PUÑETAZO_SALTANDO)
;./alex.c:131: alex.oriented = 1;
;./alex.c:129: if (keys & PORT_A_KEY_LEFT) {
	bit	2, -2 (ix)
	jr	Z, 00109$
;./alex.c:130: if (alex.state != PUÑETAZO_SALTANDO)
	ld	a, (#(_alex + 5) + 0)
	sub	a, #0x10
	jr	Z, 00105$
;./alex.c:131: alex.oriented = 1;
	ld	hl, #(_alex + 4)
	ld	(hl), #0x01
00105$:
;./alex.c:132: if (puedeIzquieda)
	ld	a, 6 (ix)
	or	a, a
	jr	Z, 00109$
;./alex.c:133: alex.x -= 2;
	ld	a, (#_alex + 0)
	dec	a
	dec	a
	ld	(#_alex),a
00109$:
;./alex.c:135: if (keys & PORT_A_KEY_RIGHT) {
	bit	3, -2 (ix)
	jr	Z, 00115$
;./alex.c:136: if (alex.state != PUÑETAZO_SALTANDO)
	ld	a, (#(_alex + 5) + 0)
	sub	a, #0x10
	jr	Z, 00111$
;./alex.c:137: alex.oriented = 0;
	ld	hl, #(_alex + 4)
	ld	(hl), #0x00
00111$:
;./alex.c:138: if (puedeDerecha)
	ld	a, 5 (ix)
	or	a, a
	jr	Z, 00115$
;./alex.c:139: alex.x += 2;
	ld	a, (#_alex + 0)
	add	a, #0x02
	ld	(#_alex),a
00115$:
;./alex.c:141: if (alex.state == PUÑETAZO_SALTANDO) {
	ld	hl, #(_alex + 5)
	ld	c, (hl)
;./alex.c:142: alex.lastChangeFrame--;
;./alex.c:147: alex.frame = 5;
;./alex.c:141: if (alex.state == PUÑETAZO_SALTANDO) {
	ld	a, c
	sub	a, #0x10
	jr	NZ, 00127$
;./alex.c:142: alex.lastChangeFrame--;
	ld	hl, #(_alex + 3)
	ld	c, (hl)
	dec	c
	ld	hl, #(_alex + 3)
;./alex.c:143: if  (!alex.lastChangeFrame) {
	ld	a,c
	ld	(hl),a
	or	a, a
	jr	NZ, 00117$
;./alex.c:144: alex.state = 0;
	ld	hl, #(_alex + 5)
	ld	(hl), #0x00
00117$:
;./alex.c:146: if (!alex.oriented) {
	ld	a, (#(_alex + 4) + 0)
	or	a, a
	jr	NZ, 00119$
;./alex.c:147: alex.frame = 5;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x05
;./alex.c:148: SMS_addSprite (alex.x + 16, alex.y + 9, 9);
	ld	hl, #_alex
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x0010
	add	hl, bc
	ld	d, l
	ld	e, #0x09
	ld	hl, #(_alex + 1)
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x0009
	add	hl, bc
	call	_SMS_addSprite_f
	jr	00129$
00119$:
;./alex.c:151: alex.frame = 13;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x0d
;./alex.c:152: SMS_addSprite (alex.x - 8,  alex.y + 9, 11);
	ld	a, (#_alex + 0)
	add	a, #0xf8
	ld	d, a
	ld	e, #0x0b
	ld	hl, #(_alex + 1)
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x0009
	add	hl, bc
	call	_SMS_addSprite_f
	jr	00129$
00127$:
;./alex.c:156: if (!alex.oriented)
	ld	a, (#(_alex + 4) + 0)
	ld	-3 (ix), a
	or	a, a
	jr	NZ, 00122$
;./alex.c:157: alex.frame = 6;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x06
	jr	00123$
00122$:
;./alex.c:159: alex.frame = 14;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x0e
00123$:
;./alex.c:160: if (keys & PORT_A_KEY_1) {
	bit	4, -2 (ix)
	jr	Z, 00129$
;./alex.c:161: alex.state = PUÑETAZO_SALTANDO;
	ld	hl, #(_alex + 5)
	ld	(hl), #0x10
;./alex.c:162: alex.lastChangeFrame = 20;
	ld	hl, #(_alex + 3)
	ld	(hl), #0x14
00129$:
;./alex.c:166: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	inc	sp
	jp	(hl)
;./alex.c:169: void moveAlex(int keys) {
;	---------------------------------
; Function moveAlex
; ---------------------------------
_moveAlex::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;./alex.c:170: unsigned char puedeBajar = canDown();
	push	hl
	call	_canDown
	ld	c, a
	push	bc
	call	_canUp
	ld	-1 (ix), a
	call	_canRight
	ld	e, a
	push	de
	call	_canLeft
	pop	de
	pop	bc
	pop	hl
;./alex.c:174: if (puedeBajar)
	inc	c
	dec	c
	jr	Z, 00102$
;./alex.c:175: moveAlexAire(keys, puedeSubir, puedeDerecha, puedeIzquierda);
	ld	d,a
	push	de
	ld	a, -1 (ix)
	push	af
	inc	sp
	call	_moveAlexAire
	jr	00104$
00102$:
;./alex.c:177: moveAlexSuelo(keys);
	call	_moveAlexSuelo
00104$:
;./alex.c:178: }
	inc	sp
	pop	ix
	ret
;main.c:20: void inicializaPajaros()
;	---------------------------------
; Function inicializaPajaros
; ---------------------------------
_inicializaPajaros::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-9
	add	hl, sp
	ld	sp, hl
;main.c:23: for (i = 0; i < NUM_PAJAROS; i++)
	ld	-1 (ix), #0x00
00108$:
;main.c:25: pajaros[i].x = 15 + 32 * i;
	ld	a, -1 (ix)
	ld	-9 (ix), a
	ld	-8 (ix), #0x00
	pop	hl
	push	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, #<(_pajaros)
	add	a, l
	ld	-7 (ix), a
	ld	a, #>(_pajaros)
	adc	a, h
	ld	-6 (ix), a
	ld	a, -1 (ix)
	rrca
	rrca
	rrca
	and	a, #0xe0
	add	a, #0x0f
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), a
;main.c:26: pajaros[i].y = 15 + 16 * (i / 2);
	ld	a, -7 (ix)
	add	a, #0x01
	ld	-5 (ix), a
	ld	a, -6 (ix)
	adc	a, #0x00
	ld	-4 (ix), a
	ld	a, -9 (ix)
	ld	-3 (ix), a
	ld	a, -8 (ix)
	ld	-2 (ix), a
	bit	7, -8 (ix)
	jr	Z, 00112$
	ld	a, -9 (ix)
	add	a, #0x01
	ld	-3 (ix), a
	ld	a, -8 (ix)
	adc	a, #0x00
	ld	-2 (ix), a
00112$:
	ld	c, -3 (ix)
	ld	b, -2 (ix)
	sra	b
	rr	c
	ld	a, c
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x0f
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	ld	(hl), a
;main.c:27: pajaros[i].lastChangeFrame = i * 3;
	pop	hl
	pop	bc
	push	bc
	push	hl
	inc	bc
	inc	bc
	inc	bc
	ld	a, -1 (ix)
	ld	e, a
	add	a, a
	add	a, e
	ld	(bc), a
;main.c:28: pajaros[i].initSprite = 255;
	ld	a, -7 (ix)
	add	a, #0x06
	ld	e, a
	ld	a, -6 (ix)
	adc	a, #0x00
	ld	d, a
	ld	a, #0xff
	ld	(de), a
;main.c:30: pajaros[i].x++;
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	inc	(hl)
;main.c:31: pajaros[i].lastChangeFrame++;
	ld	a, (bc)
	inc	a
	ld	(bc), a
;main.c:32: if (pajaros[i].lastChangeFrame == 20)
	sub	a, #0x14
	jr	NZ, 00104$
;main.c:34: pajaros[i].frame++;
	ld	l, -7 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -6 (ix)
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	a, (hl)
	inc	a
	ld	-2 (ix), a
	ld	(hl), a
;main.c:35: if (pajaros[i].frame > 1)
	ld	a, #0x01
	sub	a, -2 (ix)
	jr	NC, 00102$
;main.c:36: pajaros[i].frame = 0;
	ld	(hl), #0x00
00102$:
;main.c:37: pajaros[i].lastChangeFrame = 0;
	xor	a, a
	ld	(bc), a
00104$:
;main.c:39: if(pajaros[i].initSprite == 255) {
	ld	a, (de)
	inc	a
	jr	NZ, 00109$
;main.c:40: draw_entidad(&(pajaros[i]), &spritePajaro);
	ld	de, #_spritePajaro
	ld	l, -7 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -6 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_draw_entidad
00109$:
;main.c:23: for (i = 0; i < NUM_PAJAROS; i++)
	inc	-1 (ix)
	ld	a, -1 (ix)
	sub	a, #0x13
	jp	C, 00108$
;main.c:43: }
	ld	sp, ix
	pop	ix
	ret
;main.c:45: void loadGrapVRAM()
;	---------------------------------
; Function loadGrapVRAM
; ---------------------------------
_loadGrapVRAM::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-30
	add	hl, sp
	ld	sp, hl
;main.c:47: SMS_init();
	call	_SMS_init
;main.c:50: SMS_setSpriteMode(SPRITEMODE_TALL);
	ld	l, #0x01
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setSpriteMode
;main.c:51: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:52: SMS_loadBGPalette(sonicpalette_inc);
	ld	hl, #_sonicpalette_inc
	call	_SMS_loadBGPalette
;main.c:53: SMS_loadSpritePalette(palleteAlex_inc);
	ld	hl, #_palleteAlex_inc
	call	_SMS_loadSpritePalette
;main.c:54: SMS_loadTiles(sonictiles_inc, 0, sonictiles_inc_size);
	ld	hl, #0x14c0
	push	hl
	ld	de, #_sonictiles_inc
	ld	hl, #0x4000
	call	_SMS_VRAMmemcpy
;main.c:55: spriteAlex = generateSpriteNoRAM(2, 2, spriteAlex_inc_size, spriteAlex_inc);
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
;main.c:56: spritePuno = generateSprite(1, 2, puno_inc_size, puno_inc);
	ld	hl, #_puno_inc
	push	hl
	ld	hl, #0x0080
	push	hl
	ld	l, #0x02
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x01
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
	ld	de, #_spritePuno
	ld	hl, #10
	add	hl, sp
	ld	bc, #0x000a
	ldir
;main.c:57: spritePajaro = generateSprite(3, 1, spritePajaro_inc_size, spritePajaro_inc);
	ld	hl, #_spritePajaro_inc
	push	hl
	ld	hl, #0x0180
	push	hl
	ld	l, #0x01
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x03
	push	hl
	ld	hl, #0x001a
	add	hl, sp
	ex	de,hl
	pop	hl
	push	de
	call	_generateSprite
	pop	af
	pop	af
	pop	af
	ld	de, #_spritePajaro
	ld	hl, #20
	add	hl, sp
	ld	bc, #0x000a
	ldir
;main.c:58: inicializaPajaros();
	call	_inicializaPajaros
;main.c:59: SMS_loadTileMap(0, 0, sonictilemap_inc, sonictilemap_inc_size);
	ld	hl, #0x0600
	push	hl
	ld	de, #_sonictilemap_inc
	ld	h, #0x78
	call	_SMS_VRAMmemcpy
;main.c:60: }
	ld	sp, ix
	pop	ix
	ret
;main.c:62: void dibujaPajaros()
;	---------------------------------
; Function dibujaPajaros
; ---------------------------------
_dibujaPajaros::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-11
	add	hl, sp
	ld	sp, hl
;main.c:65: for (i = 0; i < NUM_PAJAROS; i++)
	ld	-2 (ix), #0x00
00117$:
;main.c:67: T_entidad *p = &pajaros[i];
	ld	a, -2 (ix)
	ld	-7 (ix), a
	ld	-6 (ix), #0x00
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #_pajaros
	add	hl, de
;main.c:68: p->x++;
	ld	-5 (ix), l
	ld	-4 (ix), h
	ld	a, (hl)
	inc	a
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	ld	(hl), a
;main.c:69: p->lastChangeFrame++;
	ld	a, -5 (ix)
	add	a, #0x03
	ld	-11 (ix), a
	ld	a, -4 (ix)
	adc	a, #0x00
	ld	-10 (ix), a
	pop	hl
	push	hl
	ld	a, (hl)
	inc	a
	pop	hl
	push	hl
	ld	(hl), a
;main.c:70: if (p->lastChangeFrame == 20)
	sub	a, #0x14
	jp	NZ,00106$
;main.c:72: p->frame++;
	ld	a, -5 (ix)
	add	a, #0x02
	ld	-9 (ix), a
	ld	a, -4 (ix)
	adc	a, #0x00
	ld	-8 (ix), a
	ld	l, -9 (ix)
	ld	h, -8 (ix)
	ld	c, (hl)
	inc	c
	pop	de
	pop	hl
	push	hl
	push	de
	ld	(hl), c
;main.c:73: if (p->frame > 1)
	ld	a, #0x01
	sub	a, c
	jr	NC, 00102$
;main.c:74: p->frame = 0;
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x00
00102$:
;main.c:75: p->lastChangeFrame = 0;
	pop	hl
	ld	(hl), #0x00
	push	hl
;main.c:76: int frame = spritePajaro.tamano*p->frame + spritePajaro.beginVRAM;
	ld	hl, #_spritePajaro + 2
	ld	e, (hl)
	ld	l, -9 (ix)
	ld	h, -8 (ix)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00189$:
	add	hl, hl
	jr	NC, 00190$
	add	hl, de
00190$:
	djnz	00189$
	ld	c, l
	ld	a, (#_spritePajaro + 4)
	add	a, c
	ld	-3 (ix), a
;main.c:77: for(j=0;j<spritePajaro.alto;j++) {
	ld	-1 (ix), #0x00
00115$:
	ld	hl, #_spritePajaro
	ld	a,-1 (ix)
	sub	a,(hl)
	jr	NC, 00106$
;main.c:78: unsigned char desplazado = (j<<2);
	ld	a, -1 (ix)
	add	a, a
	add	a, a
;main.c:79: unsigned char jCalculated = desplazado + frame, y = p->y+(desplazado<<2);
	add	a, -3 (ix)
	ld	e, a
;main.c:80: for(i2=0;i2<spritePajaro.ancho;i2++) {
	ld	d, #0x00
00112$:
	ld	hl, #_spritePajaro + 1
	ld	c, (hl)
	ld	a, d
	sub	a, c
	jr	NC, 00116$
;main.c:81: SpriteTableXN2[(i2+i*3)*2+1] = jCalculated + (i2<<1);
	ld	c, d
	ld	b, #0x00
	push	de
	ld	e, -7 (ix)
	ld	d, -6 (ix)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	pop	de
	add	hl, bc
	add	hl, hl
	inc	hl
	ld	c, l
	ld	b, h
	ld	a, c
	ld	iy, #_SpriteTableXN2
	add	a, 0 (iy)
	ld	c, a
	ld	a, b
	adc	a, 1 (iy)
	ld	b, a
	ld	a, d
	add	a, a
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	add	a, l
	ld	(bc), a
;main.c:80: for(i2=0;i2<spritePajaro.ancho;i2++) {
	inc	d
	jr	00112$
00116$:
;main.c:77: for(j=0;j<spritePajaro.alto;j++) {
	inc	-1 (ix)
	jr	00115$
00106$:
;main.c:85: end = p->len;
	ld	c, -5 (ix)
	ld	b, -4 (ix)
	ld	hl, #7
	add	hl, bc
	ld	c, (hl)
;main.c:86: i2 = p->initSprite << 1;
	ld	e, -5 (ix)
	ld	d, -4 (ix)
	ld	hl, #6
	add	hl, de
	ld	a, (hl)
	add	a, a
	ld	b, a
;main.c:87: while(i2<end) {
00107$:
;main.c:88: SpriteTableXN2[i2] += 1;
	ld	a,b
	cp	a,c
	jr	NC, 00118$
	ld	hl, #_SpriteTableXN2
	add	a, (hl)
	inc	hl
	ld	e, a
	ld	a, #0x00
	adc	a, (hl)
	ld	d, a
	ld	a, (de)
	inc	a
	ld	(de), a
;main.c:89: i2 +=2;
	inc	b
	inc	b
	jr	00107$
00118$:
;main.c:65: for (i = 0; i < NUM_PAJAROS; i++)
	inc	-2 (ix)
	ld	a, -2 (ix)
	sub	a, #0x13
	jp	C, 00117$
;main.c:94: }
	ld	sp, ix
	pop	ix
	ret
;main.c:96: void playMusic() {
;	---------------------------------
; Function playMusic
; ---------------------------------
_playMusic::
;main.c:97: PSGFrame();
	call	_PSGFrame
;main.c:98: PSGSFXFrame();
;main.c:99: }
	jp	_PSGSFXFrame
;main.c:101: void disableSprites() {
;	---------------------------------
; Function disableSprites
; ---------------------------------
_disableSprites::
;main.c:104: while (i < 64) {
	ld	c, #0x00
00101$:
	ld	a, c
	sub	a, #0x40
	jr	NC, 00103$
;main.c:105: SMS_updateSpritePosition(i,10,240); 
	ld	b, c
	push	bc
	ld	a, #0xf0
	push	af
	inc	sp
	ld	l, #0x0a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, b
	call	_SMS_updateSpritePosition
	pop	bc
;main.c:106: i++;
	inc	c
	jr	00101$
00103$:
;main.c:108: numSprites = 0;
	ld	hl, #0x0000
	ld	(_numSprites), hl
;main.c:109: }
	ret
;main.c:111: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;main.c:116: SMS_VRAMmemsetW(0, 0x0000, 16384);
	ld	-1 (ix), #0x00
	ld	-2 (ix), #0x00
	ld	hl, #0x4000
	push	hl
	ld	de, #0x0000
	ld	h, l
	call	_SMS_VRAMmemsetW
;main.c:126: printf("Hello, World! [1/3]");
	ld	hl, #___str_0
	push	hl
	call	_printf
	pop	af
;main.c:131: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:132: SMS_setBGScrollX(scroll_x);
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollX
;main.c:133: SMS_setBGScrollY(scroll_y);
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollY
;main.c:134: SMS_init();
	call	_SMS_init
;main.c:135: initSpritesVariables();
	call	_initSpritesVariables
;main.c:136: loadGrapVRAM();
	call	_loadGrapVRAM
;main.c:142: PSGPlay(special_psg);
	ld	hl, #_special_psg
	call	_PSGPlay
;main.c:143: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl, #0x0020
	call	_SMS_VDPturnOnFeature
;main.c:147: SMS_setFrameInterruptHandler(playMusic);
	ld	hl, #_playMusic
	call	_SMS_setFrameInterruptHandler
00115$:
;main.c:152: if (SMS_queryPauseRequested())
	call	_SMS_queryPauseRequested
	bit	0,a
	jr	Z, 00105$
;main.c:154: PSGPlay(emeraldhill_psg);
	ld	hl, #_emeraldhill_psg
	call	_PSGPlay
;main.c:155: SMS_resetPauseRequest();
	call	_SMS_resetPauseRequest
;main.c:156: while (!SMS_queryPauseRequested())
00101$:
	call	_SMS_queryPauseRequested
	bit	0,a
	jr	NZ, 00103$
;main.c:158: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
	jr	00101$
00103$:
;main.c:162: SMS_resetPauseRequest();
	call	_SMS_resetPauseRequest
;main.c:163: PSGPlay(titulo_psg);
	ld	hl, #_titulo_psg
	call	_PSGPlay
00105$:
;main.c:167: int keys = SMS_getKeysHeld();
	call	_SMS_getKeysHeld
	ex	de, hl
;main.c:168: if(keys & PORT_A_KEY_2)
	bit	5, l
	jr	Z, 00107$
;main.c:169: keys = keys  ^ PORT_A_KEY_2;
	ld	a, l
	xor	a, #0x20
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
00107$:
;main.c:170: if(keys & PORT_A_KEY_1)
	bit	4, l
	jr	Z, 00109$
;main.c:171: keys = keys  ^ PORT_A_KEY_1;
	ld	a, l
	xor	a, #0x10
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
00109$:
;main.c:173: keys = keys | (SMS_getKeysPressed() & (PORT_A_KEY_2 | PORT_A_KEY_1));
	push	hl
	call	_SMS_getKeysPressed
	pop	hl
	ld	a, e
	and	a, #0x30
	or	a, l
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;main.c:176: moveAlex(keys);
	call	_moveAlex
;main.c:177: draw_entidad(&alex, &spriteAlex);
	ld	de, #_spriteAlex
	ld	hl, #_alex
	call	_draw_entidad
;main.c:178: dibujaPajaros();
	call	_dibujaPajaros
;main.c:183: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:186: SMS_displayOff();
	ld	hl, #0x0140
	call	_SMS_VDPturnOffFeature
;main.c:189: copySpritestoSAT();
	call	_copySpritestoSAT
;main.c:196: if (scroll_y % 2 == 0)
	bit	0, -1 (ix)
	jr	NZ, 00111$
;main.c:197: scroll_x += 1;
	inc	-2 (ix)
00111$:
;main.c:198: scroll_y++;
	inc	-1 (ix)
;main.c:199: if (scroll_y == 224)
	ld	a, -1 (ix)
	sub	a, #0xe0
	jr	NZ, 00113$
;main.c:200: scroll_y = 0;
	ld	-1 (ix), #0x00
00113$:
;main.c:202: SMS_setBGScrollX(scroll_x);
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollX
;main.c:204: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:206: }
	jp	00115$
___str_0:
	.ascii "Hello, World! [1/3]"
	.db 0x00
	.area _CODE
__str_1:
	.ascii "SEGA"
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
__xinit__maxSalto:
	.db #0xff	; 255
__xinit__alex:
	.db #0x1e	; 30
	.db #0x14	; 20
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
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
__xinit__spritePuno:
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
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x4c	; 76	'L'
	.org 0x7FDB
___SMS__SDSC_author:
	.ascii "SEGA"
	.db 0x00
	.org 0x7FCD
___SMS__SDSC_name:
	.ascii "basic example"
	.db 0x00
	.org 0x7FBC
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
	.db #0xdb	; 219
	.db #0x7f	; 127
	.db #0xcd	; 205
	.db #0x7f	; 127
	.db #0xbc	; 188
	.db #0x7f	; 127
