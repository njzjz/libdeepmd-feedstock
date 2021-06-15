set -e
mkdir -p source/build
cd source/build
if [[ ${dp_variant} == "gpu" ]]; then
    export DEEPMD_CUDA_ARGS="-DUSE_CUDA_TOOLKIT=TRUE"
fi
cmake -DTENSORFLOW_ROOT=${PREFIX} -DCMAKE_INSTALL_PREFIX=${PREFIX} -DFLOAT_PREC=${float_prec} ${DEEPMD_CUDA_ARGS} ..
make -j${CPU_COUNT}
make install
make lammps
mkdir -p ${PREFIX}/share
mv USER-DEEPMD ${PREFIX}/share
