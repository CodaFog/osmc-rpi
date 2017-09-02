## osmc-rpi Dockerfile

This repository contains **Dockerfile** of a dockerized [OSMC](https://osmc.tv).
It's really experimental, don't expect a real working OSMC version.

### Installation

1. Install [Docker](https://www.docker.com/) on your Raspberry pi.

2. Create the directory used to store the kodi configuration files :

    mkdir -p /home/pi/osmc-rpi/config

3. You can define a specific volume where Kodi can access :

    /home/pi/osmc-rpi/data

### Usage
```
        docker run -it --name osmc-rpi --device="/dev/tty1" --device="/dev/fb0" --device="/dev/input" \
      --device="/dev/snd" --device="/dev/vchiq" \
      -v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro \
      -v /home/pi/osmc-rpi/config:/config/kodi  -v /home/pi/osmc-rpi/data:/data \
      --net=host "codafog/osmc-rpi:${OSMC_VERSION}"
```

### Building images

1. Install [Docker](https://www.docker.com/) on your Raspberry pi.

2. Clone the Git 
```
    git clone https://github.com/CodaFog/osmc-rpi.git
```
3. Execute the script that download and build the OSMC base image. You can choose your version with the OSMC_VERSION variable in the script :
```
    cd osmc-rpi
    chmod +x ./create_base_image.sh
    ./create_base_image.sh
    docker images
```
4. Build the new image based on your version :
```
    OSMC_VERSION=20170803
    docker build -t "codafog/osmc-rpi:${OSMC_VERSION}" --build-arg OSMC_VERSION=${OSMC_VERSION} .
```
5. Start your new OSMC container :
```
    docker run -it --name osmc-rpi --device="/dev/tty1" --device="/dev/fb0" --device="/dev/input" \
      --device="/dev/snd" --device="/dev/vchiq" \
      -v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro \
      -v /home/pi/osmc/config:/config/kodi  -v /home/pi/osmc/data:/data \
      --net=host "codafog/osmc-rpi:${OSMC_VERSION}"
```
6. Enjoy playing with OSMC.

### Github

Github : https://github.com/CodaFog/osmc-rpi
