export DOCKER_TAG=latest
export GIT_REPO=https://github.com/rdkit/rdkit.git
export GIT_BRANCH=master
export TARGET_ARCH=linux/arm64 #linux/amd64
unset GIT_TAG

export BASE=jdradatti
echo "DOCKER_TAG=$DOCKER_TAG GIT_BRANCH=$GIT_BRANCH no tag"
