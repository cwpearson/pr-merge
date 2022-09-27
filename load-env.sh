#! /bin/bash

host=`hostname`

echo `dirname $BASH_SOURCE`
DIR=`dirname ${BASH_SOURCE}`

KOKKOS_SRC="$DIR/kokkos"
KERNELS_SRC="$DIR/kokkos-kernels"
KOKKOS_BUILD="$DIR/kokkos"
KERNELS_BUILD="$DIR/kokkos"
NVCC_WRAPPER=`readlink -f "${KOKKOS_SRC}/bin/nvcc_wrapper"`

if [[ "$NERSC_HOST" == perlmutter ]]; then
    # compiler segfault with gcc/10.3.0

    echo \$NERSC_HOST matched perlmutter

    export CUDAARCHS="80" # for cmake 3.20+
    
    echo module load PrgEnv-gnu
    module load PrgEnv-gnu
    echo module load cmake/3.22.0
    module load cmake/3.22.0
    echo module load cudatoolkit
    module load cudatoolkit
    echo module load cpe-cuda
    module load cpe-cuda

    which cmake
    which gcc
    which nvcc
elif [[ "$host" =~ .*ascicgpu.* ]]; then
    echo "$host" matched ascicgpu
    
    export CUDAARCHS="70" # for cmake 3.20+

    module purge

    mkdir -p /tmp/$USER
    export TMPDIR=/tmp/$USER

    module load sierra-devel/nvidia

    module load cde/v2/cmake/3.19.2

    which cmake
    which gcc
    which nvcc
    which mpirun
elif [[ "$host" =~ .*vortex.* ]]; then
# CUDA 10.1 & cmake 3.18.0 together cause some problem with recognizing the `-pthread` flag.

    echo "$host" matched vortex
    
    echo "export CUDAARCHS=70"
    export CUDAARCHS="70" # for cmake 3.20+

    echo "export OMPI_CXX=${NVCC_WRAPPER}"
    export OMPI_CXX="${NVCC_WRAPPER}"

    echo module --force purge
    module --force purge

    echo module load cmake/3.18.0
    module load cmake/3.18.0
    echo module load cuda/11.1.1
    module load cuda/11.1.1
    echo module load gcc/8.3.1
    module load gcc/8.3.1
    echo module load spectrum-mpi/rolling-release
    module load spectrum-mpi/rolling-release
    echo module load nsight-compute/2020.3.1
    module load nsight-compute/2020.3.1
elif [[ "$host" =~ .*attaway.* ]]; then
# CUDA 10.1 & cmake 3.18.0 together cause some problem with recognizing the `-pthread` flag.

    echo "$host" matched attaway
    
    echo module --force purge
    module --force purge

    # would rather use the intel compiler but I can't get it to work
    echo module load cde/v3/gcc/10.3.0
    module load cde/v3/gcc/10.3.0
    echo module load cmake/3.22.3
    module load cmake/3.22.3
fi
