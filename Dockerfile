FROM python:3.8.11-buster

LABEL owner="ThanatosDi" version="latest" description="For Symmetry Python API programe."

# EXPOSE 5004/tcp

ENV NVM_DIR /root/.nvm

USER root

COPY requirements.txt /app/requirements.txt

RUN pip3 install -r /app/requirements.txt

RUN whoami && \
    mkdir -p $NVM_DIR && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash &&\
    . $NVM_DIR/nvm.sh && \
    nvm install node && \
    nvm alias node && \
    npm install pm2 -g && \
    echo "" >> ~/.bashrc && \
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc &&\
    ln -s `npm bin --global` /root/.node-bin &&\
    pm2 install pm2-logrotate

ENV PATH $PATH:/root/.node-bin

WORKDIR /app

# CMD ["pm2-runtime", "start", "ecosystem.config.js"]
CMD ["/bin/bash"]