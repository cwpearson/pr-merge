- Kokkos: `develop`
- Kokkos Kernels: `feature/merge-path`

## Vortex

```
m KokkosKernels_common_cuda KokkosKernels_graph_cuda

jsrun -n1 -c 44 -g 1 -b rs -M -disable_gpu_hooks kokkos-kernels/graph/unit_test/KokkosKernels_graph_cuda --gtest_filter="*merge*"

jsrun -n1 -c 44 -g 1 -b rs -M -disable_gpu_hooks kokkos-kernels/graph/unit_test/KokkosKernels_graph_cuda --gtest_filter="*load_balance*"

jsrun -n1 -c 44 -g 1 -b rs -M -disable_gpu_hooks kokkos-kernels/common/unit_test/KokkosKernels_common_cuda --gtest_filter="*lower_bound*"
```
OpenMP run on Vortex
```bash
jsrun -n1 -c 44 -g 1 -b rs -M -disable_gpu_hooks kokkos-kernels/perf_test/sparse/sparse_kk_spmv_merge ~/suitesparse/kind_undirected_graph/pdb1HYS.mtx
```


CUDA
```bash
source ../load-env.sh
cmake .. \
-DCMAKE_CXX_COMPILER=${CC} \
-DCMAKE_BUILD_TYPE=Release \
-DKokkos_ENABLE_HWLOC=Off \
-DKokkosKernels_INST_COMPLEX_FLOAT=ON \
-DKokkosKernels_INST_DOUBLE=ON \
-DKokkosKernels_INST_FLOAT=ON \
-DKokkosKernels_INST_HALF=OFF \
-DKokkosKernels_INST_OFFSET_INT=ON \
-DKokkosKernels_INST_OFFSET_SIZE_T=ON \
-DKokkosKernels_ENABLE_TESTS=ON \
-DKokkos_ENABLE_CUDA=ON \
-DKokkos_ENABLE_CUDA_LAMBDA=On \
-DKokkos_ARCH_VOLTA70=On \
-DKokkosKernels_INST_MEMSPACE_CUDAUVMSPACE=OFF \
-DKokkosKernels_ENABLE_TPL_CUSPARSE=OFF \
-DKokkosKernels_ENABLE_GRAPH=ON
```

OpenMP
```bash
source ../load-env.sh
cmake .. \
-DKokkos_ENABLE_OPENMP=ON \
-DKokkos_ARCH_POWER9=On \
-DCMAKE_BUILD_TYPE=Release \
-DKokkos_ENABLE_HWLOC=Off \
-DKokkosKernels_INST_COMPLEX_FLOAT=ON \
-DKokkosKernels_INST_DOUBLE=ON \
-DKokkosKernels_INST_FLOAT=OFF \
-DKokkosKernels_INST_HALF=OFF \
-DKokkosKernels_INST_OFFSET_INT=OFF \
-DKokkosKernels_INST_OFFSET_SIZE_T=ON \
-DKokkosKernels_INST_LAYOUTRIGHT=ON \
-DKokkosKernels_INST_LAYOUTLEFT=ON \
-DKokkosKernels_ENABLE_TESTS=ON
```

OpenMP + CUDA
```bash
source ../load-env.sh
cmake .. \
-DCMAKE_CXX_COMPILER=${NVCC_WRAPPER} \
-DCMAKE_CXX_FLAGS="-Wall -Wshadow -pedantic -Werror -Wsign-compare -Wtype-limits -Wignored-qualifiers -Wempty-body -Wuninitialized -Wunused-local-typedefs" \
-DKokkos_ENABLE_TESTS=OFF \
-DKokkos_ENABLE_OPENMP=ON \
-DKokkos_ARCH_POWER9=On \
-DCMAKE_BUILD_TYPE=Release \
-DKokkosKernels_INST_COMPLEX_FLOAT=OFF \
-DKokkosKernels_INST_DOUBLE=OFF \
-DKokkosKernels_INST_FLOAT=OFF \
-DKokkosKernels_INST_HALF=OFF \
-DKokkosKernels_INST_OFFSET_INT=OFF \
-DKokkosKernels_INST_OFFSET_SIZE_T=OFF \
-DKokkosKernels_INST_LAYOUTRIGHT=OFF \
-DKokkosKernels_ENABLE_TESTS=ON \
-DKokkos_ENABLE_CUDA=ON \
-DKokkos_ENABLE_CUDA_LAMBDA=On \
-DKokkos_ARCH_VOLTA70=On \
-DKokkosKernels_INST_MEMSPACE_CUDAUVMSPACE=OFF \
-DKokkosKernels_ENABLE_TPL_CUSPARSE=OFF
```


