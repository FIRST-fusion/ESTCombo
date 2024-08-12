#!/bin/bash

# The script is to compile all package/codes at once.
# The paths below are only for docker.
# If not using docker, you have to change all path in every scrips to your own usage.
# 
# All scripts here arec reated by Lin Shih 
# email: linshih010@gmail.com
# 
# 2024/08/09

patch_path="/workspace/VMEC-patch"
vmec_path="/workspace/Stellarator-Tools"
dcon_path="/workspace/DCON"


# VMEC (Stellerator-tool)
cd ${vmec_path}
rm -rf build
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_LIBSTELL=ON -DBUILD_MAKEGRID=ON -DBUILD_PARVMEC=ON -DBUILD_DESCUR=ON ../
#make

echo "Patch VMEC source files ==============================>>"
cp ${patch_path}/eqfor.f ${vmec_path}/PARVMEC/Sources/Input_Output/eqfor.f
cp ${patch_path}/vmec_io.f ${vmec_path}/PARVMEC/Sources/Input_Output/vmec_io.f
cp ${patch_path}/amplitud.f ${vmec_path}/DESCUR/Sources/amplitud.f
cp ${patch_path}/printit.f ${vmec_path}/DESCUR/Sources/printit.f
cp ${patch_path}/scrunch.f ${vmec_path}/DESCUR/Sources/scrunch.f
cp ${patch_path}/read_wout_mod.f90 ${vmec_path}/LIBSTELL/Sources/Modules/read_wout_mod.f90
cp ${patch_path}/vmec_input.f ${vmec_path}/LIBSTELL/Sources/Modules/vmec_input.f
cp ${patch_path}/wrout.f ${vmec_path}/PARVMEC/Sources/Input_Output/wrout.f
echo "Start to compile VMEC ================================>>"
make clean
make

if [ $? -eq 0 ]; then
	echo "[INFO] Finish compiling VMEC!"
else 
	echo "[Erro] Make failed. Please check what make failure."
fi

# Update Symbolink Link of gfortran-9 (default) to point to gfortran-7
# DCON can be compiled only by gfortran-7
sudo rm /usr/bin/gfortran
sudo ln -s /usr/bin/gfortran-7 /usr/bin/gfortran

# TERP
echo "Compiling TERPSICHORE ==============================>>"
cd /workspace/TERPSICHORE/TERPSICHORE_main
make
cd /workspace/TERPSICHORE/terp_bootsj
make
cd /workspace/TERPSICHORE/vm3dp
make
cd /workspace/TERPSICHORE/vmec2tpr
make
if [ $? -eq 0 ]; then
	echo "[INFO] Finish compiling TERPSICHORE!"
else 
	echo "[Erro] Make failed. Please check what make failure."
fi

#DCON
echo "Compiling DCON =====================================>>"
cd /workspace/DCON/
make
if [ $? -eq 0 ]; then
	echo "[INFO] Finish compiling DCON!"
	echo "[INFO] All compilation is done!"
	echo "[INFO] If you want to use interface scripst, go to /workspace/General-tool/script_forDocker and execute distrib.sh in that folder." 
else 
	echo "[Erro] Make failed. Please check which one has gone failure."
fi
