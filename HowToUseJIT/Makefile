HowToUseJIT: HowToUseJIT.o
	g++ -o $@ `~/tools/clang/bin/llvm-config --ldflags --libs` $+ -lcurses -lz

HowToUseJIT.o: HowToUseJIT.cpp
	g++ `~/tools/clang/bin/llvm-config --cxxflags` -c $<
