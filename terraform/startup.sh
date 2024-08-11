#! /bin/bash
DIRECTORY=/home/steam/valheim
if [ ! -d "$DIRECTORY" ]; then
    sudo timedatectl set-timezone America/Sao_Paulo
    ## Install and setup Docker
    curl https://get.docker.com | sh
    sudo systemctl enable docker
    sudo systemctl start docker

    # Install and setup FUSE
    # https://cloud.google.com/storage/docs/gcsfuse-quickstart-mount-bucket
    export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
    echo "deb https://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    sudo apt-get update && sudo apt-get install fuse gcsfuse -y
    # remember to add SA permission to read and write to the bucket before the next steps
    mkdir -p $DIRECTORY
    gcsfuse  --implicit-dirs valheim-server-ashlands "$DIRECTORY"

    # Run the container
    # sudo docker run -d --restart always\
    #     --name valheim-server \
    #     --cap-add=sys_nice \
    #     --privileged \
    #     --stop-timeout 120 \
    #     -p 2456-2457:2456-2457/udp \
    #     -v $DIRECTORY/restore/worlds:/config/worlds \
    #     -v $DIRECTORY/config:/config \
    #     -v $DIRECTORY/data:/opt/valheim \
    #     -e SERVER_NAME="No Naked Vikings Allowed" \
    #     -e WORLD_NAME="The Vik Zon" \
    #     -e SERVER_PASS="" \
    #     lloesche/valheim-server
fi

## ideia
# criar nfs pra /home/steam/valheim
# fazer o mount do nfs no script  de startup
# user gcsfuse pra um diretorio de backup onde sera copiado/syncado a cada 30min tudo de /home/steam/valheim (ou so da pasta de backup)
# se no bucket do gcsfuse tiver um mundo em /worlds_local cujo nome nao é helloWorld, copiar os mundos para o NFS no path /home/steam/valheim/config/worlds/_local antes do start do docker container