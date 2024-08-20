
## quick run dockerfile
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
    echo "You chose NOT to mount."
    echo "Run the docker container $container_name by image $image_name ......"
    #docker run -it $image_name
    docker run -it --name $container_name $image_name
    #exit 0
else
    echo "You chose neither to mount. Run the docker container directly..."
    docker run -it --name $container_name $image_name
    #exit 0
fi 

