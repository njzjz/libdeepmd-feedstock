set -e
mkdir -p source/build
cd source/build
if [[ ${cuda_compiler_version} != "None" ]]; then
    DEEPMD_USE_CUDA_TOOLKIT=TRUE
else
    DEEPMD_USE_CUDA_TOOLKIT=FALSE
fi
cmake -DTENSORFLOW_ROOT=${PREFIX} -DCMAKE_INSTALL_PREFIX=${PREFIX} -DUSE_CUDA_TOOLKIT=${DEEPMD_USE_CUDA_TOOLKIT} -DLAMMPS_VERSION=stable_23Jun2022_update4 ..
make -j${CPU_COUNT}
make install

for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done