## kokkos-dev-2

```
m \
KokkosKernels_common_cuda \
KokkosKernels_common_openmp \
KokkosKernels_graph_cuda \
KokkosKernels_graph_openmp \
KokkosGraph_loadbalance_perf_test \
KokkosGraph_merge_perf_test \
sparse_kk_spmv_merge \
sparse_kk_spmv

m KokkosKernels_graph_cuda && kokkos-kernels/graph/unit_test/KokkosKernels_graph_cuda --gtest_filter="*load_balance*"

kokkos-kernels/graph/unit_test/KokkosKernels_graph_cuda --gtest_filter="*merge*"

kokkos-kernels/common/unit_test/KokkosKernels_common_cuda --gtest_filter="*bound*"

m KokkosGraph_loadbalance_perf_test && kokkos-kernels/perf_test/graph/KokkosGraph_loadbalance_perf_test
```

OpenMP + CUDA
```bash
source ../load-env.sh
cmake .. \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_CXX_COMPILER=${NVCC_WRAPPER} \
-DCMAKE_CXX_FLAGS="-Wall -Wshadow -pedantic -Werror -Wsign-compare -Wtype-limits -Wignored-qualifiers -Wempty-body -Wuninitialized -Wunused-local-typedefs" \
-DKokkos_ENABLE_OPENMP=ON \
-DKokkos_ENABLE_SERIAL=OFF \
-DKokkos_ARCH_SKX=ON \
-DKokkos_ENABLE_CUDA=ON \
-DKokkos_ENABLE_CUDA_LAMBDA=On \
-DKokkos_ARCH_VOLTA70=ON \
-DKokkosKernels_ENABLE_TESTS=ON \
-DKokkosKernels_ENABLE_TPL_CUSPARSE=OFF
```

Serial
```bash
source ../load-env.sh
cmake .. \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_CXX_COMPILER=g++ \
-DCMAKE_CXX_FLAGS="-Wall -Wshadow -pedantic -Werror -Wsign-compare -Wtype-limits -Wignored-qualifiers -Wempty-body -Wuninitialized -Wunused-local-typedefs" \
-DKokkos_ENABLE_SERIAL=ON \
-DKokkos_ARCH_SKX=ON \
-DKokkosKernels_ENABLE_TESTS=ON \
-DKokkosKernels_ENABLE_TPL_CUSPARSE=OFF
```

## Attaway

OpenMP
```bash
source ../load-env.sh
cmake .. \
-DKokkos_ENABLE_OPENMP=ON \
-DCMAKE_BUILD_TYPE=Release \
-DKokkos_ENABLE_HWLOC=Off \
-DKokkosKernels_INST_COMPLEX_FLOAT=ON \
-DKokkosKernels_INST_DOUBLE=ON \
-DKokkosKernels_INST_FLOAT=OFF \
-DKokkosKernels_INST_HALF=OFF \
-DKokkosKernels_INST_OFFSET_INT=OFF \
-DKokkosKernels_INST_OFFSET_SIZE_T=ON \
-DKokkosKernels_INST_LAYOUTRIGHT=ON \
-DKokkosKernels_INST_LAYOUTLEFT=ON \
-DKokkosKernels_ENABLE_TESTS=ON
```

WCIDs: `FY210059`: this is Sake/PEEK

Interactive:
```bash
salloc --nodes=1 --ntaskts-per-node=36 --time=4:00:00 --account=PUT_YOUR_WCID_HERE
```

