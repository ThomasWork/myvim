#include <stdio.h>

typedef struct {
	int id;
	int age;
};

int getSum(int num1, int num2) {
	return num1 + num2;
}

int getSum2(int num2, int num3) {
	return 0;
}

int main() {
	int i, j, k;
	for (i = 0; i < 10; i++) {
		printf("%d, ", i);
	}
	printf("\n");
	return 0;
}
