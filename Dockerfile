ARG IMAGE_TAG=${IMAGE_TAG:-3.8.11-slim-buster}
FROM python:${IMAGE_TAG}

LABEL owner="ThanatosDi" version="latest" description="."

# EXPOSE 5004/tcp

ARG INSTALL_PM2=false
ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}
ARG PUSER=deployer
ENV PUSER ${PUSER}

RUN set -xe; \
    groupadd -g ${PGID} ${PUSER} && \
    useradd -l -u ${PUID} -g ${PUSER} -m ${PUSER}  && \
    usermod -p "*" ${PUSER} -s /bin/bash

ENV NVM_DIR /home/${PUSER}/.nvm

USER ${PUSER}

COPY requirements.txt /app/requirements.txt

RUN pip3 install -r /app/requirements.txt

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
		vim curl\
	&& rm -rf /var/lib/apt/lists/*

USER ${PUSER}
ARG NVM_VERSION=${NVM_VERSION:-0.38.0}
ARG NODE_VERSION=${NODE_VERSION:-node}
ENV NODE_VERSION ${NODE_VERSION}
RUN if [ ${INSTALL_PM2} = true ]; then \
        whoami && \
        mkdir -p $NVM_DIR && \
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash &&\
        . $NVM_DIR/nvm.sh && \
        nvm install ${NODE_VERSION} &&\
        nvm use ${NODE_VERSION} &&\
        nvm alias ${NODE_VERSION} && \
        npm install pm2 -g && \
        echo "" >> ~/.bashrc && \
        echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
        echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc &&\
        ln -s `npm bin --global` $HOME/.node-bin &&\
        pm2 install pm2-logrotate; \
    fi;


ENV PATH $PATH:$HOME/.node-bin

WORKDIR /app

# CMD ["pm2-runtime", "start", "ecosystem.config.js"]
# CMD ["python3", "app.py"]
CMD ["/bin/bash"]