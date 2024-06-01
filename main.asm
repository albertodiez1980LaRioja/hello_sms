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
	.globl _drawAlex
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
	.globl _SMS_setSpritePaletteColor
	.globl _SMS_updateSpritePosition
	.globl _SMS_addSprite_f
	.globl _SMS_initSprites
	.globl _SMS_waitForVBlank
	.globl _SMS_setSpriteMode
	.globl _SMS_setBGScrollY
	.globl _SMS_setBGScrollX
	.globl _SMS_VDPturnOnFeature
	.globl _SMS_init
	.globl _copySpritestoSAT
	.globl _addHardwareSprite
	.globl _generateSpriteNoRAM
	.globl _generateSpriteFlip
	.globl _printf
	.globl _spritePuno
	.globl _spritePajaro
	.globl _spriteAlex
	.globl _lastFrame
	.globl _alex
	.globl _maxSalto
	.globl _flipArray
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
	.globl _buffer64
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
_buffer64::
	.ds 64
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
	.ds 266
_numSprites::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_nextVRAMsprites::
	.ds 2
_flipArray::
	.ds 256
_maxSalto::
	.ds 1
_alex::
	.ds 14
_lastFrame::
	.ds 1
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
;./lib/./sprite.c:24: T_sprite generateSpriteFlip(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]) {
;	---------------------------------
; Function generateSpriteFlip
; ---------------------------------
_generateSpriteFlip::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-20
	add	iy, sp
	ld	sp, iy
;./lib/./sprite.c:25: unsigned char tamano = alto*ancho*2;
	ld	-7 (ix), a
	ld	-8 (ix), l
	ld	e, a
	ld	h, l
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00175$:
	add	hl, hl
	jr	NC, 00176$
	add	hl, de
00176$:
	djnz	00175$
	ld	c, l
	sla	c
;./lib/./sprite.c:26: T_sprite sprite = {alto,ancho,tamano,tam/(tamano*32),nextVRAMsprites, 1,0};
	ld	a, -8 (ix)
	ld	-20 (ix), a
	ld	a, -7 (ix)
	ld	-19 (ix), a
	ld	-18 (ix), c
	ld	-2 (ix), c
	ld	-1 (ix), #0x00
	ld	l, c
	ld	h, #0x00
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
	ld	-17 (ix), e
	ld	a, (_nextVRAMsprites+0)
	ld	-16 (ix), a
	ld	a, (_nextVRAMsprites+1)
	ld	-15 (ix), a
	ld	-14 (ix), #0x01
	xor	a, a
	ld	-13 (ix), a
	ld	-12 (ix), a
	ld	-11 (ix), #0x00
;./lib/./sprite.c:27: SMS_loadTiles(data,nextVRAMsprites,tam);
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
;./lib/./sprite.c:28: nextVRAMsprites = nextVRAMsprites + (tamano*sprite.numFrames);
	ld	e, -17 (ix)
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00177$:
	add	hl, hl
	jr	NC, 00178$
	add	hl, de
00178$:
	djnz	00177$
	ex	de, hl
	ld	hl, #_nextVRAMsprites
	ld	a, (hl)
	add	a, e
	ld	(hl), a
	inc	hl
	ld	a, (hl)
	adc	a, d
	ld	(hl), a
;./lib/./sprite.c:30: unsigned char y,x, numFrames = tamano/(alto*ancho);
	ld	e, -7 (ix)
	ld	h, -8 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00179$:
	add	hl, hl
	jr	NC, 00180$
	add	hl, de
00180$:
	djnz	00179$
	ex	de, hl
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	__divsint
	ld	-6 (ix), e
;./lib/./sprite.c:31: int offset = 0, yOffset = 0;
	ld	bc, #0x0000
	ld	d, b
	ld	e, c
;./lib/./sprite.c:32: while(numFrames) {
00110$:
	ld	a, -6 (ix)
	or	a, a
	jp	Z, 00112$
;./lib/./sprite.c:34: while (y) {
	ld	a, -8 (ix)
	ld	-5 (ix), a
00107$:
	ld	a, -5 (ix)
	or	a, a
	jp	Z, 00109$
;./lib/./sprite.c:36: offset = offset + x*64 - 64; // voy al principio del último tile
	ld	l, -7 (ix)
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
	add	hl, hl
	add	hl, bc
	ld	a, l
	add	a, #0xc0
	ld	-4 (ix), a
	ld	a, h
	adc	a, #0xff
	ld	-3 (ix), a
;./lib/./sprite.c:37: while(x) {
	ld	c, e
	ld	b, d
	ld	a, -7 (ix)
	ld	-2 (ix), a
00104$:
	ld	a, -2 (ix)
	or	a, a
	jr	Z, 00124$
;./lib/./sprite.c:40: while(i<64){
	ld	e, -4 (ix)
	ld	d, -3 (ix)
	ld	-1 (ix), #0x00
00101$:
	ld	a, -1 (ix)
	sub	a, #0x40
	jr	NC, 00103$
;./lib/./sprite.c:41: buffer64[i] = flipArray[data[offset2]];
	ld	a, #<(_buffer64)
	add	a, -1 (ix)
	ld	-10 (ix), a
	ld	a, #>(_buffer64)
	adc	a, #0x00
	ld	-9 (ix), a
	ld	l, 8 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, 9 (ix)
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	a, (hl)
	add	a, #<(_flipArray)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x00
	adc	a, #>(_flipArray)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (hl)
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	(hl), a
;./lib/./sprite.c:42: offset2++;
	inc	de
;./lib/./sprite.c:43: i++;
	inc	-1 (ix)
	jr	00101$
00103$:
;./lib/./sprite.c:45: SMS_loadTiles(&buffer64,nextVRAMsprites,64);
	ld	hl, (_nextVRAMsprites)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	set	6, h
	push	bc
	ld	de, #0x0040
	push	de
	ld	de, #_buffer64
	call	_SMS_VRAMmemcpy
	pop	bc
;./lib/./sprite.c:46: offset = offset - 64; // voy al anterior tile
	ld	a, -4 (ix)
	add	a, #0xc0
	ld	-4 (ix), a
	ld	a, -3 (ix)
	adc	a, #0xff
	ld	-3 (ix), a
;./lib/./sprite.c:47: yOffset = yOffset + 64;
	ld	hl, #0x0040
	add	hl, bc
	ld	c, l
	ld	b, h
;./lib/./sprite.c:48: nextVRAMsprites += 2;
	ld	hl, (_nextVRAMsprites)
	inc	hl
	inc	hl
	ld	(_nextVRAMsprites), hl
;./lib/./sprite.c:49: x--;
	dec	-2 (ix)
	jr	00104$
00124$:
	ld	e, c
	ld	d, b
;./lib/./sprite.c:51: offset = yOffset;
;./lib/./sprite.c:52: y--;
	dec	-5 (ix)
	jp	00107$
00109$:
;./lib/./sprite.c:54: numFrames--;
	dec	-6 (ix)
	jp	00110$
00112$:
;./lib/./sprite.c:56: return sprite;
	ld	hl, #24
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0
	add	hl, sp
	ld	bc, #10
	ldir
;./lib/./sprite.c:57: }
	ld	sp, ix
	pop	ix
	ret
;./lib/./sprite.c:61: T_sprite generateSprite(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]) {
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
;./lib/./sprite.c:62: unsigned char tamano = alto*ancho*2;
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
;./lib/./sprite.c:63: T_sprite sprite = {alto,ancho,tamano,tam/(tamano*32),nextVRAMsprites, 1,0};
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
;./lib/./sprite.c:64: SMS_loadTiles(data,nextVRAMsprites,tam);
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
;./lib/./sprite.c:65: nextVRAMsprites = nextVRAMsprites + (tamano*sprite.numFrames);
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
;./lib/./sprite.c:66: return sprite;
	ld	hl, #14
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0
	add	hl, sp
	ld	bc, #10
	ldir
;./lib/./sprite.c:67: }
	ld	sp, ix
	pop	ix
	ret
;./lib/./sprite.c:70: T_sprite generateSpriteNoRAM(unsigned char ancho, unsigned char alto, int tam,const unsigned char data[]) {
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
;./lib/./sprite.c:71: unsigned char tamano = alto*ancho*2;
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
;./lib/./sprite.c:72: T_sprite sprite = {alto,ancho,tamano,tam/(tamano*32),nextVRAMsprites, 0,0};
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
;./lib/./sprite.c:73: sprite.data = data;
	ld	a, 8 (ix)
	ld	-5 (ix), a
	ld	a, 9 (ix)
	ld	-4 (ix), a
;./lib/./sprite.c:74: sprite.frameInVRAM = 0;
	ld	-3 (ix), #0x00
;./lib/./sprite.c:75: SMS_loadTiles(data,nextVRAMsprites,tamano*32);
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
;./lib/./sprite.c:76: nextVRAMsprites = nextVRAMsprites + (tamano);
	ld	hl, #_nextVRAMsprites
	ld	a, (hl)
	add	a, -2 (ix)
	ld	(hl), a
	inc	hl
	ld	a, (hl)
	adc	a, -1 (ix)
	ld	(hl), a
;./lib/./sprite.c:77: return sprite;
	ld	hl, #16
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0
	add	hl, sp
	ld	bc, #10
	ldir
;./lib/./sprite.c:78: }
	ld	sp, ix
	pop	ix
	ret
;./lib/./sprite.c:89: unsigned int addHardwareSprite(unsigned int x,unsigned int y,unsigned int vx,unsigned int vy,unsigned int lx,
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
;./lib/./sprite.c:91: unsigned int i = MAX_HARDWARE_SPRITES;
	ld	hl, #0x0040
	ex	(sp), hl
;./lib/./sprite.c:92: while (i) {
	ld	-2 (ix), #0x40
	ld	-1 (ix), #0
00109$:
	ld	a, -1 (ix)
	or	a, -2 (ix)
	jp	Z, 00111$
;./lib/./sprite.c:93: if (!hardwareSprites[i].len) {
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
;./lib/./sprite.c:94: T_HardwareSprite *p = &hardwareSprites[i]; 
	ld	a, -6 (ix)
	ld	-2 (ix), a
	ld	a, -5 (ix)
	ld	-1 (ix), a
	ld	a, -2 (ix)
	ld	-20 (ix), a
	ld	a, -1 (ix)
	ld	-19 (ix), a
;./lib/./sprite.c:95: p->x = x;
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
;./lib/./sprite.c:96: p->y = y;
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
;./lib/./sprite.c:97: p->vx = vx;
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	a, 4 (ix)
	ld	(hl), a
	inc	hl
	ld	a, 5 (ix)
	ld	(hl), a
;./lib/./sprite.c:98: p->vy = vy;
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
;./lib/./sprite.c:99: unsigned int iTile = 0;
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
;./lib/./sprite.c:100: for (int iy=0;iy<ly;iy++) {
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
;./lib/./sprite.c:103: p->initSprite = SMS_addSprite(x,y, tiles[iTile]);
	ld	a, -20 (ix)
	add	a, #0x08
	ld	-18 (ix), a
	ld	a, -19 (ix)
	adc	a, #0x00
	ld	-17 (ix), a
;./lib/./sprite.c:100: for (int iy=0;iy<ly;iy++) {
	ld	a, -4 (ix)
	sub	a, 10 (ix)
	ld	a, -3 (ix)
	sbc	a, 11 (ix)
	jp	NC, 00106$
;./lib/./sprite.c:101: for (int ix=0;ix<lx;ix++){
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
;./lib/./sprite.c:103: p->initSprite = SMS_addSprite(x,y, tiles[iTile]);
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
;./lib/./sprite.c:102: if(ix==0 && iy == 0) {
	ld	a, -1 (ix)
	or	a, -2 (ix)
	jr	NZ, 00102$
	ld	a, -7 (ix)
	or	a, -8 (ix)
	jr	NZ, 00102$
;./lib/./sprite.c:103: p->initSprite = SMS_addSprite(x,y, tiles[iTile]);
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
;./lib/./sprite.c:106: SMS_addSprite(x,y, tiles[iTile]);
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
;./lib/./sprite.c:108: iTile++;
	inc	-6 (ix)
	jr	NZ, 00185$
	inc	-5 (ix)
00185$:
;./lib/./sprite.c:109: x += 8;
	ld	a, -4 (ix)
	add	a, #0x08
	ld	-4 (ix), a
	jr	NC, 00186$
	inc	-3 (ix)
00186$:
;./lib/./sprite.c:101: for (int ix=0;ix<lx;ix++){
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
;./lib/./sprite.c:111: y += 16;
	ld	a, -10 (ix)
	add	a, #0x10
	ld	-10 (ix), a
	jr	NC, 00188$
	inc	-9 (ix)
00188$:
;./lib/./sprite.c:100: for (int iy=0;iy<ly;iy++) {
	inc	-8 (ix)
	jp	NZ,00116$
	inc	-7 (ix)
	jp	00116$
00106$:
;./lib/./sprite.c:113: p->len = p->initSprite + lx*ly;
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
;./lib/./sprite.c:114: return i;
	pop	de
	push	de
	jr	00118$
00108$:
;./lib/./sprite.c:116: i--;
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
;./lib/./sprite.c:118: return i;
	pop	de
	push	de
00118$:
;./lib/./sprite.c:119: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	pop	af
	pop	af
	pop	af
	jp	(hl)
;./lib/./sprite.c:131: void initSpritesVariables (void) {
;	---------------------------------
; Function initSpritesVariables
; ---------------------------------
_initSpritesVariables::
;./lib/./sprite.c:133: while (i) {
	ld	bc, #0x0040
00101$:
	ld	a, b
	or	a, c
	jr	Z, 00103$
;./lib/./sprite.c:134: hardwareSprites[i].len = 0;
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
;./lib/./sprite.c:135: i--;
	dec	bc
	jr	00101$
00103$:
;./lib/./sprite.c:148: __endasm;
	ld	hl, #_SpriteNextFree
	ld	(#_SpriteNextFree2), hl
	ld	hl, #_SpriteTableY
	ld	(#_SpriteTableY2), hl
	ld	hl, #_SpriteTableXN
	ld	(#_SpriteTableXN2), hl
;./lib/./sprite.c:151: }
	ret
;./lib/./sprite.c:168: void copySpritestoSAT (void) {
;	---------------------------------
; Function copySpritestoSAT
; ---------------------------------
_copySpritestoSAT::
;./lib/./sprite.c:169: SMS_setAddr(SMS_SATAddress);
	ld	hl, #0x7f00
	rst	#0x08
;./lib/./sprite.c:185: __endasm;
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
;./lib/./sprite.c:186: SMS_setAddr(SMS_SATAddress+128);
	ld	hl, #0x7f80
	rst	#0x08
;./lib/./sprite.c:201: __endasm;
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
;./lib/./sprite.c:202: }
	ret
;./lib/entities.c:13: void draw_entidad(T_entidad *entidad, T_sprite *sprite){
;	---------------------------------
; Function draw_entidad
; ---------------------------------
_draw_entidad::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-29
	add	iy, sp
	ld	sp, iy
	ld	-4 (ix), l
	ld	-3 (ix), h
;./lib/entities.c:15: if (sprite->allInRAM == 1){
	ld	-6 (ix), e
	ld	-5 (ix), d
	ld	c, e
	ld	b, d
	ld	hl, #6
	add	hl, bc
	ld	c, (hl)
;./lib/entities.c:16: if (entidad->initSprite == 255) {
	ld	a, -4 (ix)
	add	a, #0x06
	ld	-14 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-13 (ix), a
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	ld	b, (hl)
;./lib/entities.c:17: int frame = sprite->tamano*entidad->frame + sprite->beginVRAM;
	ld	a, -4 (ix)
	add	a, #0x02
	ld	-12 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-11 (ix), a
;./lib/entities.c:18: for(j=0;j<sprite->alto;j++) {
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
;./lib/entities.c:28: entidad->len = (sprite->alto * sprite->ancho + entidad->initSprite)*2;
	ld	a, -4 (ix)
	add	a, #0x07
	ld	-29 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-28 (ix), a
;./lib/entities.c:16: if (entidad->initSprite == 255) {
	inc	b
	ld	a, #0x01
	jr	Z, 00253$
	xor	a, a
00253$:
	ld	-9 (ix), a
;./lib/entities.c:15: if (sprite->allInRAM == 1){
	dec	c
	jp	NZ,00120$
;./lib/entities.c:16: if (entidad->initSprite == 255) {
	ld	a, -14 (ix)
	ld	-27 (ix), a
	ld	a, -13 (ix)
	ld	-26 (ix), a
	ld	a, -9 (ix)
	or	a, a
	jp	Z, 00134$
;./lib/entities.c:17: int frame = sprite->tamano*entidad->frame + sprite->beginVRAM;
	ld	a, -6 (ix)
	ld	-14 (ix), a
	ld	a, -5 (ix)
	ld	-13 (ix), a
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	-10 (ix), a
	ld	l, -12 (ix)
	ld	h, -11 (ix)
	ld	a, (hl)
	ld	-9 (ix), a
	ld	a, -10 (ix)
	ld	-11 (ix), a
	ld	e, -9 (ix)
	ld	h, -11 (ix)
;	spillPairReg hl
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
	ld	-9 (ix), l
	ld	a, -6 (ix)
	ld	-11 (ix), a
	ld	a, -5 (ix)
	ld	-10 (ix), a
	ld	l, -11 (ix)
	ld	h, -10 (ix)
	ld	de, #0x0004
	add	hl, de
	ld	a, (hl)
	ld	-10 (ix), a
	add	a, -9 (ix)
	ld	-25 (ix), a
;./lib/entities.c:18: for(j=0;j<sprite->alto;j++) {
	ld	a, -8 (ix)
	ld	-24 (ix), a
	ld	a, -7 (ix)
	ld	-23 (ix), a
	ld	a, -2 (ix)
	ld	-22 (ix), a
	ld	a, -1 (ix)
	ld	-21 (ix), a
	ld	-2 (ix), #0x00
00126$:
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	a, (hl)
	ld	-1 (ix), a
	ld	a, -2 (ix)
	sub	a, -1 (ix)
	jp	NC, 00106$
;./lib/entities.c:19: unsigned char desplazado = (j<<2);
	ld	a, -2 (ix)
	ld	-1 (ix), a
	sla	-1 (ix)
	sla	-1 (ix)
;./lib/entities.c:20: unsigned char jCalculated = desplazado + frame, y = entidad->y+(desplazado<<2);
	ld	a, -1 (ix)
	ld	-7 (ix), a
	add	a, -25 (ix)
	ld	-1 (ix), a
	ld	-20 (ix), a
	ld	l, -24 (ix)
	ld	h, -23 (ix)
	ld	a, (hl)
	ld	-1 (ix), a
	sla	-7 (ix)
	sla	-7 (ix)
	ld	a, -1 (ix)
	add	a, -7 (ix)
	ld	-1 (ix), a
	ld	-19 (ix), a
;./lib/entities.c:21: for(i=0;i<sprite->ancho;i++) {
	ld	-1 (ix), #0x00
00123$:
	ld	l, -22 (ix)
	ld	h, -21 (ix)
	ld	a,-1 (ix)
	sub	a,(hl)
	jp	NC, 00127$
;./lib/entities.c:23: entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),y, jCalculated + (i<<1) );  
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	ld	-9 (ix), a
	ld	a, -1 (ix)
	ld	-8 (ix), a
	ld	-7 (ix), #0x00
	ld	a, -20 (ix)
	ld	-18 (ix), a
	ld	-17 (ix), #0x00
	ld	a, -19 (ix)
	ld	-16 (ix), a
	ld	-15 (ix), #0x00
	ld	a, -9 (ix)
	ld	-14 (ix), a
	ld	-13 (ix), #0x00
	ld	a, -8 (ix)
	ld	-12 (ix), a
	ld	a, -7 (ix)
	ld	-11 (ix), a
	ld	b, #0x03
00258$:
	sla	-12 (ix)
	rl	-11 (ix)
	djnz	00258$
	ld	a, -8 (ix)
	ld	-10 (ix), a
	ld	a, -7 (ix)
	ld	-9 (ix), a
	sla	-10 (ix)
	rl	-9 (ix)
	ld	a, -12 (ix)
	add	a, -14 (ix)
	ld	-8 (ix), a
	ld	a, -11 (ix)
	adc	a, -13 (ix)
	ld	-7 (ix), a
	ld	a, -18 (ix)
	add	a, -10 (ix)
	ld	-12 (ix), a
	ld	a, #0x00
	adc	a, -9 (ix)
	ld	-11 (ix), a
	ld	a, -8 (ix)
	ld	-10 (ix), a
	ld	-9 (ix), #0x00
	ld	a, -12 (ix)
	ld	-8 (ix), a
	ld	-7 (ix), #0x00
	ld	a, -10 (ix)
	ld	-9 (ix), a
	ld	-10 (ix), #0x00
	xor	a, a
	or	a, -8 (ix)
	ld	-12 (ix), a
	ld	a, -9 (ix)
	or	a, -7 (ix)
	ld	-11 (ix), a
;./lib/entities.c:22: if(i==0 && j==0)
	ld	a, -1 (ix)
	or	a, a
	jr	NZ, 00102$
	ld	a, -2 (ix)
	or	a, a
	jr	NZ, 00102$
;./lib/entities.c:23: entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),y, jCalculated + (i<<1) );  
	ld	e, -12 (ix)
	ld	d, -11 (ix)
	ld	l, -16 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_addSprite_f
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), a
	jr	00124$
00102$:
;./lib/entities.c:25: SMS_addSprite(entidad->x+(i<<3),y, jCalculated + (i<<1) );  
	ld	e, -12 (ix)
	ld	d, -11 (ix)
	ld	l, -16 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_addSprite_f
00124$:
;./lib/entities.c:21: for(i=0;i<sprite->ancho;i++) {
	inc	-1 (ix)
	jp	00123$
00127$:
;./lib/entities.c:18: for(j=0;j<sprite->alto;j++) {
	inc	-2 (ix)
	jp	00126$
00106$:
;./lib/entities.c:28: entidad->len = (sprite->alto * sprite->ancho + entidad->initSprite)*2;
	ld	l, -22 (ix)
	ld	h, -21 (ix)
	ld	a, (hl)
	ld	-2 (ix), a
	ld	e, a
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00260$:
	add	hl, hl
	jr	NC, 00261$
	add	hl, de
00261$:
	djnz	00260$
	ld	-1 (ix), l
	ld	l, -27 (ix)
	ld	h, -26 (ix)
	ld	a, (hl)
	ld	-2 (ix), a
	ld	a, -1 (ix)
	add	a, -2 (ix)
	ld	-1 (ix), a
	sla	-1 (ix)
	pop	hl
	push	hl
	ld	a, -1 (ix)
	ld	(hl), a
	jp	00134$
00120$:
;./lib/entities.c:33: if (entidad->initSprite == 255) {
	ld	a, -14 (ix)
	ld	-20 (ix), a
	ld	a, -13 (ix)
	ld	-19 (ix), a
	ld	a, -9 (ix)
	or	a, a
	jp	Z, 00134$
;./lib/entities.c:34: if (entidad->frame != sprite->frameInVRAM){
	ld	l, -12 (ix)
	ld	h, -11 (ix)
	ld	a, (hl)
	ld	-9 (ix), a
	ld	a, -6 (ix)
	add	a, #0x09
	ld	-11 (ix), a
	ld	a, -5 (ix)
	adc	a, #0x00
	ld	-10 (ix), a
	ld	l, -11 (ix)
	ld	h, -10 (ix)
	ld	a,-9 (ix)
	sub	a,(hl)
	jr	Z, 00151$
;./lib/entities.c:36: sprite->frameInVRAM = entidad->frame;
	ld	l, -11 (ix)
	ld	h, -10 (ix)
	ld	a, -9 (ix)
	ld	(hl), a
;./lib/entities.c:38: for(j=0;j<sprite->alto;j++) {
00151$:
	ld	a, -8 (ix)
	ld	-18 (ix), a
	ld	a, -7 (ix)
	ld	-17 (ix), a
	ld	a, -8 (ix)
	ld	-16 (ix), a
	ld	a, -7 (ix)
	ld	-15 (ix), a
	ld	a, -2 (ix)
	ld	-14 (ix), a
	ld	a, -1 (ix)
	ld	-13 (ix), a
	ld	-2 (ix), #0x00
00132$:
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	a, (hl)
	ld	-1 (ix), a
	ld	a, -2 (ix)
	sub	a, -1 (ix)
	jp	NC, 00116$
;./lib/entities.c:39: for(i=0;i<sprite->ancho;i++) {
	ld	-1 (ix), #0x00
00129$:
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	ld	a,-1 (ix)
	sub	a,(hl)
	jp	NC, 00133$
;./lib/entities.c:23: entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),y, jCalculated + (i<<1) );  
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
;./lib/entities.c:41: entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),entidad->y+(j<<4), (j<<2) + (i<<1) );  
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	e, -2 (ix)
	ld	d, #0x00
;./lib/entities.c:23: entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),y, jCalculated + (i<<1) );  
	ld	-12 (ix), a
	ld	-11 (ix), #0x00
;./lib/entities.c:41: entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),entidad->y+(j<<4), (j<<2) + (i<<1) );  
	ld	-10 (ix), c
	ld	-9 (ix), b
	ld	a, #0x03
00263$:
	sla	-10 (ix)
	rl	-9 (ix)
	dec	a
	jr	NZ, 00263$
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
	ld	-8 (ix), e
	ld	-7 (ix), d
	ld	a, -12 (ix)
	add	a, -10 (ix)
	ld	e, a
	ld	a, #0x00
	adc	a, -9 (ix)
	add	hl, bc
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	h,a
	or	a, l
	ld	-10 (ix), a
	ld	a, e
	or	a, h
	ld	-9 (ix), a
;./lib/entities.c:40: if(i==0 && j==0) {
	ld	a, -1 (ix)
	or	a, a
	jr	NZ, 00112$
	ld	a, -2 (ix)
	or	a, a
	jr	NZ, 00112$
;./lib/entities.c:41: entidad->initSprite = SMS_addSprite(entidad->x+(i<<3),entidad->y+(j<<4), (j<<2) + (i<<1) );  
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	ld	c, (hl)
	ld	b, #0x00
	ld	l, -8 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -7 (ix)
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	e, -10 (ix)
	ld	d, -9 (ix)
	call	_SMS_addSprite_f
	ld	l, -20 (ix)
	ld	h, -19 (ix)
	ld	(hl), a
	jr	00130$
00112$:
;./lib/entities.c:44: SMS_addSprite(entidad->x+(i<<3),entidad->y+(j<<4), (j<<2) + (i<<1) );
	ld	l, -18 (ix)
	ld	h, -17 (ix)
	ld	c, (hl)
	ld	b, #0x00
	ld	l, -8 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -7 (ix)
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	e, -10 (ix)
	ld	d, -9 (ix)
	call	_SMS_addSprite_f
00130$:
;./lib/entities.c:39: for(i=0;i<sprite->ancho;i++) {
	inc	-1 (ix)
	jp	00129$
00133$:
;./lib/entities.c:38: for(j=0;j<sprite->alto;j++) {
	inc	-2 (ix)
	jp	00132$
00116$:
;./lib/entities.c:48: entidad->len = sprite->alto * sprite->ancho + entidad->initSprite;
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	ld	a, (hl)
	ld	-2 (ix), a
	ld	e, a
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00265$:
	add	hl, hl
	jr	NC, 00266$
	add	hl, de
00266$:
	djnz	00265$
	ld	-1 (ix), l
	ld	l, -20 (ix)
	ld	h, -19 (ix)
	ld	a, (hl)
	ld	-2 (ix), a
	add	a, -1 (ix)
	ld	-1 (ix), a
	pop	hl
	push	hl
	ld	a, -1 (ix)
	ld	(hl), a
;./lib/entities.c:49: entidad->sprite = sprite;
	ld	a, -4 (ix)
	add	a, #0x0c
	ld	-2 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-1 (ix), a
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, -6 (ix)
	ld	(hl), a
	inc	hl
	ld	a, -5 (ix)
	ld	(hl), a
00134$:
;./lib/entities.c:52: }
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
;./alex.c:27: if (alex.y > 153)
	ld	hl, #_alex+1
	ld	c, (hl)
	ld	a, #0x99
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
	ld	e, (hl)
;./alex.c:77: alex.oriented = 1;
;./alex.c:78: alex.lastChangeFrame++;
	ld	bc, #_alex + 3
;./alex.c:81: alex.frame++;
;./alex.c:72: if(alex.state != PUÑETAZO_SUELO) {
	ld	a, e
	sub	a, #0x20
	jp	Z,00144$
;./alex.c:73: SpriteTableY2[4] = 234;
	ld	hl, (_SpriteTableY2)
	ld	de, #0x0004
	add	hl, de
	ld	(hl), #0xea
;./alex.c:74: if ((keys & PORT_A_KEY_LEFT) && alex.x > 8 )
	xor	a, a
	or	a, -6 (ix)
	jr	Z, 00135$
	ld	hl, #_alex
	ld	e, (hl)
	ld	a, #0x08
	sub	a, e
	jr	NC, 00135$
;./alex.c:76: alex.x -= 1;
	dec	e
	ld	hl, #_alex
	ld	(hl), e
;./alex.c:77: alex.oriented = 1;
	ld	hl, #(_alex + 4)
	ld	(hl), #0x01
;./alex.c:78: alex.lastChangeFrame++;
	ld	a, (bc)
	inc	a
	ld	(bc), a
;./alex.c:79: if (alex.lastChangeFrame == 11) {
	sub	a, #0x0b
	jr	NZ, 00119$
;./alex.c:80: alex.lastChangeFrame = 0;
	xor	a, a
	ld	(bc), a
;./alex.c:81: alex.frame++;
	ld	a, (#(_alex + 2) + 0)
	inc	a
	ld	(#(_alex + 2)),a
00119$:
;./alex.c:83: if (alex.frame > 11 || alex.frame < 8)
	ld	hl, #(_alex + 2)
	ld	c, (hl)
	ld	a, #0x0b
	sub	a, c
	jr	C, 00120$
	ld	a, c
	sub	a, #0x08
	jp	NC, 00146$
00120$:
;./alex.c:84: alex.frame = 8;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x08
	jp	00146$
00135$:
;./alex.c:86: else if ((keys & PORT_A_KEY_RIGHT) && alex.x <240)
	xor	a, a
	or	a, -4 (ix)
	jr	Z, 00131$
	ld	a, (#_alex + 0)
	cp	a, #0xf0
	jr	NC, 00131$
;./alex.c:88: alex.x += 1;
	inc	a
	ld	(#_alex),a
;./alex.c:89: alex.oriented = 0;
	ld	hl, #(_alex + 4)
	ld	(hl), #0x00
;./alex.c:90: alex.lastChangeFrame++;
	ld	a, (bc)
	inc	a
	ld	(bc), a
;./alex.c:91: if (alex.lastChangeFrame == 11) {
	sub	a, #0x0b
	jr	NZ, 00124$
;./alex.c:92: alex.lastChangeFrame = 0;
	xor	a, a
	ld	(bc), a
;./alex.c:93: alex.frame++;
	ld	a, (#(_alex + 2) + 0)
	inc	a
	ld	(#(_alex + 2)),a
00124$:
;./alex.c:95: if (alex.frame > 3 || alex.frame < 0)
	ld	hl, #(_alex + 2)
	ld	c, (hl)
	ld	a, #0x03
	sub	a, c
	jp	NC, 00146$
;./alex.c:96: alex.frame = 0;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x00
	jp	00146$
00131$:
;./alex.c:100: alex.frame = 4;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x04
;./alex.c:101: if (alex.oriented)
	ld	a, (#(_alex + 4) + 0)
	or	a, a
	jr	Z, 00129$
;./alex.c:102: alex.frame = 12;
	ld	(hl), #0x0c
00129$:
;./alex.c:103: alex.lastChangeFrame = 10;
	ld	a, #0x0a
	ld	(bc), a
	jp	00146$
00144$:
;./alex.c:107: if (!alex.oriented) {
;./alex.c:112: SpriteTableY2[4] = alex.y + 9;
;./alex.c:107: if (!alex.oriented) {
	ld	a, (#(_alex + 4) + 0)
	or	a, a
	jr	NZ, 00139$
;./alex.c:108: alex.frame = 5;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x05
;./alex.c:110: SpriteTableXN2[8] = alex.x + 16;
	ld	a, (_SpriteTableXN2+0)
	add	a, #0x08
	ld	e, a
	ld	a, (_SpriteTableXN2+1)
	adc	a, #0x00
	ld	d, a
	ld	a, (#_alex + 0)
	add	a, #0x10
	ld	(de), a
;./alex.c:111: SpriteTableXN2[9] = 9;
	ld	hl, (_SpriteTableXN2)
	ld	de, #0x0009
	add	hl, de
	ld	(hl), #0x09
;./alex.c:112: SpriteTableY2[4] = alex.y + 9;
	ld	a, (_SpriteTableY2+0)
	add	a, #0x04
	ld	e, a
	ld	a, (_SpriteTableY2+1)
	adc	a, #0x00
	ld	d, a
	ld	a, (#(_alex + 1) + 0)
	add	a, #0x09
	ld	(de), a
	jr	00140$
00139$:
;./alex.c:115: alex.frame = 13;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x0d
;./alex.c:117: SpriteTableXN2[8] = alex.x - 8;
	ld	a, (_SpriteTableXN2+0)
	add	a, #0x08
	ld	e, a
	ld	a, (_SpriteTableXN2+1)
	adc	a, #0x00
	ld	d, a
	ld	a, (#_alex + 0)
	add	a, #0xf8
	ld	(de), a
;./alex.c:118: SpriteTableXN2[9] = 11;
	ld	hl, (_SpriteTableXN2)
	ld	de, #0x0009
	add	hl, de
	ld	(hl), #0x0b
;./alex.c:119: SpriteTableY2[4] = alex.y + 9;
	ld	a, (_SpriteTableY2+0)
	add	a, #0x04
	ld	e, a
	ld	a, (_SpriteTableY2+1)
	adc	a, #0x00
	ld	d, a
	ld	a, (#(_alex + 1) + 0)
	add	a, #0x09
	ld	(de), a
00140$:
;./alex.c:121: alex.lastChangeFrame--;
	ld	a, (bc)
	dec	a
	ld	(bc), a
;./alex.c:122: if(!alex.lastChangeFrame) {
	or	a, a
	jr	NZ, 00146$
;./alex.c:123: alex.state = 0;
	ld	hl, #(_alex + 5)
	ld	(hl), #0x00
;./alex.c:124: SpriteTableY2[4] = 234;
	ld	hl, (_SpriteTableY2)
	ld	de, #0x0004
	add	hl, de
	ld	(hl), #0xea
00146$:
;./alex.c:127: }
	ld	sp, ix
	pop	ix
	ret
;./alex.c:129: void moveAlexAire(int keys, unsigned char puedeSubir, unsigned char puedeDerecha, unsigned char puedeIzquieda) {
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
;./alex.c:130: if (alex.y > maxSalto) {
	ld	hl, #(_alex + 1)
	ld	b, (hl)
;./alex.c:131: alex.y -= 2;
	ld	c, b
;./alex.c:130: if (alex.y > maxSalto) {
	ld	a, (_maxSalto+0)
	sub	a, b
	jr	NC, 00102$
;./alex.c:131: alex.y -= 2;
	dec	c
	dec	c
	ld	hl, #(_alex + 1)
	ld	(hl), c
	jr	00103$
00102$:
;./alex.c:134: alex.y += 2; // bajando
	inc	c
	inc	c
	ld	hl, #(_alex + 1)
	ld	(hl), c
;./alex.c:135: maxSalto = 255;
	ld	iy, #_maxSalto
	ld	0 (iy), #0xff
00103$:
;./alex.c:138: if (alex.state != PUÑETAZO_SALTANDO)
;./alex.c:139: alex.oriented = 1;
;./alex.c:137: if (keys & PORT_A_KEY_LEFT) {
	bit	2, -2 (ix)
	jr	Z, 00109$
;./alex.c:138: if (alex.state != PUÑETAZO_SALTANDO)
	ld	a, (#(_alex + 5) + 0)
	sub	a, #0x10
	jr	Z, 00105$
;./alex.c:139: alex.oriented = 1;
	ld	hl, #(_alex + 4)
	ld	(hl), #0x01
00105$:
;./alex.c:140: if (puedeIzquieda)
	ld	a, 6 (ix)
	or	a, a
	jr	Z, 00109$
;./alex.c:141: alex.x -= 2;
	ld	a, (#_alex + 0)
	dec	a
	dec	a
	ld	(#_alex),a
00109$:
;./alex.c:143: if (keys & PORT_A_KEY_RIGHT) {
	bit	3, -2 (ix)
	jr	Z, 00115$
;./alex.c:144: if (alex.state != PUÑETAZO_SALTANDO)
	ld	a, (#(_alex + 5) + 0)
	sub	a, #0x10
	jr	Z, 00111$
;./alex.c:145: alex.oriented = 0;
	ld	hl, #(_alex + 4)
	ld	(hl), #0x00
00111$:
;./alex.c:146: if (puedeDerecha)
	ld	a, 5 (ix)
	or	a, a
	jr	Z, 00115$
;./alex.c:147: alex.x += 2;
	ld	a, (#_alex + 0)
	add	a, #0x02
	ld	(#_alex),a
00115$:
;./alex.c:149: if (alex.state == PUÑETAZO_SALTANDO) {
	ld	hl, #(_alex + 5)
	ld	c, (hl)
;./alex.c:150: alex.lastChangeFrame--;
;./alex.c:156: alex.frame = 5;
;./alex.c:149: if (alex.state == PUÑETAZO_SALTANDO) {
	ld	a, c
	sub	a, #0x10
	jp	NZ,00127$
;./alex.c:150: alex.lastChangeFrame--;
	ld	hl, #(_alex + 3)
	ld	c, (hl)
	dec	c
	ld	hl, #(_alex + 3)
;./alex.c:151: if  (!alex.lastChangeFrame) {
	ld	a,c
	ld	(hl),a
	or	a, a
	jr	NZ, 00117$
;./alex.c:152: alex.state = 0;
	ld	hl, #(_alex + 5)
	ld	(hl), #0x00
;./alex.c:153: SpriteTableY2[4] = 234;
	ld	hl, (_SpriteTableY2)
	ld	de, #0x0004
	add	hl, de
	ld	(hl), #0xea
00117$:
;./alex.c:155: if (!alex.oriented) {
	ld	a, (#(_alex + 4) + 0)
	or	a, a
	jr	NZ, 00119$
;./alex.c:156: alex.frame = 5;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x05
;./alex.c:158: SpriteTableXN2[8] = alex.x + 16;
	ld	a, (_SpriteTableXN2+0)
	add	a, #0x08
	ld	c, a
	ld	a, (_SpriteTableXN2+1)
	adc	a, #0x00
	ld	b, a
	ld	a, (#_alex + 0)
	add	a, #0x10
	ld	(bc), a
;./alex.c:159: SpriteTableXN2[9] = 9;
	ld	hl, (_SpriteTableXN2)
	ld	de, #0x0009
	add	hl, de
	ld	(hl), #0x09
;./alex.c:160: SpriteTableY2[4] = alex.y + 9;
	ld	a, (_SpriteTableY2+0)
	add	a, #0x04
	ld	c, a
	ld	a, (_SpriteTableY2+1)
	adc	a, #0x00
	ld	b, a
	ld	a, (#(_alex + 1) + 0)
	add	a, #0x09
	ld	(bc), a
	jr	00129$
00119$:
;./alex.c:163: alex.frame = 13;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x0d
;./alex.c:165: SpriteTableXN2[8] = alex.x - 8;
	ld	a, (_SpriteTableXN2+0)
	add	a, #0x08
	ld	c, a
	ld	a, (_SpriteTableXN2+1)
	adc	a, #0x00
	ld	b, a
	ld	a, (#_alex + 0)
	add	a, #0xf8
	ld	(bc), a
;./alex.c:166: SpriteTableXN2[9] = 11;
	ld	hl, (_SpriteTableXN2)
	ld	de, #0x0009
	add	hl, de
	ld	(hl), #0x0b
;./alex.c:167: SpriteTableY2[4] = alex.y + 9;
	ld	a, (_SpriteTableY2+0)
	add	a, #0x04
	ld	c, a
	ld	a, (_SpriteTableY2+1)
	adc	a, #0x00
	ld	b, a
	ld	a, (#(_alex + 1) + 0)
	add	a, #0x09
	ld	(bc), a
	jr	00129$
00127$:
;./alex.c:171: SpriteTableY2[4] = 234;
	ld	hl, (_SpriteTableY2)
	ld	de, #0x0004
	add	hl, de
	ld	(hl), #0xea
;./alex.c:172: if (!alex.oriented)
	ld	a, (#(_alex + 4) + 0)
	ld	-3 (ix), a
	or	a, a
	jr	NZ, 00122$
;./alex.c:173: alex.frame = 6;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x06
	jr	00123$
00122$:
;./alex.c:175: alex.frame = 14;
	ld	hl, #(_alex + 2)
	ld	(hl), #0x0e
00123$:
;./alex.c:176: if (keys & PORT_A_KEY_1) {
	bit	4, -2 (ix)
	jr	Z, 00129$
;./alex.c:177: alex.state = PUÑETAZO_SALTANDO;
	ld	hl, #(_alex + 5)
	ld	(hl), #0x10
;./alex.c:178: alex.lastChangeFrame = 20;
	ld	hl, #(_alex + 3)
	ld	(hl), #0x14
00129$:
;./alex.c:182: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	inc	sp
	jp	(hl)
;./alex.c:186: void drawAlex() {
;	---------------------------------
; Function drawAlex
; ---------------------------------
_drawAlex::
;./alex.c:187: SpriteTableXN2[0] = alex.x;
	ld	de, (_SpriteTableXN2)
	ld	bc, #_alex+0
	ld	a, (bc)
	ld	(de), a
;./alex.c:188: SpriteTableXN2[2] = alex.x + 8;
	ld	hl, (_SpriteTableXN2)
	inc	hl
	inc	hl
	ld	a, (bc)
	add	a, #0x08
	ld	(hl), a
;./alex.c:189: SpriteTableXN2[4] = alex.x;
	ld	hl, (_SpriteTableXN2)
	ld	de, #0x0004
	add	hl, de
	ld	a, (bc)
	ld	(hl), a
;./alex.c:190: SpriteTableXN2[6] = alex.x + 8;
	ld	hl, (_SpriteTableXN2)
	ld	de, #0x0006
	add	hl, de
	ld	a, (bc)
	add	a, #0x08
	ld	(hl), a
;./alex.c:191: SpriteTableY2[0] = alex.y;
	ld	de, (_SpriteTableY2)
	ld	bc, #_alex + 1
	ld	a, (bc)
	ld	(de), a
;./alex.c:192: SpriteTableY2[1] = alex.y;
	ld	hl, (_SpriteTableY2)
	inc	hl
	ld	a, (bc)
	ld	(hl), a
;./alex.c:193: SpriteTableY2[2] = alex.y + 16;
	ld	hl, (_SpriteTableY2)
	inc	hl
	inc	hl
	ld	a, (bc)
	add	a, #0x10
	ld	(hl), a
;./alex.c:194: SpriteTableY2[3] = alex.y + 16;
	ld	hl, (_SpriteTableY2)
	inc	hl
	inc	hl
	inc	hl
	ld	a, (bc)
	add	a, #0x10
	ld	(hl), a
;./alex.c:195: if (alex.frame != lastFrame) {
	ld	hl, #(_alex + 2)
	ld	e, (hl)
	ld	a, (_lastFrame+0)
	sub	a, e
	ret	Z
;./alex.c:196: SMS_loadTiles(alex.sprite->data + alex.frame *256, alex.sprite->beginVRAM, 255);
	ld	bc, (#_alex + 12)
	push	bc
	pop	iy
	ld	l, 7 (iy)
;	spillPairReg hl
	ld	h, 8 (iy)
;	spillPairReg hl
	ld	d, e
	ld	e, #0x00
	add	hl, de
	ex	de, hl
	ld	hl, #4
	add	hl, bc
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
	ld	bc, #0x00ff
	push	bc
	call	_SMS_VRAMmemcpy
;./alex.c:197: lastFrame = alex.frame;
	ld	hl, #(_alex + 2)
	ld	a, (hl)
	ld	(_lastFrame+0), a
;./alex.c:199: }
	ret
;./alex.c:202: void moveAlex(int keys) {
;	---------------------------------
; Function moveAlex
; ---------------------------------
_moveAlex::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;./alex.c:203: unsigned char puedeBajar = canDown();
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
;./alex.c:207: if (puedeBajar)
	inc	c
	dec	c
	jr	Z, 00102$
;./alex.c:208: moveAlexAire(keys, puedeSubir, puedeDerecha, puedeIzquierda);
	ld	d,a
	push	de
	ld	a, -1 (ix)
	push	af
	inc	sp
	call	_moveAlexAire
	jr	00103$
00102$:
;./alex.c:210: moveAlexSuelo(keys);
	call	_moveAlexSuelo
00103$:
;./alex.c:211: drawAlex();
	call	_drawAlex
;./alex.c:212: }
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
;main.c:25: pajaros[i].x = 15 + (32 * i) % 200;
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	de, #_pajaros
	add	hl, de
	ex	(sp), hl
	ld	a, -1 (ix)
	ld	-7 (ix), a
	ld	-6 (ix), #0x00
	pop	bc
	pop	hl
	push	hl
	push	bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #0x00c8
	call	__modsint
	ld	a, e
	add	a, #0x0f
	pop	hl
	push	hl
	ld	(hl), a
;main.c:26: pajaros[i].y = 16 * (i / 2);
	ld	a, -9 (ix)
	add	a, #0x01
	ld	-5 (ix), a
	ld	a, -8 (ix)
	adc	a, #0x00
	ld	-4 (ix), a
	ld	a, -7 (ix)
	ld	-3 (ix), a
	ld	a, -6 (ix)
	ld	-2 (ix), a
	bit	7, -6 (ix)
	jr	Z, 00112$
	ld	a, -7 (ix)
	add	a, #0x01
	ld	-3 (ix), a
	ld	a, -6 (ix)
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
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	ld	(hl), a
;main.c:27: pajaros[i].lastChangeFrame = i * 3;
	pop	bc
	push	bc
	inc	bc
	inc	bc
	inc	bc
	ld	a, -1 (ix)
	ld	e, a
	add	a, a
	add	a, e
	ld	(bc), a
;main.c:28: pajaros[i].initSprite = 255;
	ld	a, -9 (ix)
	add	a, #0x06
	ld	e, a
	ld	a, -8 (ix)
	adc	a, #0x00
	ld	d, a
	ld	a, #0xff
	ld	(de), a
;main.c:30: pajaros[i].x++;
	pop	hl
	push	hl
	ld	a, (hl)
	inc	a
	pop	hl
	push	hl
	ld	(hl), a
;main.c:31: pajaros[i].lastChangeFrame++;
	ld	a, (bc)
	inc	a
	ld	(bc), a
;main.c:32: pajaros[i].vx = 1;
	ld	a, -9 (ix)
	add	a, #0x08
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -8 (ix)
	adc	a, #0x00
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	(hl), #0x01
	inc	hl
	ld	(hl), #0x00
;main.c:33: pajaros[i].vy = 0;
	ld	a, -9 (ix)
	add	a, #0x0a
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -8 (ix)
	adc	a, #0x00
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;main.c:34: if (pajaros[i].lastChangeFrame == 20)
	ld	a, (bc)
	sub	a, #0x14
	jr	NZ, 00104$
;main.c:36: pajaros[i].frame++;
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	inc	a
	ld	-2 (ix), a
	ld	(hl), a
;main.c:37: if (pajaros[i].frame > 1)
	ld	a, #0x01
	sub	a, -2 (ix)
	jr	NC, 00102$
;main.c:38: pajaros[i].frame = 0;
	ld	(hl), #0x00
00102$:
;main.c:39: pajaros[i].lastChangeFrame = 0;
	xor	a, a
	ld	(bc), a
00104$:
;main.c:41: if(pajaros[i].initSprite == 255) {
	ld	a, (de)
	inc	a
	jr	NZ, 00109$
;main.c:42: draw_entidad(&(pajaros[i]), &spritePajaro);
	ld	de, #_spritePajaro
	pop	hl
	push	hl
	call	_draw_entidad
00109$:
;main.c:23: for (i = 0; i < NUM_PAJAROS; i++)
	inc	-1 (ix)
	ld	a, -1 (ix)
	sub	a, #0x13
	jp	C, 00108$
;main.c:45: }
	ld	sp, ix
	pop	ix
	ret
;main.c:47: void loadGrapVRAM()
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
;main.c:49: SMS_init();
	call	_SMS_init
;main.c:52: SMS_setSpriteMode(SPRITEMODE_TALL);
	ld	l, #0x01
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setSpriteMode
;main.c:53: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:54: SMS_loadBGPalette(sonicpalette_inc);
	ld	hl, #_sonicpalette_inc
	call	_SMS_loadBGPalette
;main.c:55: SMS_loadSpritePalette(palleteAlex_inc);
	ld	hl, #_palleteAlex_inc
	call	_SMS_loadSpritePalette
;main.c:57: spriteAlex = generateSpriteNoRAM(2, 2, spriteAlex_inc_size, spriteAlex_inc);
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
;main.c:58: spritePuno = generateSprite(1, 2, puno_inc_size, puno_inc);
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
;main.c:59: spritePajaro = generateSpriteFlip(3, 1, spritePajaro_inc_size, spritePajaro_inc);
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
	call	_generateSpriteFlip
	pop	af
	pop	af
	pop	af
	ld	de, #_spritePajaro
	ld	hl, #20
	add	hl, sp
	ld	bc, #0x000a
	ldir
;main.c:60: SMS_initSprites();
	call	_SMS_initSprites
;main.c:61: alex.initSprite = 255;
	ld	hl, #_alex + 6
	ld	(hl), #0xff
;main.c:62: draw_entidad(&alex, &spriteAlex);
	ld	de, #_spriteAlex
	ld	hl, #_alex
	call	_draw_entidad
;main.c:63: SMS_addSprite (0, 0, 9); // puno
	ld	de, #0x0009
	ld	hl, #0x0000
	call	_SMS_addSprite_f
;main.c:64: inicializaPajaros();
	call	_inicializaPajaros
;main.c:69: SMS_loadTiles(tiles_de_prueba2_inc, 0, tiles_de_prueba2_inc_size);
	ld	hl, #0x00a0
	push	hl
	ld	de, #_tiles_de_prueba2_inc
	ld	hl, #0x4000
	call	_SMS_VRAMmemcpy
;main.c:70: SMS_loadTileMap(0, 0, tilemap_de_prueba2_inc, tilemap_de_prueba2_inc_size);
	ld	hl, #0x0780
	push	hl
	ld	de, #_tilemap_de_prueba2_inc
	ld	hl, #0x7800
	call	_SMS_VRAMmemcpy
;main.c:71: SMS_loadBGPalette(paleta_de_prueba2_inc);
	ld	hl, #_paleta_de_prueba2_inc
	call	_SMS_loadBGPalette
;main.c:72: SMS_setSpritePaletteColor(0,0);
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	l, a
	call	_SMS_setSpritePaletteColor
;main.c:73: }
	ld	sp, ix
	pop	ix
	ret
;main.c:75: void dibujaPajaros()
;	---------------------------------
; Function dibujaPajaros
; ---------------------------------
_dibujaPajaros::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-15
	add	hl, sp
	ld	sp, hl
;main.c:80: unsigned char initPajaros = pajaros[0].initSprite;
	ld	a,(#_pajaros + 6)
	ld	-15 (ix), a
;main.c:81: for (i = 0; i < NUM_PAJAROS; i++)
	ld	-2 (ix), #0x00
00126$:
;main.c:83: T_entidad *p = &pajaros[i];
	ld	c, -2 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	de, #_pajaros
	add	hl, de
	ld	c, l
	ld	b, h
;main.c:84: p->x++;
	ld	a, (bc)
	inc	a
	ld	(bc), a
;main.c:85: p->lastChangeFrame++;
	ld	hl, #0x0003
	add	hl, bc
	ld	-14 (ix), l
	ld	-13 (ix), h
	ld	e, (hl)
	inc	e
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	ld	(hl), e
;main.c:94: for(j=0;j<spritePajaro.alto;j++) {
	ld	hl, #0x0008
	add	hl, bc
	ld	-12 (ix), l
	ld	-11 (ix), h
;main.c:87: if (p->lastChangeFrame == 20)
	ld	a, e
	sub	a, #0x14
	jp	NZ,00110$
;main.c:89: p->frame++;
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (de)
	inc	a
	ld	-1 (ix), a
	ld	(de), a
;main.c:90: if (p->frame > 1)
	ld	a, #0x01
	sub	a, -1 (ix)
	jr	NC, 00104$
;main.c:91: p->frame = 0;
	xor	a, a
	ld	(de), a
00104$:
;main.c:92: p->lastChangeFrame = 0;
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	ld	(hl), #0x00
;main.c:93: int frame = spritePajaro.tamano*p->frame + spritePajaro.beginVRAM;
	ld	hl, #_spritePajaro + 2
	ld	h, (hl)
;	spillPairReg hl
	ld	a, (de)
	push	bc
	ld	e, a
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00219$:
	add	hl, hl
	jr	NC, 00220$
	add	hl, de
00220$:
	djnz	00219$
	pop	bc
	ld	e, l
	ld	a, (#_spritePajaro + 4)
	add	a, e
	ld	-10 (ix), a
;main.c:94: for(j=0;j<spritePajaro.alto;j++) {
	ld	a, -12 (ix)
	ld	-9 (ix), a
	ld	a, -11 (ix)
	ld	-8 (ix), a
	ld	d, #0x00
00124$:
	ld	hl, #_spritePajaro
	ld	e, (hl)
;main.c:95: unsigned char desplazado = (j<<2);
	ld	a,d
	cp	a,e
	jp	NC,00110$
	add	a, a
	add	a, a
;main.c:96: unsigned char jCalculated = desplazado + frame, y = p->y+(desplazado<<2);
	add	a, -10 (ix)
	ld	-7 (ix), a
;main.c:97: for(i2=0;i2<spritePajaro.ancho;i2++) {
	ld	-1 (ix), #0x00
00121$:
	ld	hl, #_spritePajaro + 1
	ld	a,-1 (ix)
	sub	a,(hl)
	jr	NC, 00125$
;main.c:98: SpriteTableXN2[(i2+initPajaros)*2+1] = jCalculated + (i2<<1) /*+ 12*/;
	ld	a, -1 (ix)
	ld	e, #0x00
	ld	l, -15 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	a, l
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, e
	adc	a, h
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	inc	hl
	ld	-6 (ix), l
	ld	-5 (ix), h
	ld	a, (_SpriteTableXN2+0)
	add	a, -6 (ix)
	ld	-4 (ix), a
	ld	a, (_SpriteTableXN2+1)
	adc	a, -5 (ix)
	ld	-3 (ix), a
	ld	a, -1 (ix)
	add	a, a
	ld	e, -7 (ix)
	add	a, e
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	(hl), a
;main.c:99: if(p->vx < 0)
	ld	l, -9 (ix)
	ld	h, -8 (ix)
	inc	hl
;	spillPairReg hl
	bit	7, (hl)
	jr	Z, 00122$
;main.c:100: SpriteTableXN2[(i2+initPajaros)*2+1] += 12;
	ld	a, -6 (ix)
	ld	hl, #_SpriteTableXN2
	add	a, (hl)
	ld	-4 (ix), a
	ld	a, -5 (ix)
	inc	hl
	adc	a, (hl)
	ld	-3 (ix), a
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	add	a, #0x0c
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	(hl), a
00122$:
;main.c:97: for(i2=0;i2<spritePajaro.ancho;i2++) {
	inc	-1 (ix)
	jr	00121$
00125$:
;main.c:94: for(j=0;j<spritePajaro.alto;j++) {
	inc	d
	jp	00124$
00110$:
;main.c:104: initPajaros +=3;
	ld	a, -15 (ix)
	add	a, #0x03
	ld	-15 (ix), a
;main.c:105: end = p->len;
	ld	e, c
	ld	d, b
	ld	hl, #7
	add	hl, de
	ld	a, (hl)
	ld	-5 (ix), a
;main.c:106: i2 = p->initSprite << 1;
	ld	e, c
	ld	d, b
	ld	hl, #6
	add	hl, de
	ld	a, (hl)
	add	a, a
	ld	-1 (ix), a
;main.c:107: p->x = (int)p->x + p->vx;
	ld	a, (bc)
	ld	e, a
	ld	a, -12 (ix)
	ld	-4 (ix), a
	ld	a, -11 (ix)
	ld	-3 (ix), a
	ld	l, -12 (ix)
	ld	h, -11 (ix)
	ld	a, (hl)
	add	a, e
	ld	(bc), a
;main.c:108: if (SpriteTableXN2[i2] >= 230) {
	ld	a, (_SpriteTableXN2+0)
	add	a, -1 (ix)
	ld	c, a
	ld	a, (_SpriteTableXN2+1)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	cp	a, #0xe6
	jr	C, 00114$
;main.c:109: p->vx = -1;
	ld	l, -12 (ix)
	ld	h, -11 (ix)
	ld	(hl), #0xff
	inc	hl
	ld	(hl), #0xff
;main.c:110: p->lastChangeFrame = 19;
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	ld	(hl), #0x13
	jr	00116$
00114$:
;main.c:112: else if(SpriteTableXN2[i2] < 10) {
	sub	a, #0x0a
	jr	NC, 00116$
;main.c:113: p->vx = 1;
	ld	l, -12 (ix)
	ld	h, -11 (ix)
	ld	(hl), #0x01
	inc	hl
	ld	(hl), #0x00
;main.c:114: p->lastChangeFrame = 19;
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	ld	(hl), #0x13
;main.c:116: while(i2<end) {
00116$:
	ld	a, -1 (ix)
	sub	a, -5 (ix)
	jr	NC, 00127$
;main.c:117: SpriteTableXN2[i2] = /*(int)*/SpriteTableXN2[i2] + p->vx;
	ld	a, (_SpriteTableXN2+0)
	add	a, -1 (ix)
	ld	c, a
	ld	a, (_SpriteTableXN2+1)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	e, (hl)
	add	a, e
	ld	(bc), a
;main.c:118: i2 +=2;
	ld	a, -1 (ix)
	add	a, #0x02
	ld	-1 (ix), a
	jr	00116$
00127$:
;main.c:81: for (i = 0; i < NUM_PAJAROS; i++)
	inc	-2 (ix)
	ld	a, -2 (ix)
	sub	a, #0x13
	jp	C, 00126$
;main.c:123: }
	ld	sp, ix
	pop	ix
	ret
;main.c:125: void playMusic() {
;	---------------------------------
; Function playMusic
; ---------------------------------
_playMusic::
;main.c:126: PSGFrame();
	call	_PSGFrame
;main.c:127: PSGSFXFrame();
;main.c:128: }
	jp	_PSGSFXFrame
;main.c:130: void disableSprites() {
;	---------------------------------
; Function disableSprites
; ---------------------------------
_disableSprites::
;main.c:133: while (i < 64) {
	ld	c, #0x00
00101$:
	ld	a, c
	sub	a, #0x40
	jr	NC, 00103$
;main.c:134: SMS_updateSpritePosition(i,10,240); 
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
;main.c:135: i++;
	inc	c
	jr	00101$
00103$:
;main.c:137: numSprites = 0;
	ld	hl, #0x0000
	ld	(_numSprites), hl
;main.c:138: }
	ret
;main.c:140: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;main.c:145: SMS_VRAMmemsetW(0, 0x0000, 16384);
	ld	hl, #0x4000
	push	hl
	ld	de, #0x0000
	ld	h, l
	call	_SMS_VRAMmemsetW
;main.c:155: printf("Hello, World! [1/3]");
	ld	hl, #___str_0
	push	hl
	call	_printf
	pop	af
;main.c:160: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:161: SMS_setBGScrollX(scroll_x);
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollX
;main.c:162: SMS_setBGScrollY(scroll_y);
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollY
;main.c:163: SMS_init();
	call	_SMS_init
;main.c:164: initSpritesVariables();
	call	_initSpritesVariables
;main.c:165: loadGrapVRAM();
	call	_loadGrapVRAM
;main.c:171: PSGPlay(special_psg);
	ld	hl, #_special_psg
	call	_PSGPlay
;main.c:172: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl, #0x0020
	call	_SMS_VDPturnOnFeature
;main.c:173: SMS_VDPturnOnFeature(VDPFEATURE_EXTRAHEIGHT);
	ld	hl, #0x0002
	call	_SMS_VDPturnOnFeature
;main.c:175: SMS_VDPturnOnFeature(VDPFEATURE_240LINES);
	ld	hl, #0x0108
	call	_SMS_VDPturnOnFeature
;main.c:176: SMS_setFrameInterruptHandler(playMusic);
	ld	hl, #_playMusic
	call	_SMS_setFrameInterruptHandler
00111$:
;main.c:181: if (SMS_queryPauseRequested())
	call	_SMS_queryPauseRequested
	bit	0,a
	jr	Z, 00105$
;main.c:183: PSGPlay(emeraldhill_psg);
	ld	hl, #_emeraldhill_psg
	call	_PSGPlay
;main.c:184: SMS_resetPauseRequest();
	call	_SMS_resetPauseRequest
;main.c:185: while (!SMS_queryPauseRequested())
00101$:
	call	_SMS_queryPauseRequested
	bit	0,a
	jr	NZ, 00103$
;main.c:187: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
	jr	00101$
00103$:
;main.c:191: SMS_resetPauseRequest();
	call	_SMS_resetPauseRequest
;main.c:192: PSGPlay(titulo_psg);
	ld	hl, #_titulo_psg
	call	_PSGPlay
00105$:
;main.c:196: int keys = SMS_getKeysHeld();
	call	_SMS_getKeysHeld
	ld	c, e
	ld	b, d
;main.c:197: if(keys & PORT_A_KEY_2)
	bit	5, c
	jr	Z, 00107$
;main.c:198: keys = keys  ^ PORT_A_KEY_2;
	ld	a, c
	xor	a, #0x20
	ld	c, a
00107$:
;main.c:199: if(keys & PORT_A_KEY_1)
	bit	4, c
	jr	Z, 00109$
;main.c:200: keys = keys  ^ PORT_A_KEY_1;
	ld	a, c
	xor	a, #0x10
	ld	c, a
00109$:
;main.c:202: keys = keys | (SMS_getKeysPressed() & (PORT_A_KEY_2 | PORT_A_KEY_1));
	push	bc
	call	_SMS_getKeysPressed
	pop	bc
	ld	a, e
	and	a, #0x30
	or	a, c
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
;main.c:205: moveAlex(keys);
	call	_moveAlex
;main.c:207: dibujaPajaros();
	call	_dibujaPajaros
;main.c:212: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:218: copySpritestoSAT();
	call	_copySpritestoSAT
;main.c:224: SMS_setBGScrollX(scroll_x);
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollX
;main.c:226: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:228: }
	jr	00111$
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
__xinit__flipArray:
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0xa0	; 160
	.db #0x60	; 96
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x90	; 144
	.db #0x50	; 80	'P'
	.db #0xd0	; 208
	.db #0x30	; 48	'0'
	.db #0xb0	; 176
	.db #0x70	; 112	'p'
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0x88	; 136
	.db #0x48	; 72	'H'
	.db #0xc8	; 200
	.db #0x28	; 40
	.db #0xa8	; 168
	.db #0x68	; 104	'h'
	.db #0xe8	; 232
	.db #0x18	; 24
	.db #0x98	; 152
	.db #0x58	; 88	'X'
	.db #0xd8	; 216
	.db #0x38	; 56	'8'
	.db #0xb8	; 184
	.db #0x78	; 120	'x'
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0x84	; 132
	.db #0x44	; 68	'D'
	.db #0xc4	; 196
	.db #0x24	; 36
	.db #0xa4	; 164
	.db #0x64	; 100	'd'
	.db #0xe4	; 228
	.db #0x14	; 20
	.db #0x94	; 148
	.db #0x54	; 84	'T'
	.db #0xd4	; 212
	.db #0x34	; 52	'4'
	.db #0xb4	; 180
	.db #0x74	; 116	't'
	.db #0xf4	; 244
	.db #0x0c	; 12
	.db #0x8c	; 140
	.db #0x4c	; 76	'L'
	.db #0xcc	; 204
	.db #0x2c	; 44
	.db #0xac	; 172
	.db #0x6c	; 108	'l'
	.db #0xec	; 236
	.db #0x1c	; 28
	.db #0x9c	; 156
	.db #0x5c	; 92
	.db #0xdc	; 220
	.db #0x3c	; 60
	.db #0xbc	; 188
	.db #0x7c	; 124
	.db #0xfc	; 252
	.db #0x02	; 2
	.db #0x82	; 130
	.db #0x42	; 66	'B'
	.db #0xc2	; 194
	.db #0x22	; 34
	.db #0xa2	; 162
	.db #0x62	; 98	'b'
	.db #0xe2	; 226
	.db #0x12	; 18
	.db #0x92	; 146
	.db #0x52	; 82	'R'
	.db #0xd2	; 210
	.db #0x32	; 50	'2'
	.db #0xb2	; 178
	.db #0x72	; 114	'r'
	.db #0xf2	; 242
	.db #0x0a	; 10
	.db #0x8a	; 138
	.db #0x4a	; 74	'J'
	.db #0xca	; 202
	.db #0x2a	; 42
	.db #0xaa	; 170
	.db #0x6a	; 106	'j'
	.db #0xea	; 234
	.db #0x1a	; 26
	.db #0x9a	; 154
	.db #0x5a	; 90	'Z'
	.db #0xda	; 218
	.db #0x3a	; 58
	.db #0xba	; 186
	.db #0x7a	; 122	'z'
	.db #0xfa	; 250
	.db #0x06	; 6
	.db #0x86	; 134
	.db #0x46	; 70	'F'
	.db #0xc6	; 198
	.db #0x26	; 38
	.db #0xa6	; 166
	.db #0x66	; 102	'f'
	.db #0xe6	; 230
	.db #0x16	; 22
	.db #0x96	; 150
	.db #0x56	; 86	'V'
	.db #0xd6	; 214
	.db #0x36	; 54	'6'
	.db #0xb6	; 182
	.db #0x76	; 118	'v'
	.db #0xf6	; 246
	.db #0x0e	; 14
	.db #0x8e	; 142
	.db #0x4e	; 78	'N'
	.db #0xce	; 206
	.db #0x2e	; 46
	.db #0xae	; 174
	.db #0x6e	; 110	'n'
	.db #0xee	; 238
	.db #0x1e	; 30
	.db #0x9e	; 158
	.db #0x5e	; 94
	.db #0xde	; 222
	.db #0x3e	; 62
	.db #0xbe	; 190
	.db #0x7e	; 126
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x41	; 65	'A'
	.db #0xc1	; 193
	.db #0x21	; 33
	.db #0xa1	; 161
	.db #0x61	; 97	'a'
	.db #0xe1	; 225
	.db #0x11	; 17
	.db #0x91	; 145
	.db #0x51	; 81	'Q'
	.db #0xd1	; 209
	.db #0x31	; 49	'1'
	.db #0xb1	; 177
	.db #0x71	; 113	'q'
	.db #0xf1	; 241
	.db #0x09	; 9
	.db #0x89	; 137
	.db #0x49	; 73	'I'
	.db #0xc9	; 201
	.db #0x29	; 41
	.db #0xa9	; 169
	.db #0x69	; 105	'i'
	.db #0xe9	; 233
	.db #0x19	; 25
	.db #0x99	; 153
	.db #0x59	; 89	'Y'
	.db #0xd9	; 217
	.db #0x39	; 57	'9'
	.db #0xb9	; 185
	.db #0x79	; 121	'y'
	.db #0xf9	; 249
	.db #0x05	; 5
	.db #0x85	; 133
	.db #0x45	; 69	'E'
	.db #0xc5	; 197
	.db #0x25	; 37
	.db #0xa5	; 165
	.db #0x65	; 101	'e'
	.db #0xe5	; 229
	.db #0x15	; 21
	.db #0x95	; 149
	.db #0x55	; 85	'U'
	.db #0xd5	; 213
	.db #0x35	; 53	'5'
	.db #0xb5	; 181
	.db #0x75	; 117	'u'
	.db #0xf5	; 245
	.db #0x0d	; 13
	.db #0x8d	; 141
	.db #0x4d	; 77	'M'
	.db #0xcd	; 205
	.db #0x2d	; 45
	.db #0xad	; 173
	.db #0x6d	; 109	'm'
	.db #0xed	; 237
	.db #0x1d	; 29
	.db #0x9d	; 157
	.db #0x5d	; 93
	.db #0xdd	; 221
	.db #0x3d	; 61
	.db #0xbd	; 189
	.db #0x7d	; 125
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0x83	; 131
	.db #0x43	; 67	'C'
	.db #0xc3	; 195
	.db #0x23	; 35
	.db #0xa3	; 163
	.db #0x63	; 99	'c'
	.db #0xe3	; 227
	.db #0x13	; 19
	.db #0x93	; 147
	.db #0x53	; 83	'S'
	.db #0xd3	; 211
	.db #0x33	; 51	'3'
	.db #0xb3	; 179
	.db #0x73	; 115	's'
	.db #0xf3	; 243
	.db #0x0b	; 11
	.db #0x8b	; 139
	.db #0x4b	; 75	'K'
	.db #0xcb	; 203
	.db #0x2b	; 43
	.db #0xab	; 171
	.db #0x6b	; 107	'k'
	.db #0xeb	; 235
	.db #0x1b	; 27
	.db #0x9b	; 155
	.db #0x5b	; 91
	.db #0xdb	; 219
	.db #0x3b	; 59
	.db #0xbb	; 187
	.db #0x7b	; 123
	.db #0xfb	; 251
	.db #0x07	; 7
	.db #0x87	; 135
	.db #0x47	; 71	'G'
	.db #0xc7	; 199
	.db #0x27	; 39
	.db #0xa7	; 167
	.db #0x67	; 103	'g'
	.db #0xe7	; 231
	.db #0x17	; 23
	.db #0x97	; 151
	.db #0x57	; 87	'W'
	.db #0xd7	; 215
	.db #0x37	; 55	'7'
	.db #0xb7	; 183
	.db #0x77	; 119	'w'
	.db #0xf7	; 247
	.db #0x0f	; 15
	.db #0x8f	; 143
	.db #0x4f	; 79	'O'
	.db #0xcf	; 207
	.db #0x2f	; 47
	.db #0xaf	; 175
	.db #0x6f	; 111	'o'
	.db #0xef	; 239
	.db #0x1f	; 31
	.db #0x9f	; 159
	.db #0x5f	; 95
	.db #0xdf	; 223
	.db #0x3f	; 63
	.db #0xbf	; 191
	.db #0x7f	; 127
	.db #0xff	; 255
__xinit__maxSalto:
	.db #0xff	; 255
__xinit__alex:
	.db #0x1e	; 30
	.db #0x96	; 150
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
__xinit__lastFrame:
	.db #0xff	; 255
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
