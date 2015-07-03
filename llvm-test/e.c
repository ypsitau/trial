typedef struct {
	int x, y;
	int a, b, c, d, e, f, g;
} Point;

Point func(int x, int y)
{
	Point pt;
	pt.x = x, pt.y = y;
	return pt;
}
