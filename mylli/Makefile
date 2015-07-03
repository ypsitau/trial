mylli: mylli.o
	g++ -o $@ `~/tools/clang/bin/llvm-config --ldflags --system-libs --libs` $+

mylli.o: mylli.cpp
	g++ `~/tools/clang/bin/llvm-config --cxxflags` -c $<
