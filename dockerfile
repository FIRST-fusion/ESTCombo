# Using ubuntu:20.04 as the base image
FROM ubuntu:20.04

# Set noninteractive installation to avoid user interaction during build
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei

# Update and upgrade Ubuntu packages, then clean up the apt cache to reduce image size
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y wget gnupg build-essential sudo csh libncurses5 lib32z1 libssl-dev curl gfortran-7 \
    libblas-dev liblapack-dev libnetcdff-dev libnetcdf-dev libscalapack-mpi-dev libx11-dev cmake cmake-curses-gui \
    python3 python3-pip  git lsb-release vim tzdata && \
    curl -Lo- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | sudo gpg --dearmor -o /usr/share/keyrings/oneapi-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list && \
    apt-get update && \
    apt-get install -y intel-oneapi-compiler-fortran && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure environment settings
RUN echo "source /opt/intel/oneapi/setvars.sh" >> /etc/profile.d/oneapi.sh

# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN date    

# Setup work directory for application code in /workspace
WORKDIR /workspace

# Copy the current directory contents into the container at /workspace for different projects
COPY . /workspace
COPY Stellarator-Tools /workspace/Stellarator-Tools
COPY TERPSICHORE /workspace/TERPSICHORE
COPY DCON /workspace/DCON
COPY VMEC-patch /workspace/VMEC-patch
COPY General-tool /workspace/General-tool

# Source Intel oneAPI environment variables during build and after startup
RUN /bin/bash -c "source /opt/intel/oneapi/setvars.sh"


# Define default command
CMD ["bash"]
