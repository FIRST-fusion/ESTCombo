#!/bin/bash
current_path=$(pwd)

echo "Downloading VMEC, TERP, DCON .................."
#git clone git@github.com:FIRST-fusion/Stellarator-Tools.git
#git clone git@github.com:FIRST-fusion/TERPSICHORE.git
#git clone git@github.com:FIRST-fusion/DCON.git

echo "Downloading package/patch for codes ..........." 
#git clone git@github.com:FIRST-fusion/VMEC-patch.git
#git clone git@github.com:FIRST-fusion/General-tool.git

echo "[INFO] Complete downloading all package!!"
echo ""
echo "Start to build docker image and container, please enter customize image/container name ..."
echo "NOTE: All name should be in lowercase!!" 
echo ">> Enter image name: "
read image_name
echo ">> Enter container's name: "
read container_name
echo "Creating docker image .........................."
docker build -t $image_name .
echo "Do you want to mount the current folder to the docker container? [y/n]"
read answer
answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

# Check if the input is 'yes' or 'y'
if [ "$answer" = "yes" ] || [ "$answer" = "y" ]; then
    echo "You chose to mount. Mounting to current folder $current_path ..."
    docker run -it --userns=host -v "$current_path":"/workspace" --name "$container_name" "$image_name"

elif [ "$answer" = "no" ] || [ "$answer" = "n" ]; then
    echo "You chose not to mount."
    echo "Run docker container ...."
    docker run -it $image_name
    exit 0
else
    echo "You chose not to mount. Exiting..."
    exit 0
fi 

