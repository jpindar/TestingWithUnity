#include <stdio.h>
#include "library.h"
#include "constants.h"

int main(int argc, char **argv)
{
  printf("hello world\n");
  int c = 5;
  int d = 6;
  printf("%d + %d = %d\n", c, d, add(c, d));
  printf("FOO = %d\n", FOO);
}