## Blake

OpenMP
```bash
source ../load-env.sh
cmake .. \
-DKokkos_ENABLE_OPENMP=ON \
-DKokkos_ARCH_SKX=ON \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_CXX_FLAGS="-g" \
-DKokkos_ENABLE_HWLOC=Off \
-DKokkosKernels_INST_COMPLEX_FLOAT=ON \
-DKokkosKernels_INST_DOUBLE=ON \
-DKokkosKernels_INST_FLOAT=OFF \
-DKokkosKernels_INST_HALF=OFF \
-DKokkosKernels_INST_OFFSET_INT=OFF \
-DKokkosKernels_INST_OFFSET_SIZE_T=ON \
-DKokkosKernels_INST_LAYOUTRIGHT=ON \
-DKokkosKernels_INST_LAYOUTLEFT=ON \
-DKokkosKernels_ENABLE_TESTS=ON

m sparse_kk_spmv_merge sparse_spmv KokkosKernels_graph_openmp
```

Interactive:
```bash
salloc -N 1 --time=02:00:00 
```

batch
```
sbatch new-spmv.sh
```

jobs
```
squeue
```

## Caraway

Caraway has a few different kinds of nodes: `sinfo parition`


`VEGA908` for MI100
`VEGA90A` for MI200
HIP+Serial
```bash
source ../load-env.sh
cmake .. \
-DCMAKE_BUILD_TYPE=Release \
-DKokkosKernels_INST_COMPLEX_FLOAT=ON \
-DKokkosKernels_INST_DOUBLE=ON \
-DKokkosKernels_INST_FLOAT=ON \
-DKokkosKernels_INST_OFFSET_SIZE_T=ON \
-DKokkosKernels_ENABLE_TESTS=ON \
-DKokkos_ENABLE_HIP=ON \
-DKokkos_ARCH_VEGA90A=ON \
-DKokkosKernels_ENABLE_TPL_ROCSPARSE=OFF

m sparse_kk_spmv_merge sparse_spmv
```

Interactive:
```bash
salloc -N 1 -p MI100 --time=00:30:00 
```

batch
```
sbatch new-spmv.sh
```

jobs
```
squeue
```

### A100 on caraway

```
source $HOME/spack-caraway/spack/share/spack/setup-env.sh
spack load cuda
module load cmake
export NVCC_WRAPPER=`readlink -f ../kokkos/bin/nvcc_wrapper`
cmake .. \
-DCMAKE_CXX_COMPILER=${NVCC_WRAPPER} \
-DCMAKE_BUILD_TYPE=Release \
-DKokkos_ENABLE_CUDA=ON \
-DKokkos_ENABLE_CUDA_LAMBDA=On \
-DKokkos_ARCH_AMPERE80=On \
-DKokkosKernels_INST_MEMSPACE_CUDAUVMSPACE=OFF \
-DKokkosKernels_ENABLE_TPL_CUSPARSE=OFF \
-DKokkosKernels_ENABLE_TESTS=ON
m sparse_kk_spmv_merge sparse_spmv
```

## Perlmutter

CUDA
```bash
source ../load-env.sh
cmake .. \
-DCMAKE_CXX_COMPILER=${NVCC_WRAPPER} \
-DCMAKE_BUILD_TYPE=Release \
-DKokkos_ENABLE_HWLOC=Off \
-DKokkosKernels_INST_COMPLEX_FLOAT=ON \
-DKokkosKernels_INST_DOUBLE=ON \
-DKokkosKernels_INST_FLOAT=ON \
-DKokkosKernels_INST_HALF=OFF \
-DKokkosKernels_INST_OFFSET_INT=ON \
-DKokkosKernels_INST_OFFSET_SIZE_T=ON \
-DKokkosKernels_INST_LAYOUTRIGHT=ON \
-DKokkosKernels_ENABLE_TESTS=ON \
-DKokkos_ENABLE_CUDA=ON \
-DKokkos_ENABLE_CUDA_LAMBDA=On \
-DKokkos_ARCH_AMPERE80=On \
-DKokkosKernels_INST_MEMSPACE_CUDAUVMSPACE=OFF \
-DKokkosKernels_ENABLE_TPL_CUSPARSE=OFF
```

