CONTAINER_NAME="minecraft-sever"
TAG="latest"
FILE=.env


if [[ $1 == "init" ]]; then
  echo "terragrunt run-all init"
  if test -f "$FILE"; then
    echo "$FILE exists."
    DOCKER_BUILDKIT=1 docker build -t $CONTAINER_NAME:$TAG .
    DOCKER_BUILDKIT=1 docker run -itd --env-file .env --name $CONTAINER_NAME $CONTAINER_NAME bash
    DOCKER_BUILDKIT=1 docker exec -ti $CONTAINER_NAME terragrunt init
    DOCKER_BUILDKIT=1 docker exec -ti $CONTAINER_NAME terragrunt run-all init
  fi  
fi

if [[ $1 == "apply" ]]; then
  echo "terragrunt run-all apply -terragrunt-non-interactive -auto-approve"
  if test -f "$FILE"; then
    echo "$FILE exists."
    # DOCKER_BUILDKIT=1 docker exec -ti $CONTAINER_NAME terragrunt apply -auto-approve
    DOCKER_BUILDKIT=1 docker exec -ti $CONTAINER_NAME terragrunt run-all apply -auto-approve
  fi 
fi

if [[ $1 == "destroy" ]]; then
  echo "terragrunt run-all destroy -auto-approve"
  if test -f "$FILE"; then
    echo "$FILE exists."
    DOCKER_BUILDKIT=1 docker exec -ti $CONTAINER_NAME terragrunt run-all destroy -auto-approve
  fi 
fi


if [[ $1 == "clean" ]]; then
  echo "Cleaning Env"
  echo "Stopped $(DOCKER_BUILDKIT=1 docker stop $CONTAINER_NAME)"
  echo "Removes $(DOCKER_BUILDKIT=1 docker rm $CONTAINER_NAME)"
fi

if [[ $1 == "plan" ]]; then
  echo "terragrunt run-all plan"
  if test -f "$FILE"; then
    echo "$FILE exists."
    DOCKER_BUILDKIT=1 docker exec -ti $CONTAINER_NAME terragrunt run-all plan
  fi 
fi

# echo "Please use init, plan or apply"

# RUN terragrunt run-all init 
# &&  terragrunt run-all plan && terragrunt run-all apply -terragrunt-non-interactive -auto-approve  