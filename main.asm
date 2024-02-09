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
	.globl _draw_main_character
	.globl _draw_entidad
	.globl _loadGrapVRAM
	.globl _init
	.globl _PSGFrame
	.globl _PSGPlay
	.globl _SMS_VRAMmemsetW
	.globl _SMS_VRAMmemcpy
	.globl _SMS_resetPauseRequest
	.globl _SMS_queryPauseRequested
	.globl _SMS_getKeysHeld
	.globl _SMS_loadSpritePalette
	.globl _SMS_loadBGPalette
	.globl _SMS_copySpritestoSAT
	.globl _SMS_finalizeSprites
	.globl _SMS_addSprite_f
	.globl _SMS_initSprites
	.globl _SMS_waitForVBlank
	.globl _SMS_setSpriteMode
	.globl _SMS_setBGScrollY
	.globl _SMS_setBGScrollX
	.globl _SMS_VDPturnOffFeature
	.globl _SMS_VDPturnOnFeature
	.globl _SMS_init
	.globl _printf
	.globl _delay_frame_player
	.globl _frame_player
	.globl _player_y
	.globl _player_v_x
	.globl _player_x
	.globl _spriteAlex
	.globl _alex
	.globl _SMS_SRAM
	.globl _SRAM_bank_to_be_mapped_on_slot2
	.globl _ROM_bank_to_be_mapped_on_slot0
	.globl _ROM_bank_to_be_mapped_on_slot1
	.globl _ROM_bank_to_be_mapped_on_slot2
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
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_alex::
	.ds 3
_spriteAlex::
	.ds 3
_player_x::
	.ds 2
_player_v_x::
	.ds 2
_player_y::
	.ds 2
_frame_player::
	.ds 1
_delay_frame_player::
	.ds 2
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
;main.c:21: void init(){
;	---------------------------------
; Function init
; ---------------------------------
_init::
;main.c:22: SMS_init();
;main.c:23: }
	jp	_SMS_init
;main.c:25: void loadGrapVRAM(){
;	---------------------------------
; Function loadGrapVRAM
; ---------------------------------
_loadGrapVRAM::
;main.c:26: SMS_init();
	call	_SMS_init
;main.c:28: SMS_setSpriteMode(SPRITEMODE_TALL);
	ld	l, #0x01
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setSpriteMode
;main.c:29: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl, #0x0020
	call	_SMS_VDPturnOnFeature
;main.c:30: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:31: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl, #0x0020
	call	_SMS_VDPturnOnFeature
;main.c:32: SMS_loadBGPalette(sonicpalette_inc);
	ld	hl, #_sonicpalette_inc
	call	_SMS_loadBGPalette
;main.c:34: SMS_loadSpritePalette(palleteAlex_inc);
	ld	hl, #_palleteAlex_inc
	call	_SMS_loadSpritePalette
;main.c:35: SMS_loadTiles(sonictiles_inc,0,sonictiles_inc_size);
	ld	hl, #0x14c0
	push	hl
	ld	de, #_sonictiles_inc
	ld	hl, #0x4000
	call	_SMS_VRAMmemcpy
;main.c:37: SMS_loadTiles(spriteAlex_inc,256/*SPRITE_TILES_POSITION*/,spriteAlex_inc_size);
	ld	hl, #0x0400
	push	hl
	ld	de, #_spriteAlex_inc
	ld	h, #0x60
	call	_SMS_VRAMmemcpy
;main.c:38: SMS_loadTileMap(0,0,sonictilemap_inc,sonictilemap_inc_size);
	ld	hl, #0x0600
	push	hl
	ld	de, #_sonictilemap_inc
	ld	h, #0x78
	call	_SMS_VRAMmemcpy
;main.c:39: }
	ret
