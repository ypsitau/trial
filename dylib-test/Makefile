.c.o:
	gcc -c $<

all: libsub.dylib main

libsub.dylib: sub.o
	gcc -o libsub.dylib -shared sub.o

main: main.o
	gcc -L . -o main main.o -lsub
