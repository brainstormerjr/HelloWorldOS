# Hosting this site using Docker and Docker-Compose
## Building the image
```Bash
# Build image
docker build -t "brainstormerjr/hello-world-os:latest" .
# Push image to DockerHub
docker push "brainstormerjr/hello-world-os:latest"
```

## Hosting the site
```Bash
# Pull / clone repository from github
git clone https://github.com/brainstormerjr/HelloWorldOS.git
cd HelloWorldOS
# Pull docker image for hosting
sudo docker pull "brainstormerjr/hello-world-os:latest"
# Hosting using docker-compose
sudo docker-compose up -d
```