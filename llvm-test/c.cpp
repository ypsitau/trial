#include <stdarg.h>

void func(const char *format, ...)
{
	va_list list;
	va_start(list, format);
	int n = va_arg(list, int);
	va_end(list);
}
