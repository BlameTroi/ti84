;BITMAPS.ASM - four bitmap routines
;for use with Robert Taylor's GRAYLIB
;(C) 1996 by Andreas Ess
; ess.andreas@computerhaus.at
;
;Try to optimize 'em!!!
;
;I'm not liable for any damages this may cause
;-----------------------------------------------------------------------------

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;NTSprite8: draws sprite %IX at (B*8,C*8) without transparency
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
NTSprite8:
 push hl
 push ix
 push bc
 push de
 inc  c
 mov  h, 0             ;calculate offset: HL = C*128+B
 mov  l, c
 MulHL16
 add  hl, hl
 add  hl, hl
 add  hl, hl
 mov  d, 0
 mov  e, b
 add  hl, de
 mov  b, h
 mov  c, l
 mov  hl, (Page2Addr)
 add  hl, bc
 ex   de, hl
 mov  hl, (Page1Addr)
 add  hl, bc
 mov  b, 8
NTSprite8L:
 push bc
 mov  a, (ix)
 mov  (hl), a
 mov  a, (ix+8)
 mov  (de), a
 inc  ix
 mov  bc, 16
 add  hl, bc
 ex   de, hl
 add  hl, bc
 ex   de, hl
 pop  bc
 loop NTSprite8L
 pop  de
 pop  bc
 pop  ix
 pop  hl
 ret

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;Sprite8: draws sprite %IX at (B*8,C*8), white being transparent
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Sprite8:
 push bc
 push de
 mov  h, 0             ;calculate offset: HL = C*128+B
 mov  l, c
 MulHL16
 add  hl, hl
 add  hl, hl
 add  hl, hl
 mov  d, 0
 mov  e, b
 add  hl, de
 mov  b, h
 mov  c, l
 mov  hl, (Page2Addr)
 add  hl, bc
 ex   de, hl
 mov  hl, (Page1Addr)
 add  hl, bc
 mov  c, 8
 mov  b, 128
Sprite8L:
 mov  a, (ix)
 and  b
 jz   S_Point0
 mov  a, (hl)
 or   b
 mov  (hl), a
 mov  a, (ix+8)
 and  b
 jz   S_Point01
 mov  a, (de)
 or   b
 mov  (de), a
 jmp  Sprite8LA
S_Point0:
 mov  a, (ix+8)
 and  b
 jz   Sprite8LA
 mov  a, (de)
 or   b
 mov  (de), a
 mov  a, b
 xor  255
 and  (hl)
 mov  (hl), a
 jmp  Sprite8LA
S_Point01:
 mov  a, (ix)
 and  b
 jz   Sprite8LA
 mov  a, (hl)
 or   b
 mov  (hl), a
 ex   de, hl
 mov  a, b
 xor  255
 and  (hl)
 mov  (hl), a
 ex   de, hl
Sprite8LA:
 ror  b
 jnc  Sprite8L
 push bc
 mov  bc, 16
 add  hl, bc
 ex   de, hl
 add  hl, bc
 ex   de, hl
 pop  bc
 inc  ix
 dec  c
 jnz  Sprite8L
 pop  de
 pop  bc
 ret

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;SpriteGAP: get bk to (SpriteHlp) and then puts sprite IX at (B,C)
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
SpriteGAP:
 mov  a, b
 cmp  121
 jb   SpriteGAP_Start
 mov  de, 7
 add  ix, de
 mov  hl, (SpriteHlp)
 add  hl, de
 mov  (SpriteHlp), hl
 ret
SpriteGAP_Start:
 push bc
 mov  hl, (SpriteHlp)
 mov  (SpriteHlp1), ix
 mov  a, 8
 mov  (SprLine), a
 mov  h, 0
 mov  l, c
 mov  d, h
 MulHL16
 push bc
 shr  b
 shr  b
 shr  b
 mov  e, b
 add  hl, de
 mov  b, h
 mov  c, l
 mov  hl, (Page2Addr)
 add  hl, bc
 ex   de, hl
 mov  hl, (Page1Addr)
 add  hl, bc
 pop  bc
 mov  a, b
