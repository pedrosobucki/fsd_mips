#include <stdlib.h>
#include <stdio.h>
#include <math.h>

void main() {
  int n = 6;

  // int a[6] = {810, 100, 560, 380, 600, 87};  // 2537 / 6 = 422
  // int b[6] = {800, 555, 817, 124, 890, 456}; // 3642 / 6 = 607
  // int c[6] = {345, 200, 700, 180, 600, 490}; // 2515 / 6 = 419

  int a[6] = {101, 900, 500, 34, 182, 910};   // 2627 / 6 = 437
  int b[6] = {60, 180, 912, 302, 291, 411};   // 2156 / 6 = 359
  int c[6] = {97, 714, 561, 700, 123, 712};   // 2907 / 6 = 484
  // d[9] = {101, 60, 97, 180, 34, 302, 182, 291, 123}

  int sum_a = 0;
  int sum_b = 0;
  int sum_c = 0;

  for (int i = 0; i < n; i++) {
    sum_a += a[i];
    sum_b += b[i];
    sum_c += c[i];
  }

  sum_a /= n;
  int min = sum_a;

  sum_b /= n;
  if (sum_b < min) min = sum_b;

  sum_c /= n;
  if (sum_c < min) min = sum_c;

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


  printf("A: %d\nB: %d\nC: %d\nmin: %d\nk: %d\n", sum_a, sum_b, sum_c, min, k);
}