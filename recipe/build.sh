set -e
mkdir -p source/build
cd source/build
cmake -DTENSORFLOW_ROOT=${PREFIX} -DCMAKE_INSTALL_PREFIX=${PREFIX} -DFLOAT_PREC=${float_prec} -DCMAKE_CXX_FLAGS="-lrt -pthread" -DCMAKE_SHARED_LINKER_FLAGS_INIT="--no-as-needed -lrt -pthread" ..
make -j${CPU_COUNT}
make install
make lammps
mkdir -p ${PREFIX}/share
mv USER-DEEPMD ${PREFIX}/share
