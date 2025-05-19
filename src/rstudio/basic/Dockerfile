FROM docker.io/rocker/rstudio

RUN apt-get update && apt-get install -y libglpk-dev

RUN R -e "install.packages(c('rstudioapi', \
                             repos='http://cloud.r-project.org'), \
                             Ncpus=$(nproc)L)"
# podman build -f Dockerfile -t rstudio-basic .
# podman save -o /mnt/disks/common/images/rstudio-basic.tar rstudio-basic:latest
# sudo chmod -R 777 /mnt/disks/common

