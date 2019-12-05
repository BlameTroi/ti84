#include "includes\ti84pce.inc"
 
 .assume ADL=1
 .org userMem-2
 .db tExtTok,tAsm84CeCmp
 
 call _homeup
 call _ClrScrnFull
 ld hl,TutorialText
 call _Puts
 call _GetKey
 call _ClrScrnFull
 res donePrgm,(iy+doneFlags)
 ret
 
TutorialText:
  .db "Hey, do we have a working assembly programm here?",0
