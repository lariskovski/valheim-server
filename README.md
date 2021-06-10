# Valheim Server

## How-To

### Infra Provisioning

- Create bucket (valheim-world-backup)

- Create Service Account (SA) with GCS admin

- Creave VM with said SA permissions, example:

~~~~
gcloud beta compute --project=the-valheim-server instances create valheim-server --zone=us-central1-a --machine-type=e2-medium --subnet=default --network-tier=PREMIUM --maintenance-policy=MIGRATE --scopes=https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/trace.append,https://www.googleapis.com/auth/devstorage.read_write --tags=valheim --image=ubuntu-2004-focal-v20210510 --image-project=ubuntu-os-cloud --boot-disk-size=20GB --boot-disk-type=pd-balanced --boot-disk-device-name=valheim-server --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=app=valheim --reservation-affinity=any
~~~~

- Create firewall inbound rule for 2456 udp, 2457 udp

### Server Config and Install

- Update OS packages:

~~~~
sudo apt update
~~~~

- Create sudoer user steam with home /home/steam:

~~~~
sudo useradd steam --create-home --shell /bin/bash
sudo usermod -aG google-sudoers steam
~~~~

- Create dir for valheim server:

~~~~~
mkdir -p /home/steam/valheim
~~~~

- Install Docker

~~~~
curl https://get.docker.com | sh
~~~~

- Enable and Start Docker

~~~~
sudo systemctl enable docker
sudo systemctl start docker
~~~~

- Run the Valheim server container:

~~~~
sudo docker run -d --restart always\
    --name valheim-server \
    --cap-add=sys_nice \
    --stop-timeout 120 \
    -p 2456-2457:2456-2457/udp \
    -v $HOME/valheim/config:/config \
    -v $HOME/valheim/data:/opt/valheim \
    -e SERVER_NAME="Only Bearded Vikings Allowed" \
    -e WORLD_NAME="The Viking Zone" \
    -e SERVER_PASS="super-secret" \
    lloesche/valheim-server
~~~~

- Set cron job to sync data and bucket with versioning for 3 days

~~~~
(crontab -l ; echo "0,30 * * * * gsutil -m rsync -d -r /home/steam/valheim/config/backups gs://valheim-world-backup/backups &>> /home/steam/valheim/cron-backup.logs") | crontab -
~~~~
