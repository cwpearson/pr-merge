#!/bin/bash
#SBATCH -N 1
#SBATCH -A CSC465_crusher
#SBATCH -p batch
#SBATCH --time=04:00:00
#SBATCH -o kk-spmv.o%j
#SBATCH -e kk-spmv.e%j
#SBATCH -J kk-spmv

shopt -s extglob

ROOT=$HOME/repos/pr-merge

source $ROOT/load-env.sh

date

echo "reals_med"
"$ROOT"/build-crusher/kokkos-kernels/perf_test/sparse/KokkosKernels_spmv_benchmark \
$HOME/csc465/proj-shared/cpearson/suitesparse/reals_med/*.mtx \
--benchmark_filter="MatrixMarket.*f64/non-conj/.*native" \
--benchmark_format=csv

date
