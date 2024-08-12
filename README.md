# ESTCombo
This is a combined tool for the study of MHD equilibrium and Stability, which includes:

- [VMEC](https://github.com/ORNL-Fusion/Stellarator-Tools.git) 3D Equilibrium solver with nested flux surfaces.

- [TERPSICHORE](https://github.com/FIRST-fusion/TERPSICHORE.git) Calculates ideal kink stability from VMEC equilibria.

- [DCON](https://github.com/FIRST-fusion/DCON.git) Determine the MHD stability of axisymmetric toroidal plasma

## Install
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

1. Some of python scripts n
