.c.o:
	gcc -c $<

all: lib/libsub_A.dylib lib/libsub_B.dylib bin/main_A bin/main_B

lib/libsub_A.dylib: sub.o
	gcc -o $@ -shared sub.o -install_name "@loader_path/../lib/`basename $@`"

lib/libsub_B.dylib: sub.o
	gcc -o $@ -shared sub.o
	install_name_tool -id "@loader_path/../lib/`basename $@`" $@

bin/main_A: main.o
	gcc -L lib -o $@ main.o -lsub_A
	otool -L $@

bin/main_B: main.o
	gcc -L lib -o $@ main.o -lsub_B
	otool -L $@

clean:
	rm *.o lib/libsub* bin/main*
