# List all backups
# gsutil ls -l gs://valheim-world-backup/backups | sort -k 2

export BUCKET=$1
export LATEST_BACKUP_NAME=$2

sudo apt install unzip -y

# Create dir if not exists
sudo su steam
[ -d /home/steam/valheim/config/ ] || mkdir /home/steam/valheim/config/

sudo gsutil cp $BUCKET$LATEST_BACKUP_NAME $HOME
sudo unzip $LATEST_BACKUP_NAME -d /home/steam/valheim/config/