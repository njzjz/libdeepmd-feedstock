export LAMMPS_PLUGIN_PATH=$(echo ${LAMMPS_PLUGIN_PATH} | awk -v RS=: -v ORS=: "/${CONDA_PREFIX}\/lib\/deepmd_lmp/ {next} {print}" | sed 's/:*$//')
