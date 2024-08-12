#! /bin/bash
DIRECTORY=/home/steam/valheim
BUCKET=valheim-server-ashlands

if [ ! -d "$DIRECTORY" ]; then
    sudo timedatectl set-timezone America/Sao_Paulo
    ## Install and setup Docker
    curl https://get.docker.com | sh
    sudo systemctl enable docker
    sudo systemctl start docker

    # # check if files exists in bucket
    # FILES=$(gsutil ls gs://$BUCKET)
    # # if exists check if file is zip
    # if [[ $file =~ \.zip$ ]]
    # then
    #     gsutil cp gs://$BUCKET/worldBackups/$FILES /tmp
    #     sudo unzip /tmp/$LATEST_BACKUP_NAME -d $DIRECTORY/config/worlds_local/
    # fi
    # if there are files and are not zip, just copy everything to worlds_local


    # Run the container
    # sudo docker run -d --restart always\
    #     --name valheim-server \
    #     --cap-add=sys_nice \
    #     --stop-timeout 120 \
    #     -p 2456-2457:2456-2457/udp \
    #     -v $DIRECTORY/restore/worlds:/config/worlds \
    #     -v $DIRECTORY/config:/config \
    #     -v $DIRECTORY/data:/opt/valheim \
    #     -e SERVER_NAME="No Naked Vikings Allowed" \
    #     -e WORLD_NAME="The Vik Zon" \
    #     -e SERVER_PASS="" \
    #     lloesche/valheim-server
    
    # Add backup cron job
    # (crontab -l ; echo "0,30 * * * * gsutil -m rsync -d -r /home/steam/valheim/config/backups gs://$BUCKET/worldBackups &>> /home/steam/valheim/cron-backup.logs") | crontab -
fi