;**And now start:
 mov  bc, 16
 mov  b, 128
 mov  c, b
 and  7
 jz   SpriteGAP_B
 mov  b, a
SpriteGAP_S:
 shr  c
 loop SpriteGAP_S
 mov  b, 128
SpriteGAP_B:
 mov  ix, (SpriteHlp)
 mov  a, (hl)
 and  c
 jz   SG_CheckPage2
 mov  a, (ix)
 or   b
 mov  (ix), a
SG_CheckPage2:
 mov  a, (de)
 and  c
 jz   SG_Draw
 mov  a, (ix+8)
 or   b
 mov  (ix+8), a
SG_Draw:
 mov  ix, (SpriteHlp1)
 mov  a, (ix)
 and  b
 jz   SG_Point0
 mov  a, (hl)
 or   c
 mov  (hl), a
 mov  a, (ix+8)
 and  b
 jz   SG_Point01
 mov  a, (de)
 or   c
 mov  (de), a
 jmp  SG_Loop
SG_Point0:
 mov  a, (ix+8)
 and  b
 jz   SG_Loop
 mov  a, (de)
 or   c
 mov  (de), a
 mov  a, c
 xor  255
 and  (hl)
 mov  (hl), a
 jmp  SG_Loop
SG_Point01:
 mov  a, (ix)
 and  b
 jz   SG_Loop
 mov  a, (de)
 or   c
 mov  (de), a
 ex   de, hl
 mov  a, c
 xor  255
 and  (hl)
 mov  (hl), a
 ex   de, hl
SG_Loop:
 ror  c
 jnc  SG_RorB
 inc  hl
 inc  de
SG_RorB:
 ror  b
 jnc  SpriteGAP_B
 mov  a, (SprLine)
 dec  a
 mov  (SprLine), a
 jz   SG_End
 inc  ix
 mov  (SpriteHlp1), ix
 push bc
 mov  bc, (SpriteHlp)
 inc  bc
 mov  (SpriteHlp), bc
 mov  bc, 15
 add  hl, bc
 ex   de, hl
 add  hl, bc
 ex   de, hl
 pop  bc
 JUMP_(SpriteGAP_B)
SG_End:
 pop  bc
 ret

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;Bitmap: draws image %IX at (B,C)
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Bitmap:
 push bc
 push hl
 push de
 mov  a, 8
 mov  (TempByte), a
 mov  a, b
 mov  h, 0
 mov  l, c
 add  hl, hl
 add  hl, hl
 add  hl, hl
 add  hl, hl
 shr  b
 shr  b
 shr  b
 mov  d, 0
 mov  e, b
 add  hl, de
 mov  b, h
 mov  c, l
 mov  hl, (Page2Addr)
 add  hl, bc
 ex   de, hl
 mov  hl, (Page1Addr)
 add  hl, bc
 mov  b, 128
 mov  c, b
 and  7
 jz   BMP_B
 mov  b, a
BMP_S:
 shr  c
 loop BMP_S
 mov  b, 128
BMP_B:
 mov  a, (ix)
 and  b
 jz   BMP_Point0
 mov  a, (hl)
 or   c
 mov  (hl), a
 jmp  BMP_Check2
BMP_Point0:
 mov  a, c
 xor  255
 and  (hl)
 mov  (hl), a
BMP_Check2:
 mov  a, (ix+8)
 and  b
 jz   BMP_Point01
 mov  a, (de)
 or   c
 mov  (de), a
 jmp  BMP_Loop
BMP_Point01:
 ex   de, hl
 mov  a, c
 xor  255
 and  (hl)
 mov  (hl), a
 ex   de, hl
BMP_Loop:
 ror  c
 jnc  BMP_RorB
 inc  hl
 inc  de
BMP_RorB:
 ror  b
 jnc  BMP_B
 inc  ix
 mov  a, (TempByte)
 dec  a
 mov  (TempByte), a
 jz   BMP_End
 push bc
 mov  bc, 15
 add  hl, bc
 ex   de, hl
 add  hl, bc
 ex   de, hl
 pop  bc
 jmp  BMP_B
BMP_End:
 pop  de
 pop  hl
 pop  bc
 ret
