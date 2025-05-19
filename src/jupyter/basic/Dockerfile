FROM debian:bookworm

# Install system libraries
RUN apt-get update && apt-get install -y  \
    sudo zip unzip less tree expect       \
    wget curl rsync socat                 \
    gdebi-core build-essential cmake pkg-config alien \
    libssl-dev libcurl4-openssl-dev


# Install R
RUN export R_VERSION=4.3.3 && \
    curl -O https://cdn.rstudio.com/r/debian-12/pkgs/r-${R_VERSION}_1_amd64.deb && \
    echo y | gdebi r-${R_VERSION}_1_amd64.deb && \
    rm r-${R_VERSION}_1_amd64.deb && \
    sudo ln -s /opt/R/${R_VERSION}/bin/R /usr/local/bin/R && \
    sudo ln -s /opt/R/${R_VERSION}/bin/Rscript /usr/local/bin/Rscript

# Install R libraries
RUN R -e "install.packages(c('tidyverse', \
                             'IRkernel'), \
                             repos='http://cloud.r-project.org', \
                             Ncpus=$(nproc)L)"


# Install micromamba
RUN curl -L micro.mamba.pm/install.sh | /bin/bash
RUN /bin/bash -lc "micromamba clean --locks"

# Install python packages
RUN /bin/bash -lc "micromamba install -c conda-forge python=3.11.2 jupyterlab \
                   matplotlib"

# Install IRkernel
RUN /bin/bash -lc "micromamba run R -e 'IRkernel::installspec(user = FALSE)'"

# podman build -f Dockerfile -t jupyter-basic .
# podman save -o /mnt/disks/common/images/jupyter-basic.tar jupyter-basic:latest
# sudo chmod -R 777 /mnt/disks/common

