#!/bin/sh
#PJM -L rscgrp=share
#PJM -L gpu=1
#PJM -L elapse=2:00:00
#PJM -g gy42
#PJM -j
module load intel
module load impi
mpirun -np 128 python3 check_mpi.py
