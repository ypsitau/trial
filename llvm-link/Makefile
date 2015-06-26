main: main.o sub.o
	g++ -o $@ $+

main.o: main.cpp
	g++ -c $<

sub.o: sub.ll
	~/tools/clang/bin/llc -filetype=obj sub.ll
