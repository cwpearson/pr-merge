#!/bin/bash
#SBATCH -N 1
#SBATCH --constraint gpu
#SBATCH --gpus-per-node 1
#SBATCH -A m3918_g
#SBATCH -q regular
#SBATCH --time=04:00:00
#SBATCH -J cusparse-spmv
#SBATCH -e cusparse-spmv.e%j
#SBATCH -o cusparse-spmv.o%j

shopt -s extglob

ROOT=/global/homes/p/pearson/repos/pr-merge

source $ROOT/load-env.sh

date

echo "reals_med"

$ROOT/build-perlmutter/kokkos-kernels/perf_test/sparse/KokkosKernels_spmv_benchmark \
$HOME/cfs_m3918/pearson/suitesparse/reals_med/*.mtx \
--benchmark_filter="MatrixMarket.*f64.*default" \
--benchmark_format=csv

date
