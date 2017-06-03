#include <stdio.h>
#include <stdbool.h>
#include <time.h>
#define EXIT_SUCCESS 0

void printArray(int *a, int len, int pieces, bool *b) {
  int i;
  for (i = 0; i < len; i++){
    if (!b[i])
      fprintf(stdout, "%d ", a[i]);
    else
      fprintf(stdout, "%d | ", a[i]);   // add separator
  }
}

unsigned long long int arraySum(int *a, int len) {
  int i;
  unsigned long long sum = 0;
  for (i = 0; i < len; i++)
    sum += a[i];
  return sum;
}

int maxElement(int *a, int len) {  // finds array's maximum
  int i, max;
  max = a[0];
  for (i = 1; i < len; i++)
    if (a[i] > max) max = a[i];
  return max;
}

int minElement(int* a, int len) {  // finds array's minimum
  int i, min;
  min = a[0];
  for (i = 1; i < len; i++)
    if (a[i] < min) min = a[i];
  return min;
}

bool checkSolution(int *a, int len, unsigned long long int solution, int pieces, bool *b) {
  int i = len - 1, j; // last array element
  int pcs = 1; // pieces in which the field is divided. obvs init with 1
  unsigned long long int sum = 0;
  bool error = false;
  while ((i >= 0) && (pcs <= pieces)) {
    if (sum + a[i] <= solution) {
      sum += a[i];
      error = false;
      i--;
    }
    else {
      error = true;
      sum = 0;
      pcs++;
      b[i] = true;
    }
  }
  if (!error) {  // then we have less pieces than expected and we can add more separators, starting from the left !
    for (j = 0; pcs < pieces; j++) {
      if (!b[j]) pcs++; // ONLY when there is not another separator at the same place should it be increased
      b[j] = true;
    }
  }
  if ((pcs < pieces) || (!error)) return true;
  for (i = 0; i < len; i++) b[i] = false;  // if false then erase all separators
  return false;
}

int main(int argc, char const *argv[]) {
  int i, input_size, num_of_fields, lower_bound,  arr[42000];
  unsigned long long int upper_bound, ub, lb, min_max;
  bool separators[42000], final_sep[42000];

  FILE *f = fopen(argv[1], "r");
  fscanf(f, "%d %d\n", &input_size, &num_of_fields);
  for (i = 0; i < input_size; i++) {
    fscanf(f, "%d ", &(arr[i]));
    separators[i] = false;
    final_sep[i]  = false;
  }
  fclose(f);

		// now we have all the data we need

  lower_bound = maxElement(arr, input_size); lb = lower_bound; // it can be increased
  upper_bound = arraySum(arr, input_size);   ub = upper_bound; // it can be reduced

  while (ub != lb) { // binary search in [lower, upper] for the minimum max of sums
    if (ub - lb > 1) min_max = (lb + ub) / 2;
    else {  // case where they get too close, so it can exit the loop !
      min_max = lb;
      ub = lb;
    }
    for (i = 0; i < input_size; i++) separators[i] = false;
    if (checkSolution(arr, input_size, min_max, num_of_fields, separators)) {  // then try with a smaller number
      ub = min_max;
      for (i = 0; i < input_size; i++) final_sep[i] = false || separators[i];
    }
    else lb = min_max;
  }
  printArray(arr, input_size, num_of_fields, final_sep); // prints the separators where it should
  return EXIT_SUCCESS;
}
