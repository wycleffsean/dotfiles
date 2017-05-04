# Docker Machine
function setDockerEnv() {
  docker_machine_default=dinghy
  docker_machine_status=$(docker-machine status $docker_machine_default)
  if [[ "$docker_machine_status" == "Running" ]]
  then
    eval "$(docker-machine env $docker_machine_default)"
  fi
}
setDockerEnv

function dockercleancontainers() {
  if [[ -n "${1}" ]]; then
    docker container rm -f $(docker container ls -aq -f name="${1}") &> /dev/null
  else
    # find exited containers that are not labeled "data" and remove them
    docker rm $(
      comm -13 \
        <(docker container ls -aq -f status=exited --no-trunc -f label=data | sort) \
        <(docker container ls -aq -f status=exited --no-trunc | sort)
    ) &> /dev/null
  fi
}

function dockercleanimages() {
  if [[ -n "${1}" ]]; then
    docker images | grep "${1}" | awk '{print $3}' | xargs docker rmi
  else
    docker rmi $(docker images -f dangling=true -q)
  fi
}

function dockerclean() {
  dockercleancontainers; dockercleanimages
}

function dockerrmdanglingimages() {
  docker rmi $(docker images -f dangling=true -q)
}

function dockerrmstoppedcontainers() {
  docker rm $(docker ps -q -f status=exited)
}
