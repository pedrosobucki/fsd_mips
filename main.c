#include <stdlib.h>
#include <stdio.h>
#include <math.h>

void main() {
  int n = 6;

  // int a[6] = {1, 2, 3, 4, 5, 6};  // 21 / 6 = 3
  // int b[6] = {14, 75, 0, 1, 45, 9}; // 144 / 6 = 24
  // int c[6] = {1, 3, 5, 7, 9, 11}; // 36 / 6 = 6

  int a[6] = {810, 100, 560, 380, 600, 87};  // 2537 / 6 = 422
  int b[6] = {800, 555, 817, 124, 890, 456}; // 3642 / 6 = 607
  int c[6] = {345, 200, 700, 180, 600, 490}; // 2515 / 6 = 419

  int sum[3] = {0, 0, 0};

  for (int i = 0; i < n; i++) {
    sum[0] += a[i];
    sum[1] += b[i];
    sum[2] += c[i];
  }

  sum[0] /= n;
  int min = sum[0];

  for (int i = 1; i < 3; i++) {
    sum[i] /= n;
    if (sum[i] < min) min = sum[i];
  }

  int temp_d[18];
  int k = 0;

  for (int i; i < n; i++) {
    if (a[i] < min) {
      temp_d[k] = a[i];
      k++;
    }

    if (b[i] < min) {
      temp_d[k] = b[i];
      k++;
    }

    if (c[i] < min) {
      temp_d[k] = c[i];
      k++;
    }
  }

  int d[k];
  for (int i = 0; i < k; i++) {
    d[i] = temp_d[i];
  }

  printf("---------\nD:\n");
  for (int i = 0; i < k; i++) {
    printf("%d\n", d[i]);
  }
  printf("------------\n");


  printf("A: %d\nB: %d\nC: %d\nmin: %d\nk: %d\n", sum[0], sum[1], sum[2], min, k);
}