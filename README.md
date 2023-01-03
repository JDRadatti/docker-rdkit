# Dockerfiles for building RDKit.

GitHub repo for RDKit is [here](https://github.com/rdkit/rdkit).
GitHub repo for this project is [here](https://github.com/InformaticsMatters/docker-rdkit)

To create images for a new version of RDKit you should only need to create a new branch from `master` and then edit `params.sh`.

## Build and run

Edit params.sh with your docker username and computer's architecture. Optionally uncomment and update Dockerfile-python3-debian(line 41) with desired dependencies. 

Create the docker images like this:

`bash build-debian.sh`

Push the images to Docker Hub like this:

`bash push-debian.sh`
