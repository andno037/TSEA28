#!/bin/sh

/site/edu/da/sw/c6/bin/m68k-as -M -m68000 -al -o tmp.o ./$1 >./$1.lst
/site/edu/da/sw/c6/bin/m68k-ld --entry=1000 --oformat=coff-m68k -Ttext=1000 ./tmp.o

mv a.out ~
