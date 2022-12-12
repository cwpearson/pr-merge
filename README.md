- Kokkos: `develop`
- Kokkos Kernels: `feature/merge-path`

OpenMP run on Vortex
```bash
jsrun -n1 -c 44 -g 1 -b rs -M -disable_gpu_hooks kokkos-kernels/perf_test/sparse/sparse_kk_spmv_merge ~/suitesparse/kind_undirected_graph/pdb1HYS.mtx
```


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
-DKokkos_ARCH_VOLTA70=On \
-DKokkosKernels_INST_MEMSPACE_CUDAUVMSPACE=OFF \
-DKokkosKernels_ENABLE_TPL_CUSPARSE=OFF
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
-DKokkos_ENABLE_TESTS=ON \
-DKokkos_ENABLE_OPENMP=ON \
-DKokkos_ARCH_POWER9=On \
-DCMAKE_BUILD_TYPE=Release \
-DKokkos_ENABLE_HWLOC=Off \
-DKokkosKernels_INST_COMPLEX_FLOAT=OFF \
-DKokkosKernels_INST_DOUBLE=ON \
-DKokkosKernels_INST_FLOAT=ON \
-DKokkosKernels_INST_HALF=OFF \
-DKokkosKernels_INST_OFFSET_INT=OFF \
-DKokkosKernels_INST_OFFSET_SIZE_T=ON \
-DKokkosKernels_INST_LAYOUTRIGHT=OFF \
-DKokkosKernels_ENABLE_TESTS=ON \
-DCMAKE_CXX_FLAGS="-Wall -Wshadow -pedantic -Werror -Wsign-compare -Wtype-limits -Wignored-qualifiers -Wempty-body -Wuninitialized" \
-DCMAKE_CXX_COMPILER=${NVCC_WRAPPER} \
-DKokkos_ENABLE_CUDA=ON \
-DKokkos_ENABLE_CUDA_LAMBDA=On \
-DKokkos_ARCH_VOLTA70=On \
-DKokkosKernels_INST_MEMSPACE_CUDAUVMSPACE=OFF \
-DKokkosKernels_ENABLE_TPL_CUSPARSE=OFF \
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