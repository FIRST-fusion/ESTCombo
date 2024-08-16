# ESTCombo
This is a combined tool for the study of MHD equilibrium and Stability, which includes:

- [VMEC](https://github.com/ORNL-Fusion/Stellarator-Tools.git) 3D Equilibrium solver with nested flux surfaces.

- [TERPSICHORE](https://github.com/FIRST-fusion/TERPSICHORE.git) Calculates ideal kink stability from VMEC equilibria.

- [DCON](https://github.com/FIRST-fusion/DCON.git) Determine the MHD stability of axisymmetric toroidal plasma

## Install

Before you start, ask the server manager if you have acess to docker. 

Clone the repository and install all packages.

``` bash
git clone git@github.com:FIRST-fusion/ESTCombo.git
cd ESTCombo
./install_onfirst.sh
```

Since the combo is set to be executed in docker, so the you should name the name of image and container by yourself. 
Accident may occur if you're not familiar with docker, ask me (Lin Shih) or ChatGPT to solve issues. 
Note that we recommend you to "mount" the docker with your local host.

Once you build and run your image, you will enter the docker container automatically. In the docker, run 

```bash
./compile.sh
```


## After install

1. Some of python scripts need numpy, please install it by `pip3 install numpy` manually.

2. In our study, we set the wall away 1.2 times plasma radius from the plasma, so to make sure you get consistent result, go to `/workspace/DCON/rundir/Linux/vac.in` and modify a=20 (default) to a=0.2.

