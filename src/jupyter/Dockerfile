ARG base_image_name
FROM ${base_image_name}

ARG USER=REQUIRED
RUN [ "$USER" != "REQUIRED" ]

# jupyter preferences

# Set password
RUN expect -c 'spawn bash -lc "micromamba run jupyter lab password"; expect "Enter password:"; send "$env(USER)\r"; expect "Verify password:"; send "$env(USER)\r"; expect eof'

# Set the mamba root to /root/micromamba if available
RUN sed -i "4i\  [ ! -d '/root' ] && echo 'WARNING: Directory not found' || bash -ic 'micromamba shell init -s bash -r /root/micromamba' &> /dev/null" /root/.profile

# (miscellaneous config)
RUN /bin/bash -lc "micromamba run jupyter lab --generate-config && echo -e 'c.ServerApp.terminals_enabled = True\nc.FileContentsManager.delete_to_trash = False' >> /root/.jupyter/jupyter_lab_config.py"

# Set default theme to JupyterLab Dark
RUN DIR='/root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension' && mkdir -p "$DIR" && echo '{\n  "theme": "JupyterLab Dark"\n}' > "$DIR/themes.jupyterlab-settings"

ENTRYPOINT /bin/bash -lc "micromamba activate base && jupyter lab --allow-root --ip '*' --port '8787' --NotebookApp.token='' --NotebookApp.notebook_dir='/workdir' --no-browser"
