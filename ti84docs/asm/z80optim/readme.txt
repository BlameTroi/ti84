===========================================================
 Z80 OPTIMIZATION TRICKS
===========================================================
 Version 2.00
 by Adam Ziemba
    Leif Åstrand

 Fortress Productions
 http://home.graffiti.net/fortress_productions

-----------------------------------------------------------
**Please read "disclaimer.txt" before using this program!**
-----------------------------------------------------------

___________________________________________________________
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
     CONTENTS:
___________________________________________________________
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
 I.   Introduction
 II.  Installation
 III. Credits
 IV.  Contact


___________________________________________________________
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
I.   INTRODUCTION
___________________________________________________________
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
     In hopes of getting Z80 Assembly programmers to write
more efficient programs, this list of optimization tricks
has been comprised. It is suggested that you memorize these
tricks so that you can become quick and adept at writing
efficient assembly programs.

    Please note that all the optimization tricks presented
here coincide with all the Z80-based calculators (TI-73,
82, 83, 83 Plus, 85, and the 86). It can, in fact, be used
on any Z80-based platform, calculator or not.

    This guide is targeted toward experienced programmers
who would like to learn how to write programs with optimal
efficiency. The basic concepts and elementals of the languages
presented here are beyond the scope of this guide. If you'd
like to learn Z80 Assembly, then visit this website:
<http://www.ticalc.org/pub/windows/z80/>

    Please note that this list is NOT complete. New tricks
are continually being added. For the most up-to-date list
of Z80 ASM Optimization tricks, visit the online version of
this guide at:
<http://fortress.fasthost.tv/programming/z80asm.html>

     Enjoy!


___________________________________________________________
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
II.  INSTALLATION
___________________________________________________________
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
 1)  Unarchive <z80optim.zip> into the directory of your
     choice and open up that folder. Make sure you have
     unarchived ALL of the files within <z80optim.zip> into
     the SAME folder, otherwise the guide will not appear
     correctly.
 2)  Double-click on "z80optim.html". Your browser should
     open up the guide.


___________________________________________________________
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
III. CREDITS
___________________________________________________________
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
     The following people contributed tricks to this guide:
¤ Leif    = Trick #6,16,17,28,29 under "Memory Consumption"
          = Trick #3,4,5 under "Useful Tricks"
¤ Jeff    = Trick #18 under "Memory Consumption"

Thanks again to all who contributed to the guide!


___________________________________________________________
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
IV.  CONTACT
___________________________________________________________
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Questions?  Comments?  E-mail me at: <ahz0123@mail.ecu.edu>
Visit Us! : <http://home.graffiti.net/fortress_productions>