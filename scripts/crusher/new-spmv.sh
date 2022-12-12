#!/bin/bash
#SBATCH -N 1
#SBATCH -A csc465
#SBATCH -p batch
#SBATCH --time=03:00:00
#SBATCH -o new-smpv.o%j
#SBATCH -e new-smpv.e%j
#SBATCH -J new-spmv

shopt -s extglob

ROOT=$HOME/repos/pr-merge

source $ROOT/load-env.sh

date

echo "reals_med"
"$ROOT"/build-crusher/kokkos-kernels/perf_test/sparse/sparse_kk_spmv_merge \
$HOME/csc465/proj-shared/cpearson/suitesparse/reals_med/*.mtx

date