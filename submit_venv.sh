#!/bin/bash
#SBATCH --account=def-pierre
#SBATCH --mem-per-cpu=2G      # increase as needed
#SBATCH --time=1:00:00
#SBATCH --output=test_ash.out

#load external programs
#load dependencies for ORCA 4.2.1
module load nixpkgs/16.09
module load gcc/7.3.0
module load openmpi/3.1.4
#load ORCA 4.2.1
module load orca/4.2.0
#load xTB 6.4.0
module load StdEnv/2020
module load gcc/9.3.0
module load xtb/6.4.0

#load dependencies for ASH
#load dependencies for openmm 7.6.0
module load StdEnv/2020
module load gcc/9.3.0
module load cuda/11.4
module load openmpi/4.0.3
module load intel/2020.1.217
#load openmm 7.6.0
module load openmm/7.6.0
#load julia 1.6.2
module load julia/1.6.2

############################

module load python/3.7.7 #loads python 3.7 (geometric requires =>3.7)
module load scipy-stack #loads all of SciPy

#/path/to/ASH must be in your PATH
export ASHPATH=/home/josephzp/ASH #put path/to/ash here
export PYTHONPATH=$ASHPATH:$ASHPATH/lib:$PYTHONPATH
export PATH=$ASHPATH:$PATH
export LD_LIBRARY_PATH=$ASHPATH/lib:$LD_LIBRARY_PATH
#should $VIRTUAL_ENV be in these PATHs?

virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip3 install --no-index --upgrade pip

#install PyJulia. path/to/julia.whl depends where you pre-downloaded it.
python3 -m pip install /home/josephzp/ASH_PyDeps/julia-0.5.7-py2.py3-none-any.whl

#install GeomeTRIC. path/to/geomeTRIC depends where you pre-downloaded it.
cd /home/josephzp/ASH_PyDeps/geometric-0.9.7.2/ && python3 -m pip install .

#cd "$(dirname "$0")"
cd /home/josephzp/projects/def-pierre/josephzp/ASH/test3_submit-venv

python3_ash test_ash.py

deactivate
