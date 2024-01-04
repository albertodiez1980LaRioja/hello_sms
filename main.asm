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
	.globl _loadGrapVRAM
	.globl _init
	.globl _PSGFrame
	.globl _PSGPlay
	.globl _SMS_VRAMmemsetW
	.globl _SMS_VRAMmemcpy
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
	.globl _player_x
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
_player_x::
	.ds 2
_player_y::
	.ds 2
_frame_player::
	.ds 2
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
;main.c:10: void init(){
;	---------------------------------
; Function init
; ---------------------------------
_init::
;main.c:11: SMS_init();
;main.c:12: }
	jp	_SMS_init
;main.c:14: void loadGrapVRAM(){
;	---------------------------------
; Function loadGrapVRAM
; ---------------------------------
_loadGrapVRAM::
;main.c:15: SMS_init();
	call	_SMS_init
;main.c:16: SMS_setSpriteMode(SPRITEMODE_NORMAL);
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setSpriteMode
;main.c:17: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl, #0x0020
	call	_SMS_VDPturnOnFeature
;main.c:18: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:19: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl, #0x0020
	call	_SMS_VDPturnOnFeature
;main.c:20: SMS_loadBGPalette(sonicpalette_inc);
	ld	hl, #_sonicpalette_inc
	call	_SMS_loadBGPalette
;main.c:21: SMS_loadSpritePalette(alexVariosPaleta_inc);
	ld	hl, #_alexVariosPaleta_inc
	call	_SMS_loadSpritePalette
;main.c:22: SMS_loadTiles(sonictiles_inc,0,sonictiles_inc_size);
	ld	hl, #0x14c0
	push	hl
	ld	de, #_sonictiles_inc
	ld	hl, #0x4000
	call	_SMS_VRAMmemcpy
;main.c:23: SMS_loadTiles(alexAndando_inc,256/*SPRITE_TILES_POSITION*/,alexAndando_inc_size);
	ld	hl, #0x0300
	push	hl
	ld	de, #_alexAndando_inc
	ld	h, #0x60
	call	_SMS_VRAMmemcpy
;main.c:24: SMS_loadTileMap(0,0,sonictilemap_inc,sonictilemap_inc_size);
	ld	hl, #0x0600
	push	hl
	ld	de, #_sonictilemap_inc
	ld	h, #0x78
	call	_SMS_VRAMmemcpy
;main.c:25: }
	ret
