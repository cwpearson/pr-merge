#!/bin/bash
#SBATCH -N 1
#SBATCH -A csc465
#SBATCH -p batch
#SBATCH --time=02:00:00
#SBATCH -o kk-smpv.o%j
#SBATCH -e kk-smpv.e%j
#SBATCH -J kk-spmv

shopt -s extglob

ROOT=$HOME/repos/pr-merge

source $ROOT/load-env.sh

date

echo "reals_med"
echo "path,rows,nnz,us,GFLOPS,GB/s"
for m in $HOME/csc465/proj-shared/cpearson/suitesparse/reals_med/*.mtx; do
#   "$ROOT"/build-crusher/kokkos-kernels/perf_test/sparse/sparse_spmv -t kk_kernels -f $m
  out=`"$ROOT"/build-crusher/kokkos-kernels/perf_test/sparse/sparse_spmv -t kk-kernels -f $m`
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