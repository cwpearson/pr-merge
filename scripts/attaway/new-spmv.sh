#!/bin/bash
## Do not put any commands or blank lines before the #SBATCH lines
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=36          # Number of cores per node
#SBATCH --time=4:00:00
#SBATCH --account=PUT_YOUR_WCID_HERE  # WC ID
#SBATCH --job-name=kk-merge           # Name of job
#SBATCH --partition=short,batch       # short,batch: job will move to batch if short is full

#SBATCH --qos=normal                  # Quality of Service: long, large, priority or normal
                                      #           normal: request up to 48hrs wallclock (default)
                                      #           long:   request up to 96hrs wallclock and no larger than 64nodes
                                      #           large:  greater than 50% of cluster (special request)
                                      #           priority: High priority jobs (special request)

nodes=$SLURM_JOB_NUM_NODES           # Number of nodes - the number of nodes you have requested (for a list of SLURM environment variables see "man sbatch")
cores=36                             # Number MPI processes to run on each node (a.k.a. PPN)
                                     # cts1 has 36 cores per node
# using openmpi-intel/1.10
# mpiexec --bind-to core --npernode $cores --n $(($cores*$nodes)) /path/to/executable [--args...]

export ROOT=$HOME/pr-merge
$ROOT/build-attaway/kokkos-kernels/perf_test/sparse_kk_spmv_merge $HOME/suitesparse/reals_small/*.mtx

# Note 1: This will start ($nodes * $cores) total MPI processes using $cores per node.
#           If you want some other number of processes, add "-np N" after the mpiexec, where N is the total you want.
#           Example:  mpiexec -np 24  ......(for a 2 node job, this will load 16 processes on the first node and 8 processes on the second node)
#           If you want a specific number of process to run on each node, (thus increasing the effective memory per core), use the --npernode option.
#           Example: mpiexec -np 24 --npernode 12  ......(for a 2 node job, this will load 12 processes on each node)

# The default version of Open MPI is version 1.10.

# For openmpi 1.10: mpiexec --bind-to core --npernode 8 --n PUT_THE_TOTAL_NUMBER_OF_MPI_PROCESSES_HERE /path/to/executable [--args...]

# To submit your job, do:
# sbatch <script_name>
#
#The slurm output file will by default, be written into the directory you submitted your job from  (slurm-JOBID.out)