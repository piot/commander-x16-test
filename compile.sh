set -x
rm -f main.prg main.dbg main.fdb
ca65 main.s -g -o main.o -t cx16
ld65 -C cx16.cfg -o main.prg --dbgfile main.dbg main.o
