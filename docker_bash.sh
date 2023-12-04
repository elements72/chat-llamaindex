# Insufficient number of arguments
if [ $# -lt 1 ]; then
    echo "Usage: ./run_docker.sh [run|build|remove]"
    exit 1
fi

case $1 in
    "run")
        # Run the docker container
        docker run  -v ./:/src/ -d -it -p 37331:37331  --name llamaindex-container llamaindex
        ;;
    "exec")
        # Execute the models inside the docker container
        docker exec -it llamaindex-container bash      
        ;;
    "build")
        # Build the docker
        docker build ./ -t llamaindex
        ;;
    "remove")
        # Remove the docker container
        docker stop llamaindex-container &&
        docker remove llamaindex-container
        ;;
    "*")
        # Invalid argument
        Echo "Invalid argument"
        ;;
esac