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

    echo "$host" matched attaway
    
    echo module --force purge
    module --force purge

    # would rather use the intel compiler but I can't get it to work
    echo module load cde/v3/gcc/10.3.0
    module load cde/v3/gcc/10.3.0
    echo module load cmake/3.22.3
    module load cmake/3.22.3
elif [[ "$host" =~ .*blake.* ]]; then

    echo "$host" matched blake
    
    echo module --force purge
    module --force purge

    echo module load gcc/10.2.0
    module load gcc/10.2.0
    echo module load cmake/3.22.2
    module load cmake/3.22.2
elif [[ "$HOSTNAME" =~ .*caraway.* || "$SLURM_CLUSTER_NAME" =~ .*caraway.* ]]; then

    echo matched caraway
    
    echo module --force purge
    module --force purge

    echo module load rocm/5.2.0
    module load rocm/5.2.0
    echo module load cmake/3.22.2
    module load cmake/3.22.2
elif [[ $LMOD_SYSTEM_NAME =~ crusher ]]; then
    echo LMOD_SYSTEM_NAME matched crusher
    
    echo module purge
    module purge

    echo module load DefApps/default
    module load DefApps/default

    echo export CRAYPE_LINK_TYPE=dynamic
    export CRAYPE_LINK_TYPE=dynamic

    # echo module load PrgEnv-amd
    # module load PrgEnv-amd
    echo module load rocm/5.4.0
    module load rocm/5.4.0
    echo module load cmake/3.22.2
    module load cmake/3.22.2
elif [[ "$host" =~ .*kokkos-dev.* ]]; then
    echo "$host" matched kokkos-dev
    
    echo module load sems-gcc/10.1.0
    module load sems-gcc/10.1.0
    echo module load sems-cuda/11.4.2
    module load sems-cuda/11.4.2
    echo module load sems-cmake/3.23.1
    module load sems-cmake/3.23.1
elif [[ "$host" =~ .*rzvernal.* ]]; then
    echo "$host" matched rzvernal
    
    echo module load cmake/3.24.2
    module load cmake/3.24.2
    # BSR matrix crashes rocm/5.3.0
    echo module load rocm/5.3.0
    module load rocm/5.3.0
    # BSR matrix crashes rocm/5.2.0
    # echo module load rocm/5.2.0
    # module load rocm/5.2.0

    echo export CRAYPE_LINK_TYPE=dynamic
    export CRAYPE_LINK_TYPE=dynamic
fi

