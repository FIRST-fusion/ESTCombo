# ESTCombo
This is a combined tool for the study of MHD equilibrium and Stability, which includes:

- [VMEC](https://github.com/ORNL-Fusion/Stellarator-Tools.git) 3D Equilibrium solver with nested flux surfaces.

- [TERPSICHORE](https://github.com/FIRST-fusion/TERPSICHORE.git) Calculates ideal kink stability from VMEC equilibria.

- [DCON](https://github.com/FIRST-fusion/DCON.git) Determine the MHD stability of axisymmetric toroidal plasma

## Warning!!

Before you run the followng steps, make sure you are 

1. One of the memebrs in this Github organization 

2. Have access to repositories: Stellerator-tools, TERPSICHORE, DCON, VMEC-patch, General-tool. 

3. Ask the manager to turn on your docker authority in server (ncku-first)

4. Generate a key and add to your github, so that you can access all things in this organization

## Install

The ESTCombo is set to be executed in docker, so before you start, ask the server manager if you have acess to docker. 


Clone the repository and install all packages.

``` bash
git clone git@github.com:FIRST-fusion/ESTCombo.git
cd ESTCombo
./install_onfirst.sh
```
Note that you can run `./install_onfirst` to quickly git pull if there is any updates on those repositories.

After downloading the repos, it is your option to run `quick_run_docker.sh` to build, run, name, and mount the docker image/container at once. Accident may occur if you're not familiar with docker, ask Lin Shih or ChatGPT to solve issues. Note that this script will ask if you want to mount the docker with your host. We recommend you to do so to avoid inconsistency and any github-related issue.

Once you build and run your image, you will enter the docker container automatically. In the docker, run 

```bash
./compile.sh
```

This step will build all VMEC, TERPSHICHORE, DCON at once. Note that if you have any updates on these repository, you could also recompile them in your docker container by this script.

## Checklist after the installation

1. Go to `/workspace/General-tool/script_forDocker` and run `./distrib.sh`. This will distribute all auxiliary scripst using in VMEC to certain directories.

2. Some of python scripts need numpy, please install it by `pip3 install numpy` manually.

3. In our study, we set the wall away 1.2 times plasma radius from the plasma, so to make sure you get consistent result, go to `/workspace/DCON/rundir/Linux/vac.in` and modify a=20 to a=0.2.

## Start Container

To leave docker container, just `exit` in container.

To run the container you have created, check `docker ps -a` first and see which one, then 

``` bash
docker start <container_name> 
docker exec -it <container_name> bash
```


