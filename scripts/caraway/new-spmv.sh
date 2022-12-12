#!/bin/bash
#SBATCH -N 1
#SBATCH -p MI250
#SBATCH --time=03:00:00
#SBATCH -o new-smpv.o%j
#SBATCH -e new-smpv.e%j

shopt -s extglob

ROOT=$HOME/repos/pr-merge

source $ROOT/load-env.sh

date

echo "reals_med"
"$ROOT"/build-caraway/kokkos-kernels/perf_test/sparse/sparse_kk_spmv_merge \
/home/projects/cwpears/suitesparse/reals_med/*.mtx

date