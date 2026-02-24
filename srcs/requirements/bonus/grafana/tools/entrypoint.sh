#! /bin/bash

echo "[🔥 ENTRYPOINT: ⚙️   Configuration of Grafana]"

# Configure Grafana
## Activate the configuration storage path to allow volume mounting to work
sed -i 's/;data =/data =/' /etc/grafana.ini
sed -i 's/;logs =/logs =/' /etc/grafana.ini
sed -i 's/;plugins =/plugins =/' /etc/grafana.ini
sed -i 's/;provisioning =/provisioning =/' /etc/grafana.ini


# Configure Grafana Admin User
## Set the admin user and password
echo "[🔥 ENTRYPOINT: ⚙️   setting up admin user $GF_SECURITY_ADMIN_USER]"
export GF_SECURITY_ADMIN_PASSWORD=$(cat $GF_SECURITY_ADMIN_PASSWORD_FILE)

# Maintenant démarrer Grafana normalement
echo "[🔥 ENTRYPOINT: 🚀 Launching Grafana Server]"

echo "[🔥 ENTRYPOINT: 🚀 Grafana is available at http://localhost:3000]"

# Launch Grafana Server
grafana-server --homepath=/usr/share/grafana --config=/etc/grafana.ini > /dev/null
