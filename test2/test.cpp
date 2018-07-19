#include <stdio.h>

double sub1(bool a, double b)
{
	return a * b;
}

double sub2(bool a, double b)
{
	return a? b : 0;
}

int main()
{
	for (int i = 0; i < 10; i++) {
		::printf("%f\n", sub1(i % 2 == 0, i));
		::printf("%f\n", sub2(i % 2 == 0, i));
	}
	return 0;
}