;main.c:47: draw_entidad(T_entidad *entidad, T_sprite *sprite){
;	---------------------------------
; Function draw_entidad
; ---------------------------------
_draw_entidad::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-18
	add	iy, sp
	ld	sp, iy
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-6 (ix), e
	ld	-5 (ix), d
;main.c:49: for(j=0;j<sprite->alto;j++) {
	ld	a, -6 (ix)
	ld	-18 (ix), a
	ld	a, -5 (ix)
	ld	-17 (ix), a
	ld	a, -4 (ix)
	ld	-16 (ix), a
	ld	a, -3 (ix)
	ld	-15 (ix), a
	ld	a, -4 (ix)
	ld	-14 (ix), a
	ld	a, -3 (ix)
	ld	-13 (ix), a
	ld	a, -6 (ix)
	ld	-12 (ix), a
	ld	a, -5 (ix)
	ld	-11 (ix), a
	ld	-2 (ix), #0x00
00107$:
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	a,-2 (ix)
	sub	a,(hl)
	jp	NC, 00109$
;main.c:50: for(i=0;i<sprite->ancho;i++) {
	ld	-1 (ix), #0x00
00104$:
	ld	l, -12 (ix)
	ld	h, -11 (ix)
	inc	hl
	ld	a,-1 (ix)
	sub	a,(hl)
	jr	NC, 00108$
;main.c:51: SMS_addSprite(entidad->x+(i<<3),entidad->y+(j<<4), sprite->tamano*entidad->frame + (j<<2) + (i<<1) );  
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	c, (hl)
	ld	b, #0x00
	ld	a, -1 (ix)
	ld	-10 (ix), a
	ld	-9 (ix), #0x00
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
;	spillPairReg hl
;	spillPairReg hl
	ld	b, l
	ld	c, #0x00
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	inc	hl
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	push	bc
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00141$:
	add	hl, hl
	jr	NC, 00142$
	add	hl, de
00142$:
	djnz	00141$
	pop	bc
	ex	de, hl
	ld	a, -2 (ix)
	ld	-8 (ix), a
	ld	-7 (ix), #0x00
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
	ex	de, hl
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	add	hl, hl
	add	hl, de
;	spillPairReg hl
;	spillPairReg hl
	ld	a, c
	or	a, l
	ld	e, a
	ld	d, b
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	call	_SMS_addSprite_f
;main.c:50: for(i=0;i<sprite->ancho;i++) {
	inc	-1 (ix)
	jp	00104$
00108$:
;main.c:49: for(j=0;j<sprite->alto;j++) {
	inc	-2 (ix)
	jp	00107$
00109$:
;main.c:54: }
	ld	sp, ix
	pop	ix
	ret
;main.c:56: draw_main_character(){
;	---------------------------------
; Function draw_main_character
; ---------------------------------
_draw_main_character::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-14
	add	hl, sp
	ld	sp, hl
;main.c:59: unsigned char sumy=0;
	ld	-14 (ix), #0x00
;main.c:60: for(numSprites=0;numSprites<4;numSprites++){
	ld	-1 (ix), #0x00
;main.c:61: for(j=0;j<2;j++) {
00114$:
	ld	c, #0x00
;main.c:62: for(i=0;i<2;i++) {
00112$:
	ld	b, #0x00
00104$:
;main.c:63: SMS_addSprite(player_x+(i<<3),player_y+(j<<4)+sumy, (frame_player<<3) + (j<<2) + (i<<1) );  
	ld	d, b
	ld	e, #0x00
	ld	-13 (ix), d
	ld	-12 (ix), e
	ld	a, #0x03
00150$:
	sla	-13 (ix)
	rl	-12 (ix)
	dec	a
	jr	NZ, 00150$
	ld	a, (_player_x+0)
	add	a, -13 (ix)
	ld	-3 (ix), a
	ld	a, (_player_x+1)
	adc	a, -12 (ix)
	ld	-2 (ix), a
	ld	l, -3 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	-2 (ix), l
	ld	-3 (ix), #0x00
	ld	a, (_frame_player+0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	hl
	pop	iy
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	-11 (ix), l
	ld	-10 (ix), h
	ld	a, #0x02
00151$:
	sla	-11 (ix)
	rl	-10 (ix)
	dec	a
	jr	NZ, 00151$
	push	bc
	ld	c, -11 (ix)
	ld	b, -10 (ix)
	add	iy, bc
	pop	bc
	sla	d
	rl	e
	ld	-9 (ix), d
	ld	-8 (ix), e
	ld	e, -9 (ix)
	ld	d, -8 (ix)
	add	iy, de
	ld	e, #0x00
	ld	a, -2 (ix)
	or	a, e
	push	iy
	ld	-15 (ix), a
	pop	iy
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	-7 (ix), l
	ld	-6 (ix), h
	ld	a, (_player_y+0)
	add	a, -7 (ix)
	ld	e, a
	ld	a, (_player_y+1)
	adc	a, -6 (ix)
	ld	d, a
	ld	a, -14 (ix)
	ld	-5 (ix), a
	ld	-4 (ix), #0x00
	ld	l, -5 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	bc
	push	iy
	pop	de
	call	_SMS_addSprite_f
	pop	bc
;main.c:64: SMS_addSprite(player_x+(i<<3)+20,player_y+(j<<4)+sumy, (frame_player<<3) + (j<<2) + (i<<1) );  
	ld	a, (_player_x+0)
	add	a, -13 (ix)
	ld	e, a
	ld	a, (_player_x+1)
	adc	a, -12 (ix)
	ld	d, a
	ld	hl, #0x0014
	add	hl, de
	ld	d, l
	ld	a, (_frame_player+0)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, -11 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -10 (ix)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
	add	a, -9 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -8 (ix)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	-3 (ix), l
	ld	a, d
	or	a, h
	ld	-2 (ix), a
	ld	a, (_player_y+0)
	add	a, -7 (ix)
	ld	e, a
	ld	a, (_player_y+1)
	adc	a, -6 (ix)
	ld	d, a
	ld	l, -5 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	bc
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	call	_SMS_addSprite_f
	pop	bc
;main.c:65: SMS_addSprite(player_x+(i<<3)+40,player_y+(j<<4)+sumy, (frame_player<<3) + (j<<2) + (i<<1) );  
	ld	a, (_player_x+0)
	add	a, -13 (ix)
	ld	e, a
	ld	a, (_player_x+1)
	adc	a, -12 (ix)
	ld	d, a
	ld	hl, #0x0028
	add	hl, de
	ld	d, l
	ld	a, (_frame_player+0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, -11 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -10 (ix)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
	add	a, -9 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -8 (ix)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	-3 (ix), l
	ld	a, d
	or	a, h
	ld	-2 (ix), a
	ld	a, (_player_y+0)
	add	a, -7 (ix)
	ld	e, a
	ld	a, (_player_y+1)
	adc	a, -6 (ix)
	ld	d, a
	ld	l, -5 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	bc
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	call	_SMS_addSprite_f
	pop	bc
;main.c:66: SMS_addSprite(player_x+(i<<3)+60,player_y+(j<<4)+sumy, (frame_player<<3) + (j<<2) + (i<<1) );  
	ld	a, -13 (ix)
	ld	hl, #_player_x
	add	a, (hl)
	ld	e, a
	ld	a, -12 (ix)
	inc	hl
	adc	a, (hl)
	ld	d, a
	ld	hl, #0x003c
	add	hl, de
;	spillPairReg hl
;	spillPairReg hl
	ld	h, l
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (_frame_player+0)
	ld	d, #0x00
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, -11 (ix)
	ld	e, a
	ld	a, d
	adc	a, -10 (ix)
	ld	a, -9 (ix)
	add	a, e
	ld	e, a
	xor	a, a
	or	a, h
	ld	d, a
	ld	a, -7 (ix)
	ld	hl, #_player_y
	add	a, (hl)
	ld	-3 (ix), a
	ld	a, -6 (ix)
	inc	hl
	adc	a, (hl)
	ld	-2 (ix), a
	ld	a, -5 (ix)
	add	a, -3 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x00
	adc	a, -2 (ix)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	push	bc
	call	_SMS_addSprite_f
	pop	bc
;main.c:62: for(i=0;i<2;i++) {
	inc	b
	ld	a, b
	sub	a, #0x02
	jp	C, 00104$
;main.c:61: for(j=0;j<2;j++) {
	inc	c
	ld	a, c
	sub	a, #0x02
	jp	C, 00112$
;main.c:69: sumy = numSprites*30;
	ld	a, -1 (ix)
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	sub	a, c
	add	a, a
	ld	-14 (ix), a
;main.c:60: for(numSprites=0;numSprites<4;numSprites++){
	inc	-1 (ix)
	ld	a, -1 (ix)
	sub	a, #0x04
	jp	C, 00114$
;main.c:71: }
	ld	sp, ix
	pop	ix
	ret
;main.c:73: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;main.c:78: SMS_VRAMmemsetW(0, 0x0000, 16384);
	ld	-1 (ix), #0x00
	ld	-2 (ix), #0x00
	ld	hl, #0x4000
	push	hl
	ld	de, #0x0000
	ld	h, l
	call	_SMS_VRAMmemsetW
;main.c:88: printf("Hello, World! [1/3]");
	ld	hl, #___str_0
	push	hl
	call	_printf
	pop	af
;main.c:99: loadGrapVRAM();
	call	_loadGrapVRAM
;main.c:101: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:102: SMS_setBGScrollX(scroll_x);
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollX
;main.c:103: SMS_setBGScrollY(scroll_y);
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollY
;main.c:104: SMS_init();
	call	_SMS_init
;main.c:110: PSGPlay(titulo_psg);
	ld	hl, #_titulo_psg
	call	_PSGPlay
;main.c:111: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl, #0x0020
	call	_SMS_VDPturnOnFeature
00124$:
;main.c:113: if(SMS_queryPauseRequested ()){
	call	_SMS_queryPauseRequested
	bit	0,a
	jr	Z, 00105$
;main.c:114: SMS_resetPauseRequest ();
	call	_SMS_resetPauseRequest
;main.c:115: while(!SMS_queryPauseRequested ()){
00101$:
	call	_SMS_queryPauseRequested
	bit	0,a
	jr	NZ, 00103$
;main.c:116: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:117: PSGFrame();
	call	_PSGFrame
	jr	00101$
00103$:
;main.c:119: SMS_resetPauseRequest();
	call	_SMS_resetPauseRequest
00105$:
;main.c:123: int keys = SMS_getKeysHeld();
	call	_SMS_getKeysHeld
;main.c:124: if(keys & PORT_A_KEY_LEFT){
	bit	2, e
	jr	Z, 00110$
;main.c:125: player_v_x=-1; 
	ld	hl, #0xffff
	ld	(_player_v_x), hl
	jr	00111$
00110$:
;main.c:127: else if(keys & PORT_A_KEY_RIGHT){
	bit	3, e
	jr	Z, 00107$
;main.c:128: player_v_x=1; 
	ld	hl, #0x0001
	ld	(_player_v_x), hl
	jr	00111$
00107$:
;main.c:131: player_v_x=0; 
	ld	hl, #0x0000
	ld	(_player_v_x), hl
00111$:
;main.c:133: player_x = player_x + player_v_x;
	ld	hl, #_player_v_x
	push	de
	ld	de, #_player_x
	ld	a, (de)
	add	a, (hl)
	inc	hl
	ld	(de), a
	inc	de
	ld	a, (de)
	adc	a, (hl)
	ld	(de), a
	pop	de
;main.c:134: if(player_v_x != 0)
	ld	a, (_player_v_x+1)
	ld	hl, #_player_v_x
	or	a, (hl)
	jr	Z, 00113$
;main.c:135: delay_frame_player++;
	ld	hl, (_delay_frame_player)
	inc	hl
	ld	(_delay_frame_player), hl
	jr	00114$
00113$:
;main.c:137: delay_frame_player=15;
	ld	hl, #0x000f
	ld	(_delay_frame_player), hl
;main.c:138: frame_player=1;
	ld	hl, #_frame_player
	ld	(hl), #0x01
00114$:
;main.c:140: if(delay_frame_player%16==0){
	ld	de, #0x0010
	ld	hl, (_delay_frame_player)
	call	__modsint
	ld	a, d
	or	a, e
	jr	NZ, 00118$
;main.c:141: frame_player++;
	ld	iy, #_frame_player
	inc	0 (iy)
;main.c:142: if(frame_player>3){
	ld	a, #0x03
	sub	a, 0 (iy)
	jr	NC, 00118$
;main.c:143: frame_player=0;
	ld	0 (iy), #0x00
00118$:
;main.c:147: SMS_initSprites();
	call	_SMS_initSprites
;main.c:149: alex.x = player_x;
	ld	a, (_player_x+0)
	ld	(#_alex),a
;main.c:150: alex.y = player_y;
	ld	a, (_player_y+0)
	ld	(#(_alex + 1)),a
;main.c:151: alex.frame = frame_player;
	ld	hl, #(_alex + 2)
	ld	a, (_frame_player+0)
	ld	(hl), a
;main.c:152: draw_entidad(&alex, &spriteAlex);
	ld	de, #_spriteAlex
	ld	hl, #_alex
	call	_draw_entidad
;main.c:153: SMS_finalizeSprites();
	call	_SMS_finalizeSprites
;main.c:154: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:155: SMS_copySpritestoSAT();
	call	_SMS_copySpritestoSAT
;main.c:156: PSGFrame();
	call	_PSGFrame
;main.c:157: SMS_displayOff();
	ld	hl, #0x0140
	call	_SMS_VDPturnOffFeature
;main.c:158: if(scroll_y%2==0)
	bit	0, -1 (ix)
	jr	NZ, 00120$
;main.c:159: scroll_x += 1;
	inc	-2 (ix)
00120$:
;main.c:160: scroll_y++;
	inc	-1 (ix)
;main.c:161: if(scroll_y==224)
	ld	a, -1 (ix)
	sub	a, #0xe0
	jr	NZ, 00122$
;main.c:162: scroll_y=0;
	ld	-1 (ix), #0x00
00122$:
;main.c:164: SMS_setBGScrollX(scroll_x);
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollX
;main.c:166: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:168: }
	jp	00124$
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
__xinit__alex:
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
__xinit__spriteAlex:
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x08	; 8
__xinit__player_x:
	.dw #0x0032
__xinit__player_v_x:
	.dw #0x0000
__xinit__player_y:
	.dw #0x0014
__xinit__frame_player:
	.db #0x00	; 0
__xinit__delay_frame_player:
	.dw #0x000f
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
