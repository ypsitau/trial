main: main.o sub.o
	gcc -o $@ $+

main.o: main.c
	gcc -c $<

sub.o: sub.ll
	llc -filetype=obj sub.ll
