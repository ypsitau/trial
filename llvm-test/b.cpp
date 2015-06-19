class A {
private:
	int _x;
public:
	A(int x) : _x(x) {}
	void func() {}
};

void sub()
{
	A a(3);
	a.func();
}
