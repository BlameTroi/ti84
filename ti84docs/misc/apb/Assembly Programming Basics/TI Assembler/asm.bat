@echo off
	echo ----- Assembling %1 for the TI-83 Plus...
	tasm -80 -i -b %1.z80 %1.bin
	if errorlevel 1 goto ERRORS
	echo ObjHex Converter   	  Version 1.2
	echo  Copyright (C) 2000 Jeff Chai
	objhex %1.bin > %1.hex
	echo ----- Converting to hexadecimal format...

echo ObjHex: HexaDecimal version is %1.hex
	echo ObjHex: Task Complete!
	goto DONE
	:ERRORS
	echo ----- Errors were found!
	:DONE
	echo ----- Done
