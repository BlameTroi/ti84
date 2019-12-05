;-----------------------------------------------------------------------------
;                       Grayscale Compressed Pictures
;                   for use with greylib by Robert Taylor
;                           (C)1996 by Andreas Ess
;
;This is a routine which decompresses a picture stored in HL and puts it at
;Page1Addr & Page2Addr.
;This is based on ZCP by Stephane Jantzen. However, I've completely rewritten
;it. If you find a way to do this faster, send me snail mail:
; Andreas Ess
; Tufers 156
; A-6811 Goefis
; Austria/Europe
;
;E-Mail:
;ess.andreas@computerhaus.at
;
;NOTE: This routine was not written to be small, but to be quite fast.
;      (However, try to optimize it using the EX (SP), HL instruction, if you've
;       got time)
;      Andreas Ess isn't liable for any damages resulted by this piece of code.
;-----------------------------------------------------------------------------
#define GCPPoint1 .db $28,$03 \ ld a, (de) \ or c \ ld (de), a
#define GCPPoint2 .db $28,$03 \ ld a, (hl) \ or c \ ld (hl), a

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
;DeGCP: decompresses picture at %HL on (Page1Addr) & (Page2Addr) with
;       starting offset %BC
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
DeGCP:
 push hl
 pop  ix
 ex   de, hl
 mov  hl, (Page1Addr)           ;IX -> data
 add  hl, bc                    ;DE -> first page offset
 ex   de, hl
 mov  hl, (Page2Addr)           ;HL -> second page offset
 add  hl, bc
 mov  c, 128
 dec  ix
G_DLoop:
 inc  ix
 mov  a, (ix)                   ;get databyte
 and  a                         ;00h -> finished
 JUMP_Z(G_EndDecomp)
 mov  (Data), a                 ;save data byte
 bit  7, a                      ;bit 7: 0 = RLE; 1 = RAW MODE
 jz   G_RLE                     ;Z is set if bit is 0...
 mov  b, a
 and  %00100000
 GCPPoint1
 mov  a, b                      ;load color into a
 and  %00010000
 GCPPoint2
 ror  c
 jnc  CheckPoint2
 inc  de
 inc  hl
CheckPoint2:
 mov  a, b
 mov  (Color), a
 and  %00001000
 GCPPoint1                      ;put pixel on page 1 -> darkgray, black
 mov  a, b                      ;load color into a
 and  %00000100
 GCPPoint2                      ;put pixel on page 2 -> lightgray, black
 ror  c
 jnc  CheckPoint3
 inc  de
 inc  hl
CheckPoint3:
 mov  a, b
 and  %00000010
 GCPPoint1                      ;put pixel on page 1 -> darkgray, black
 mov  a, b                      ;load color into a
 and  %00000001
 GCPPoint2                      ;put pixel on page 2 -> lightgray, black
 ror  c
 jnc  G_DLoop
 inc  de
 inc  hl
 jmp  G_DLoop
G_RLE:
 mov  (Color), a                ;bits 5&6 contain grafix data
 mov  a, (Data)
 and  %00011111                 ;the bits from 0-4 the counter...
 mov  b, a
G_RLELoop:
 mov  a, (Color)                ;load color into a
 and  %01000000
 GCPPoint1
 mov  a, (Color)                ;load color into a
 and  %00100000
 GCPPoint2
 ror  c
 jnc  G_DoDJNZ_RLE
 inc  de
 inc  hl
G_DoDJNZ_RLE:
 loop G_RLELoop
 JUMP_(G_DLoop)
G_EndDecomp:
 ret
