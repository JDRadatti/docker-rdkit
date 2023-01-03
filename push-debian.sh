#!/bin/bash

set -e

source params.sh

docker push $BASE/rdkit-python3-debian:$DOCKER_TAG
docker push $BASE/rdkit-cartridge-debian:$DOCKER_TAG

echo "Images pushed using tag $DOCKER_TAG"

