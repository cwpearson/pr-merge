#!/bin/bash
#SBATCH -N 1
#SBATCH --constraint gpu
#SBATCH --gpus-per-node 1
#SBATCH -A m3918_g
#SBATCH -q regular
#SBATCH --time=02:00:00
#SBATCH -J kk-spmv
#SBATCH -e new-spmv.e%j
#SBATCH -o new-spmv.o%j

shopt -s extglob

ROOT=$HOME/repos/pr-merge

source $ROOT/load-env.sh

date

echo "reals_med"
echo "path,rows,nnz,us,GFLOPS,GB/s"
for m in $HOME/cfs_m3918/pearson/suitesparse/reals_med/*.mtx; do
#   "$ROOT"/build-perlmutter/kokkos-kernels/perf_test/sparse/sparse_spmv -t kk_kernels -f $m
  out=`"$ROOT"/build-perlmutter/kokkos-kernels/perf_test/sparse/sparse_spmv -t kk-kernels -f $m`
  out=$(echo "$out" | head -n3 | tail -n1)
  nnz=$(echo $out | tr -s ' ' | cut -d' ' -f1)
  nr=$(echo $out | tr -s ' ' | cut -d' ' -f2)
  avgBw=$(echo "$out" | tr -s ' ' | cut -d' ' -f6)
  avgGf=$(echo "$out" | tr -s ' ' | cut -d' ' -f11)
  avgMs=$(echo "$out" | tr -s ' ' | cut -d' ' -f16)
  avgUs=$(echo $avgMs*1000 | bc)
  echo $m,$nr,$nnz,$avgUs,$avgGf,$avgBw
done

date