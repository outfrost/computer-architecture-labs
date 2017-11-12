double calculateIntegralLegacyWay(double begin, double delta, int count) {
	double result = 0.0;
	for (int i = 0; i < count; i++) {
		double x = begin + i * delta;
		result += (1.0 - x*x) / x;
		x += delta;
		result += (1.0 - x*x) / x;
	}
	result *= delta;
	result /= 2.0;
	return result;
}
