#!/bin/bash
#SBATCH -N 1
#SBATCH -p blake
#SBATCH --time=02:00:00
#SBATCH -o new-smpv.o%j
#SBATCH -e new-smpv.e%j

shopt -s extglob

ROOT=$HOME/repos/pr-merge

source $ROOT/load-env.sh

export OMP_PROC_BIND=spread
export OMP_PLACES=threads
export OMP_DISPLAY_ENV="TRUE"

date

echo "reals_med"
"$ROOT"/build-blake/kokkos-kernels/perf_test/sparse/sparse_kk_spmv_merge \
$HOME/suitesparse/reals_med/*.mtx