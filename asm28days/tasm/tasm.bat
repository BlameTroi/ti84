@echo off
echo === now assembling %1.z80 for the ti-8x plus ===
tasm -80 -i -b ..\source\%1.z80 ..\exec\%1.bin
if errorlevel 1 goto ERRORS
rem needed because of a devpac8x bug
cd ..\exec
..\tasm\devpac8x %1
cd ..\tasm
echo === job finished program saved as %1.8xp ===
goto DONE
:ERRORS
echo === Errors!!! ===
:DONE
rem originally deleted %1.lst and %1.bin but I'm leaving for now
echo === DONE ===
