#! /bin/bash

#BSUB -W 0:30
#BSUB -nnodes 1
#BSUB -J new-spmv
#BSUB -o new-spmv.o%J
#BSUB -e new-spmv.e%J

shopt -s extglob

ROOT=$HOME/pr-merge

source $ROOT/load-env.sh

date

echo "reals_small"
jsrun \
-n 1 \
-r 1 \
-a 1 \
-c ALL_CPUS \
-g 1 \
-l cpu-gpu \
-b rs \
"$ROOT"/build-vortex/kokkos-kernels/perf_test/sparse/sparse_kk_spmv_merge \
$HOME/suitesparse/reals_small/*.mtx