llvm-gen: llvm-gen.o
	g++ -o $@ `~/tools/clang/bin/llvm-config --ldflags --libs` $+ -lcurses

llvm-gen.o: llvm-gen.cpp
	g++ `~/tools/clang/bin/llvm-config --cxxflags` -c $<
