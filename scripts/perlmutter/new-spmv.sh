#!/bin/bash
#SBATCH -N 1
#SBATCH --constraint gpu
#SBATCH --gpus-per-node 1
#SBATCH -A m3918_g
#SBATCH -q regular
#SBATCH --time=03:00:00
#SBATCH -J kk-spmv

shopt -s extglob

ROOT=$HOME/repos/pr-merge

source $ROOT/load-env.sh

date

echo "reals_med"
"$ROOT"/build-perlmutter/kokkos-kernels/perf_test/sparse/sparse_kk_spmv_merge \
$HOME/cfs_m3918/pearson/suitesparse/reals_med/*.mtx

date