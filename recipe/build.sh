set -e
mkdir -p source/build
cd source/build
if [[ ${cuda_compiler_version} != "None" ]]; then
    DEEPMD_USE_CUDA_TOOLKIT=TRUE
else
    DEEPMD_USE_CUDA_TOOLKIT=FALSE
fi
cmake -DTENSORFLOW_ROOT=${PREFIX} -DCMAKE_INSTALL_PREFIX=${PREFIX} -DFLOAT_PREC=${float_prec} -DUSE_CUDA_TOOLKIT=${DEEPMD_USE_CUDA_TOOLKIT} -DCMAKE_CXX_FLAGS="-lrt" -DCMAKE_SHARED_LINKER_FLAGS_INIT="-lrt"  ..
make -j${CPU_COUNT}
make install
make lammps
mkdir -p ${PREFIX}/share
mv USER-DEEPMD ${PREFIX}/share
