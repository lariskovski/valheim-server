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
mkdir -p /home/steam/valheim
gcsfuse valhem-test "/home/steam/valheim"

# Run the container
# sudo docker run -d --restart always\
#     --name valheim-server \
#     --cap-add=sys_nice \
#     --stop-timeout 120 \
#     -p 2456-2457:2456-2457/udp \
#     -v /home/steam/valheim/restore/worlds:/config/worlds \
#     -v /home/steam/valheim/config:/config \
#     -v /home/steam/valheim/data:/opt/valheim \
#     -e SERVER_NAME="No Naked Vikings Allowed" \
#     -e WORLD_NAME="The Vik Zon" \
#     -e SERVER_PASS="" \
#     lloesche/valheim-server
