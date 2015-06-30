mylli: mylli.o
	g++ -o $@ `~/tools/clang/bin/llvm-config --ldflags --libs` $+ -lcurses -lz

mylli.o: mylli.cpp
	g++ `~/tools/clang/bin/llvm-config --cxxflags` -c $<
