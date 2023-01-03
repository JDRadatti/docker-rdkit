#!/bin/bash

set -xe

source params.sh

# build RDKit
docker buildx build $DBO -f Dockerfile-build-debian \
  --platform $TARGET_ARCH --push \
  -t $BASE/rdkit-build-debian:$DOCKER_TAG \
  --build-arg GIT_REPO=$GIT_REPO\
  --build-arg GIT_BRANCH=$GIT_BRANCH\
  --build-arg GIT_TAG=$GIT_TAG .

# copy the packages
rm -rf artifacts/debian/$DOCKER_TAG
mkdir -p artifacts/debian/$DOCKER_TAG
mkdir -p artifacts/debian/$DOCKER_TAG/debs
mkdir -p artifacts/debian/$DOCKER_TAG/java
docker run -it --rm -u $(id -u)\
  -v $PWD/artifacts/debian/$DOCKER_TAG:/tohere:Z\
  $BASE/rdkit-build-debian:$DOCKER_TAG bash -c 'cp /rdkit/build/*.deb /tohere/debs && cp /rdkit/Code/JavaWrappers/gmwrapper/org.RDKit.jar /rdkit/Code/JavaWrappers/gmwrapper/libGraphMolWrap.so /rdkit/Code/JavaWrappers/gmwrapper/javadoc.tgz /tohere/java'

# build image for python3 on debian
docker build $DBO -f Dockerfile-python3-debian\
  -t $BASE/rdkit-python3-debian:$DOCKER_TAG\
  --build-arg DOCKER_TAG=$DOCKER_TAG .
echo "Built image informaticsmatters/rdkit-python3-debian:$DOCKER_TAG"

# build image for postgresql cartridge on debian
docker buildx build $DBO -f Dockerfile-cartridge-debian \
  --platform $TARGET_ARCH --push \
  -t $BASE/rdkit-cartridge-debian:$DOCKER_TAG \
  --build-arg DOCKER_TAG=$DOCKER_TAG .
echo "Built image ${BASE}/rdkit-cartridge-debian:$DOCKER_TAG"


