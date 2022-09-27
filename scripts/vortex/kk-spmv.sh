#! /bin/bash

#BSUB -W 4:00
#BSUB -nnodes 1
#BSUB -J kk-spmv
#BSUB -o kk-spmv.o%J
#BSUB -e kk-spmv.e%J

shopt -s extglob

ROOT=$HOME/repos/pr-merge

source $ROOT/load-env.sh

date
echo "reals_med"
echo "path,rows,nnz,us,GFLOPS,GB/s"
for m in $HOME/suitesparse/reals_med/*.mtx; do
#   "$ROOT"/build/kokkos-kernels/perf_test/sparse/sparse_spmv -t kk_kernels -f $m
  out=`jsrun \
-n 1 \
-r 1 \
-a 1 \
-g 1 \
-l gpu-cpu \
-c ALL_CPUS \
-M -disable_gpu_hooks \
-b rs \
"$ROOT"/build-vortex/kokkos-kernels/perf_test/sparse/sparse_spmv -t kk-kernels -f $m`
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