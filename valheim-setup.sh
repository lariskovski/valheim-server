sudo timedatectl set-timezone America/Sao_Paulo

sudo apt update

sudo useradd steam --create-home --shell /bin/bash
# sudo usermod -aG google-sudoers steam

mkdir -p /home/steam/valheim
sudo chown steam:steam -R /home/steam

curl https://get.docker.com | sh
sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG sudo steam
sudo usermod -aG docker steam

# For a restore get the latest backup name on bucket
# and uncomment the lines below:
# chmod +x restore-backup.sh && \
# ./restore-backup.sh gs://example-world-bucket/backups/ example-worlds-00000-00000.zip

sudo docker run -d --restart always\
    --name valheim-server \
    --cap-add=sys_nice \
    --stop-timeout 120 \
    -p 2456-2457:2456-2457/udp \
    -v /home/steam/valheim/restore/worlds:/config/worlds \
    -v /home/steam/valheim/config:/config \
    -v /home/steam/valheim/data:/opt/valheim \
    -e SERVER_NAME="No Naked Vikings Allowed" \
    -e WORLD_NAME="The Vik Zon" \
    -e SERVER_PASS="" \
    lloesche/valheim-server

# (crontab -l ; echo "0,30 * * * * gsutil -m rsync -d -r /home/steam/valheim/config/backups gs://valheim-world-backup/backups-sp &>> /home/steam/valheim/cron-backup.logs") | crontab -

