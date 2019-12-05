; template.asm -- assembly language template for
; learn assembly on the ti-83x in 28 days, with
; modifications to work with spasm instead of tasm

	.nolist
#include "..\includes\ti84pce.inc"
#define ProgStart userMem
	.list

	.org	ProgStart-2
	.db	tExtTok,tAsm84CeCmp
; your code here
	ret
	.end
