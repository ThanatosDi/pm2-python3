# pm2-python3
![](https://img.shields.io/badge/Python-3.8.11-brightgreen)
![](https://img.shields.io/badge/NVM-0.38.0-yellowgreen)
![](https://img.shields.io/badge/PM2-latest-blue)
![](https://api.travis-ci.com/ThanatosDi/pm2-python3.svg?branch=main&status=unknown)
  
以 Python 官方 Docker image 為基底打造 PM2 管理 Python 應用程式容器

 - 不使用 PM2 管理 Process
     - 專案結構
        ```bash
        .
        ├── app (Application logic)
        │   ├── Blueprints
        │   ├── Controllers
        │   └── Model
        ├── app.py (Main python program)
        └── docker (This repostory)
            ├── docker-compose.yml
            ├── Dockerfile
            ├── LICENSE
            ├── README.md
            ├── requirements.txt
            └── travis-build.sh
        ```
    - docker/Dockerfile
        ```bash
        CMD ["python3", "app.py"]
        ```
 - 使用 PM2 管理 Process
    - 專案結構
        ```bash
        .
        ├── app
        │   ├── Blueprints
        │   ├── Controllers
        │   └── Model
        ├── app.py
        ├── docker
        │   ├── docker-compose.yml
        │   ├── Dockerfile
        │   ├── LICENSE
        │   ├── README.md
        │   ├── requirements.txt
        │   └── travis-build.sh
        └── ecosystem.config.js
        ```
    - docker/Dockerfile
        ```bash
        CMD ["pm2-runtime", "start", "ecosystem.config.js"]
        ```