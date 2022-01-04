#include <stdio.h>
#include <stdlib.h>

int main(void) {
  int a, max = -1;
  scanf("%d", &a);

  for (int i = 0; i < a; i++) {
    int b;
    scanf("%d\n", &b);
    if (max < b) {
      max = b;
    }
  }
  
  printf("%d\n", max);
}
