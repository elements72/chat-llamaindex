# Insufficient number of arguments
if [ $# -lt 1 ]; then
    echo "Usage: ./run_docker.sh [run|build|remove]"
    exit 1
fi

case $1 in
    "run")
        # Run the docker container
        docker run -v ./:/src/ -d -p 3000:3000 --name llamaindex-container llamaindex 
        ;;
    "exec")
        # Execute the models inside the docker container
        docker exec -it llamaindex-container bash      
        ;;
    "build")
        # Build the dockers
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