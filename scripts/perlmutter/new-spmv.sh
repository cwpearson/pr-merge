#!/bin/bash
#SBATCH -N 1
#SBATCH --constraint gpu
#SBATCH --gpus-per-node 1
#SBATCH -A m3918_g
#SBATCH -q regular
#SBATCH --time=04:00:00
#SBATCH -J new-spmv
#SBATCH -e new-spmv.e%j
#SBATCH -o new-spmv.o%j

shopt -s extglob

ROOT=/global/homes/p/pearson/repos/pr-merge

source $ROOT/load-env.sh

date

echo "reals_med"

$ROOT/build-perlmutter/kokkos-kernels/perf_test/sparse/KokkosKernels_spmv_benchmark \
$HOME/cfs_m3918/pearson/suitesparse/reals_med/*.mtx \
--benchmark_filter="MatrixMarket.*/i64/f64/u64/non-conj/.*hierarchical" \
--benchmark_format=csv

date
