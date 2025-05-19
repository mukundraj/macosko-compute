FROM docker.io/rocker/rstudio

RUN sudo apt-get update && apt-get install -y libglpk-dev

# Install R libraries
RUN R -e "install.packages(c('tidyverse', \
                             'ggplot2', 'cowplot', \
                             'qs', 'viridis', \
                             'rstudioapi', \
                             'Seurat', 'SeuratObject', \
                             repos='http://cloud.r-project.org'), \
                             Ncpus=$(nproc)L)"

# podman build -f Dockerfile -t rstudio-std .
# podman save -o /mnt/disks/common/images/rstudio-std.tar rstudio-std:latest
# sudo chmod -R 777 /mnt/disks/common

