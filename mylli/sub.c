void puts_ex(const char *str);

int func()
{
	int i;
	for (i = 0; i < 10; i++) {
		puts_ex("hoge");
	}
	return 0;
}
