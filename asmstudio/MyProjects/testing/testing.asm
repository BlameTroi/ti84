#include "ti83plus.inc"

.org _UserMem

; #include "ti83plus.inc"
#define ProgStart $9D95
.org    ProgStart-2
    .db T2BYTETOK,tasmcmp
    B_CALL _ClrLCDFull
    ld  hl,0
    ld  (_penCol),hl
    ld  hl,msg
    B_CALL _PutS       ; display
    B_CALL _NewLine
    ret
msg:
    .db "Hello World!",0
.end


.end