;main.c:32: draw_main_character(){
;	---------------------------------
; Function draw_main_character
; ---------------------------------
_draw_main_character::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-9
	add	hl, sp
	ld	sp, hl
;main.c:35: for(numSprites=0;numSprites<2;numSprites++){
	ld	-1 (ix), #0x00
;main.c:36: for(j=0;j<3;j++) {
00114$:
	ld	c, #0x00
;main.c:37: for(i=0;i<2;i++) {
00112$:
	ld	b, #0x00
00104$:
;main.c:38: SMS_addSprite(player_x+(i<<3),player_y+(j<<3)+numSprites*30,2*frame_player + 8*j + i);  
	ld	-9 (ix), b
	ld	-8 (ix), #0x00
	ld	a, -9 (ix)
	ld	-7 (ix), a
	ld	a, -8 (ix)
	ld	-6 (ix), a
	ld	a, #0x03
00150$:
	sla	-7 (ix)
	rl	-6 (ix)
	dec	a
	jr	NZ, 00150$
	ld	a, (_player_x+0)
	add	a, -7 (ix)
	ld	d, a
	ld	a, (_player_x+1)
	adc	a, -6 (ix)
	ld	hl, (_frame_player)
	add	hl, hl
	ld	-3 (ix), c
	ld	-2 (ix), #0x00
	ld	a, -3 (ix)
	ld	-5 (ix), a
	ld	a, -2 (ix)
	ld	-4 (ix), a
	ld	a, #0x03
00151$:
	sla	-5 (ix)
	rl	-4 (ix)
	dec	a
	jr	NZ, 00151$
	ld	a, l
	add	a, -5 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -4 (ix)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
	add	a, -9 (ix)
	push	iy
	ld	-11 (ix), a
	pop	iy
	ld	a, h
	adc	a, -8 (ix)
	push	iy
	ld	-10 (ix), d
	pop	iy
	ld	a, (_player_y+0)
	add	a, -5 (ix)
	ld	e, a
	ld	a, (_player_y+1)
	adc	a, -4 (ix)
	ld	d, a
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	push	de
	ld	e, l
	ld	d, h
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, de
	add	hl, hl
	pop	de
	ld	-3 (ix), l
	ld	-2 (ix), h
	ld	l, -3 (ix)
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
;main.c:39: SMS_addSprite(player_x+(i<<3)+20,player_y+(j<<3)+numSprites*30,2*frame_player + 8*j + i);  
	ld	a, (_player_x+0)
	add	a, -7 (ix)
	ld	e, a
	ld	a, (_player_x+1)
	adc	a, -6 (ix)
	ld	d, a
	ld	hl, #0x0014
	add	hl, de
	ld	h, l
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	iy, (_frame_player)
	add	iy, iy
	ld	e, -5 (ix)
	ld	d, -4 (ix)
	add	iy, de
	pop	de
	push	de
	add	iy, de
	push	iy
	ld	-10 (ix), h
	pop	iy
	ld	a, (_player_y+0)
	add	a, -5 (ix)
	ld	e, a
	ld	a, (_player_y+1)
	adc	a, -4 (ix)
	ld	d, a
	ld	l, -3 (ix)
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
;main.c:40: SMS_addSprite(player_x+(i<<3)+40,player_y+(j<<3)+numSprites*30,2*frame_player + 8*j + i);  
	ld	a, (_player_x+0)
	add	a, -7 (ix)
	ld	e, a
	ld	a, (_player_x+1)
	adc	a, -6 (ix)
	ld	d, a
	ld	hl, #0x0028
	add	hl, de
	ld	h, l
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	iy, (_frame_player)
	add	iy, iy
	ld	e, -5 (ix)
	ld	d, -4 (ix)
	add	iy, de
	pop	de
	push	de
	add	iy, de
	push	iy
	ld	-10 (ix), h
	pop	iy
	ld	a, (_player_y+0)
	add	a, -5 (ix)
	ld	e, a
	ld	a, (_player_y+1)
	adc	a, -4 (ix)
	ld	d, a
	ld	l, -3 (ix)
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
;main.c:41: SMS_addSprite(player_x+(i<<3)+60,player_y+(j<<3)+numSprites*30,2*frame_player + 8*j + i);  
	ld	a, -7 (ix)
	ld	hl, #_player_x
	add	a, (hl)
	ld	e, a
	ld	a, -6 (ix)
	inc	hl
	adc	a, (hl)
	ld	d, a
	ld	hl, #0x003c
	add	hl, de
	ld	d, l
	ld	hl, (_frame_player)
	add	hl, hl
	ld	a, l
	add	a, -5 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -4 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -9 (ix)
	add	a, l
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	e, a
	ld	a, -5 (ix)
	ld	hl, #_player_y
	add	a, (hl)
	ld	-7 (ix), a
	ld	a, -4 (ix)
	inc	hl
	adc	a, (hl)
	ld	-6 (ix), a
	ld	a, -7 (ix)
	add	a, -3 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -6 (ix)
	adc	a, -2 (ix)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	push	bc
	call	_SMS_addSprite_f
	pop	bc
;main.c:37: for(i=0;i<2;i++) {
	inc	b
	ld	a, b
	sub	a, #0x02
	jp	C, 00104$
;main.c:36: for(j=0;j<3;j++) {
	inc	c
	ld	a, c
	sub	a, #0x03
	jp	C, 00112$
;main.c:35: for(numSprites=0;numSprites<2;numSprites++){
	inc	-1 (ix)
	ld	a, -1 (ix)
	sub	a, #0x02
	jp	C, 00114$
;main.c:46: }
	ld	sp, ix
	pop	ix
	ret
;main.c:48: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;main.c:53: SMS_VRAMmemsetW(0, 0x0000, 16384);
	ld	-1 (ix), #0x00
	ld	-2 (ix), #0x00
	ld	hl, #0x4000
	push	hl
	ld	de, #0x0000
	ld	h, l
	call	_SMS_VRAMmemsetW
;main.c:63: printf("Hello, World! [1/3]");
	ld	hl, #___str_0
	push	hl
	call	_printf
	pop	af
;main.c:74: loadGrapVRAM();
	call	_loadGrapVRAM
;main.c:76: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:77: SMS_setBGScrollX(scroll_x);
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollX
;main.c:78: SMS_setBGScrollY(scroll_y);
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollY
;main.c:79: SMS_init();
	call	_SMS_init
;main.c:80: SMS_setSpriteMode(SPRITEMODE_NORMAL);
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setSpriteMode
;main.c:84: PSGPlay(greenhill_psg);
	ld	hl, #_greenhill_psg
	call	_PSGPlay
;main.c:85: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl, #0x0020
	call	_SMS_VDPturnOnFeature
00110$:
;main.c:88: player_x++;
	ld	hl, (_player_x)
	inc	hl
	ld	(_player_x), hl
;main.c:89: delay_frame_player++;
	ld	hl, (_delay_frame_player)
	inc	hl
	ld	(_delay_frame_player), hl
;main.c:90: if(delay_frame_player%16==0){
	ld	de, #0x0010
	ld	hl, (_delay_frame_player)
	call	__modsint
	ld	a, d
	or	a, e
	jr	NZ, 00104$
;main.c:91: frame_player++;
	ld	hl, (_frame_player)
	inc	hl
	ld	(_frame_player), hl
;main.c:92: if(frame_player>3){
	ld	a, #0x03
	ld	iy, #_frame_player
	cp	a, 0 (iy)
	ld	a, #0x00
	sbc	a, 1 (iy)
	jp	PO, 00149$
	xor	a, #0x80
00149$:
	jp	P, 00104$
;main.c:93: frame_player=0;
	ld	hl, #0x0000
	ld	(_frame_player), hl
00104$:
;main.c:97: SMS_initSprites();
	call	_SMS_initSprites
;main.c:98: draw_main_character();
	call	_draw_main_character
;main.c:99: SMS_finalizeSprites();
	call	_SMS_finalizeSprites
;main.c:100: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:101: SMS_copySpritestoSAT();
	call	_SMS_copySpritestoSAT
;main.c:102: PSGFrame();
	call	_PSGFrame
;main.c:103: SMS_displayOff();
	ld	hl, #0x0140
	call	_SMS_VDPturnOffFeature
;main.c:104: if(scroll_y%2==0)
	bit	0, -1 (ix)
	jr	NZ, 00106$
;main.c:105: scroll_x += 1;
	inc	-2 (ix)
00106$:
;main.c:106: scroll_y++;
	inc	-1 (ix)
;main.c:107: if(scroll_y==224)
	ld	a, -1 (ix)
	sub	a, #0xe0
	jr	NZ, 00108$
;main.c:108: scroll_y=0;
	ld	-1 (ix), #0x00
00108$:
;main.c:110: SMS_setBGScrollX(scroll_x);
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setBGScrollX
;main.c:112: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:114: }
	jr	00110$
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
__xinit__player_x:
	.dw #0x0032
__xinit__player_y:
	.dw #0x0032
__xinit__frame_player:
	.dw #0x0000
__xinit__delay_frame_player:
	.dw #0x0004
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
