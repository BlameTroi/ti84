;Screen clear & copy routines (C) by Andreas Ess
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
;Show inactive page at actual screen page
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
Copy2Active:
 push bc
 mov  hl, (Page1Addr)
 mov  de, (PageCAddr)
 mov  bc, 1024
 ldir
 mov  hl, (Page2Addr)
 mov  de, (PageDAddr)
 mov  bc, 1024
 ldir
 pop  bc
 ret

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
;ClrScr: Clears the screen
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
ClrScr:
 push bc
 ld  hl, (Page1Addr)
 ld  d,h
 ld  e,l
 inc de
 ld  (hl), 0
 ld  bc, 1023
 ldir
 ld  hl, (Page2Addr)
 ld  d,h
 ld  e,l
 inc de
 ld  (hl), 0
 ld  bc, 1023
 ldir
 pop bc
 ret

