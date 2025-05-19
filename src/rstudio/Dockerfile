# FROM docker.io/rocker/rstudio
ARG base_image_name
FROM ${base_image_name}

RUN echo "dir.create(c(paste0('/rstudio/',R.Version()\$platform, '/packages')), recursive=TRUE, showWarnings = FALSE)\n \
.libPaths(c(paste0('/rstudio/',R.Version()\$platform, '/packages'), .libPaths()))\n \
dir.create('/workdir', recursive=TRUE, showWarnings = FALSE)\n \
setwd('/workdir')" > /root/.Rprofile \
&& echo '{\n  "sync_files_pane_working_dir": true\n}' > /etc/rstudio/rstudio-prefs.json

