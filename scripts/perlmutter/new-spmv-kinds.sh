#!/bin/bash

ROOT=/global/homes/p/pearson/repos/pr-merge
GENERATED_DIR=$ROOT/scripts/perlmutter/generated

for d in $HOME/cfs_m3918/pearson/*; do

  # skip suitesparse dir
  if [[ $d =~ suitesparse$ ]]; then
    continue
  elif [[ $d =~ glusa$ ]]; then
    continue
  elif [[ $d =~ reals ]]; then
    continue
  elif [[ $d =~ sisu ]]; then
    continue
  fi

  echo $d;
  kind=$(basename $d)
  script="$GENERATED_DIR/new-spmv-$kind.sh"

  # make a script
  mkdir -p $GENERATED_DIR
  cat > "$script" <<- EOM
#!/bin/bash
#SBATCH -N 1
#SBATCH --constraint gpu
#SBATCH --gpus-per-node 1
#SBATCH -A m3918_g
#SBATCH -q regular
#SBATCH --time=04:00:00
#SBATCH -J new-spmv-$kind
#SBATCH -e new-spmv-$kind.e%j
#SBATCH -o new-spmv-$kind.o%j

shopt -s extglob

source $ROOT/load-env.sh

date

echo "$kind"

$ROOT/build-perlmutter/kokkos-kernels/perf_test/sparse/KokkosKernels_spmv_benchmark \
$HOME/cfs_m3918/pearson/$kind/*.mtx \
--benchmark_filter="MatrixMarket.*/i64/f64/u64/non-conj/.*hierarchical" \
--benchmark_format=csv

date
EOM

  sbatch $script

done