```
m sparse_kk_spmv_merge sparse_spmv KokkosKernels_graph_openmp
```

```
salloc --nodes 1 --qos interactive --time 01:00:00 --constraint gpu --gpus 4 --account=m3918_g
```

```
sqs
```

## Crusher

salloc -A csc465 -J interactive -t 01:00:00 -p batch -N 1

`VEGA90A` for MI200
HIP+Serial
```bash
source ../load-env.sh
cmake .. \
-DCMAKE_CXX_COMPILER=hipcc \
-DCMAKE_BUILD_TYPE=Release \
-DKokkosKernels_ENABLE_TESTS=ON \
-DKokkos_ENABLE_HIP=ON \
-DKokkos_ARCH_VEGA90A=ON \
-DKokkos_ARCH_ZEN3=ON \
-DKokkosKernels_ENABLE_TPL_ROCSPARSE=OFF

m sparse_kk_spmv_merge sparse_spmv
```

### profiling

kernels called, time
```
rocprof --stats --timestamp on kokkos-kernels/perf_test/sparse/sparse_kk_spmv_merge ~/csc465/proj-shared/cpearson/suitesparse/reals_med/2cubes_sphere.mtx
```

```
  gpu-agent0 : TCC_HIT[0-31] : Number of cache hits.
      block TCC has 4 counters

  gpu-agent0 : TCC_MISS[0-31] : Number of cache misses. UC reads count as misses.
      block TCC has 4 counters
gpu-agent0 : SQ_LDS_BANK_CONFLICT : Number of cycles LDS is stalled by bank conflicts. (emulated)
      block SQ has 8 counters
  gpu-agent0 : SQ_INSTS_LDS : Number of LDS instructions issued (including FLAT). (per-simd, emulated)
      block SQ has 8 counters

  gpu-agent0 : SQ_INSTS_GDS : Number of GDS instructions issued. (per-simd, emulated)
      block SQ has 8 counters

  gpu-agent0 : SQ_WAIT_INST_LDS : Number of wave-cycles spent waiting for LDS instruction issue. In units of 4 cycles. (per-simd, nondeterministic)
      block SQ has 8 counters
```

```
gpu-agent0 : TCC_HIT_sum : Number of cache hits. Sum over TCC instances.
      TCC_HIT_sum = sum(TCC_HIT,32)

  gpu-agent0 : TCC_MISS_sum : Number of cache misses. Sum over TCC instances.
      TCC_MISS_sum = sum(TCC_MISS,32)
```
- Glossary
  - TCC:
  - GDS: global data share, globally-shared explicitly-addressed memory

Atomics are generally classified as write requests


## rzvernal

* using CC instead of hipcc causes the compiler to crash

`VEGA90A` for MI250x
HIP+Serial
```bash
source ../load-env.sh
cmake .. \
-DCMAKE_CXX_COMPILER=hipcc \
-DCMAKE_BUILD_TYPE=Release \
-DKokkosKernels_INST_COMPLEX_FLOAT=ON \
-DKokkosKernels_INST_DOUBLE=ON \
-DKokkosKernels_INST_FLOAT=ON \
-DKokkosKernels_INST_HALF=OFF \
-DKokkosKernels_INST_OFFSET_INT=ON \
-DKokkosKernels_INST_OFFSET_SIZE_T=ON \
-DKokkosKernels_ENABLE_TESTS=ON \
-DKokkos_ENABLE_HIP=ON \
-DKokkos_ARCH_VEGA90A=ON \
-DKokkosKernels_ENABLE_TPL_ROCSPARSE=OFF
```

```bash
m sparse_kk_spmv_merge sparse_spmv KokkosKernels_graph_hip
```

```bash
salloc -G 1
srun -n 1 -G 1 -c 2 kokkos-kernels/perf_test/sparse/sparse_kk_spmv_merge ~/suitesparse/reals_med/apache1.mtx
```