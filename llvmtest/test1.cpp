#include <stdio.h>

struct Value {
	int a, b, c;
	char buff[128];
};

Value sub()
{
	Value v;
	v.a = v.b = v.c = 3;
	return v;
}

int main(int argc, char *argv[])
{
	Value v = sub();
	printf("Hello world!!\n");
	return 2;
}
