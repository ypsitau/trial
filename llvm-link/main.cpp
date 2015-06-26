#include <stdio.h>

extern "C" {
int add2(int a, int b);
void hello(int n);
void foo();
}

extern "C" void func(const char *str)
{
	::printf("string .. %s\n", str);
}

int main()
{
	::printf("%d\n", add2(3, 4));
	hello(3);
	foo();
	return 0;
}
