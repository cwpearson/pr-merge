#!/bin/bash

ROOT=$HOME/repos/pr-merge
GENERATED_DIR=$ROOT/scripts/crusher/generated

for d in $HOME/csc465/proj-shared/cpearson/suitesparse/*; do

  # skip any dir that is not a suitesparse kind
  if [[ ! $d =~ kind_ ]]; then
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
#SBATCH -A CSC465_crusher
#SBATCH -p batch
#SBATCH --time=00:30:00
#SBATCH -o new-spmv-$kind.o%j
#SBATCH -e new-spmv-$kind.e%j
#SBATCH -J new-spmv-$kind

shopt -s extglob

source $ROOT/load-env.sh

date

echo "$kind"

$ROOT/build-crusher/kokkos-kernels/perf_test/sparse/KokkosKernels_spmv_benchmark \
$HOME/csc465/proj-shared/cpearson/suitesparse/$kind/*.mtx \
--benchmark_filter="MatrixMarket.*/i32/f64/i32/non-conj/.*merge" \
--benchmark_format=csv

date
EOM

  sbatch $script

done
