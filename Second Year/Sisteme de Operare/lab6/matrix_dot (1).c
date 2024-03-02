#include <pthread.h>
#include <stdio.h>
#include <errno.h> 
#include <stdlib.h>
#include <string.h>

struct calculate_element_args {
  int i, j;
  double *A, *B;
  int P, M;
};
struct calculate_element_return_type {
  double answer;
};

void* calculate_element(void *args) {
  struct calculate_element_args *real_args = args;
  int i = real_args -> i, j = real_args -> j, P = real_args -> P, M = real_args -> M;
  double *A = real_args -> A, *B = real_args -> B;

  struct calculate_element_return_type *result = malloc(sizeof(struct calculate_element_return_type));
  result -> answer = 0;
  for (int k = 0; k < P; k++) {
    // A[i][k] * B[k][j]
    // A de NxP
    // B de PxM
    result -> answer += A[i * P + k] * B[k * M + j];
  }

  return result;
}

int main(int argc, char **argv) {
  FILE *in_file = fopen("matrix.in", "r");
  FILE *out_file = fopen("matrix.out", "w");

  if (!in_file || !out_file) {
    perror("Files does not exist!\n");
    return -1;
  }

  int N, P;
  fscanf(in_file, "%d%d", &N, &P);
  double *A = malloc(N * P * sizeof(double));
  for (int i = 0; i < N * P; i++) {
    fscanf(in_file, "%lf", &A[i]);
  }

  int Q, M;
  fscanf(in_file, "%d%d", &Q, &M);
  if (Q != P) {
    perror("Wrong dimenstions of the matricies!\n");
    return -1;
  }
  double *B = malloc(P * M * sizeof(double));
  for (int i = 0; i < P * M; i++) {
    fscanf(in_file, "%lf", &B[i]);
  }

  double *C = malloc(N * M * sizeof(double));
  memset(C, 0, sizeof(C));

  pthread_t workers[N * M];
  struct calculate_element_args args[N * M];
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < M; j++) {
      int id = i * M + j;
      args[id].i = i;
      args[id].j = j;
      args[id].P = P;
      args[id].A = A;
      args[id].B = B;
      args[id].M = M;

      if (pthread_create(&workers[i * M + j], NULL, calculate_element, &args[id])) {
        perror("Error while trying to create new thread!\n");
        return errno;
      }
    }
  }

  for (int i = 0; i < N; i++) {
    for (int j = 0; j < M; j++) {
      void *result = malloc(sizeof(struct calculate_element_return_type));
      if (pthread_join(workers[i * M + j], &result)) {
        perror("Error inside the thread!\n");
        return errno;
      }
      struct calculate_element_return_type *real_result = result;
      C[i * M + j] = real_result -> answer;
      free(result);
    }
  }

  fprintf(out_file, "%d %d\n", N, M);
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < M; j++) {
      fprintf(out_file, "%lf ", C[i * M + j]);
    }
    fprintf(out_file, "\n");
  }

  return 0;
}