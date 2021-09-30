set -e
mkdir -p source/build
cd source/build
if [[ ${cuda_compiler_version} != "None" ]]; then
    DEEPMD_USE_CUDA_TOOLKIT=TRUE
else
    DEEPMD_USE_CUDA_TOOLKIT=FALSE
fi
cmake -DTENSORFLOW_ROOT=${PREFIX} -DCMAKE_INSTALL_PREFIX=${PREFIX} -DUSE_CUDA_TOOLKIT=${DEEPMD_USE_CUDA_TOOLKIT} -DLAMMPS_VERSION=stable_29Sep2021 -DLAMMPS_VERSION_NUMBER=20210929 ..
make -j${CPU_COUNT}
make install
make lammps
mkdir -p ${PREFIX}/share
mv USER-DEEPMD ${PREFIX}/share
