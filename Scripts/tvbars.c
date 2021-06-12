#include <stdio.h>

int main() {

  printf("\n");

  int i = 0;
  char *reset = "\e[0m";
  while (i < 14) {   
    int colors[] = { 7, 3, 6, 2, 5, 1, 4 };
    printf("           ");
    
    int j = 0;
    while (j < 7) {
      printf("\e[4%dm", colors[j]);
      printf("        ");
      j++;
    }

    printf("%s\n", reset);
    i++;
  }
  
  i = 0;
  while (i < 2) {
    int colors[] = {4,0,5,0,6,0,7};
    printf("           ");
    
    int j = 0;
    while (j < 7) {
      printf("\e[4%dm", colors[j]);
      printf("        ");
      j++;
    }

    printf("\e[0m\n");
    i++;
  }

  i = 0;
  while (i < 5) {
    printf("           ");
    int colors[] = {4,4,4,4,4,7,7,7,7,7,5,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,0,0};
    
    int j = 0;
    while(j < 28) {
      printf("\e[4%dm", colors[j]);
      printf("  ");
      j++;
    }

    printf("\e[0m\n");
    i++;
  }

}
