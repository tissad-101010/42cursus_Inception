# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    host_setup.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tissad <tissad@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/14 15:07:01 by tissad            #+#    #+#              #
#    Updated: 2025/03/17 23:00:21 by tissad           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# Choix du fichier (par défaut .env)
env_file=${1:-"$HOME/inception/srcs/.env"}

env_local_file=${1:-"$HOME/local/env/.env"}


if [ ! -f $env_file ]; then
	if [ -f $env_local_file ]; then
		cp -f $env_local_file $env_file
		echo "[HOST_SETUP]Copy $env_local_file into $env_file"
	else
		echo "[HOST_SETUP]Error: $env_local_file not found, set $env_file please !"
		exit 1
	fi
fi

if [ -f $env_file ]; then
	export $(grep '^HOST_' "$env_file" | xargs)
	echo "[HOST_SETUP]Load the environment variables from $env_file"
else
	echo "[HOST_SETUP]Error: set $env_file !"
	exit 1
fi

ssl_dir_path=$HOME/$HOST_SSL_DIR
ssl_commun_name=$HOST_LOGIN$HOST_DOMAIN

secrets_dir_path=$HOME/$HOST_SECRETS_PATH
secrets_local_dir_path=$HOME/$HOST_LOCAL_SECRETS_PATH

if [ ! -d $secrets_dir_path ]; then
	cp -f -r $secrets_local_dir_path $secrets_dir_path
	echo "[HOST_SETUP]Copying secrets files"
else
	echo "[HOST_SETUP]$secrets_dir_path exist!"
fi

if [ ! -d $secrets_dir_path ]; then
	echo "[HOST_SETUP]$secrets_dir_path not found!"
	exit 1
fi

#gerate SSL certificate
mkdir -p $ssl_dir_path
if [ ! -f $ssl_dir_path/$HOST_SSL_CERT ]; then
    echo "[HOST_SETUP]Generate SSL certificate for $ssl_commun_name"
    openssl req -x509 -nodes -days $HOST_SSL_DAYS -newkey rsa:2048\
        -keyout $ssl_dir_path/$HOST_SSL_KEY -out $ssl_dir_path/$HOST_SSL_CERT \
        -subj "/C=$HOST_SSL_COUNTRY/ST=$HOST_SSL_STATE/L=$HOST_SSL_LOCALITY \
                /O=$HOST_SSL_ORG/OU=$HOST_SSL_OU/CN=$ssl_commun_name" >> ./infos.log 2>&1
else
    echo "[HOST_SETUP]SSL certificate already generated"
fi


if [ -f $ssl_dir_path/$HOST_SSL_CERT ]; then
    chmod 600 $ssl_dir_path/$HOST_SSL_CERT $ssl_dir_path/$HOST_SSL_KEY
    echo "[HOST_SETUP]SSL certificate generated in $ssl_dir_path"
else
    echo "[HOST_SETUP]Error: SSL certificate not generated"
    exit 1
fi

# create lacal volume repository
#wordpress volume
if [ ! -d $HOME/$HOST_WEB_VOLUME ]; then
    echo "[HOST_SETUP]Create local volume repository $HOME/$HOST_WEB_VOLUME "
    mkdir -p $HOME/$HOST_WEB_VOLUME
else
    echo "[HOST_SETUP]Local volume repository $HOME/$HOST_WEB_VOLUME already exist"
fi
#mariaDB volume
if [ ! -d $HOME/$HOST_MARIADB_VOLUME ]; then
    echo "[HOST_SETUP]Create local volume repository $HOME/$HOST_MARIADB_VOLUME "
    mkdir -p $HOME/$HOST_MARIADB_VOLUME
else
    echo "[HOST_SETUP]Local volume repository $HOME/$HOST_MARIADB_VOLUME already exist"
fi
#grafana volume
if [ ! -d $HOME/$HOST_GRAFANA_VOLUME ]; then
    echo "[HOST_SETUP]Create local volume repository $HOME/$HOST_GRAFANA_VOLUME "
    mkdir -p $HOME/$HOST_GRAFANA_VOLUME
else
    echo "[HOST_SETUP]Local volume repository $HOME/$HOST_GRAFANA_VOLUME already exist"
fi
#statc website volume
if [ ! -d $HOME/$HOST_STATIC_WEB_VOLUME ]; then
    echo "[HOST_SETUP]Create local volume repository $HOME/$HOST_STATIC_WEB_VOLUME "
    mkdir -p $HOME/$HOST_STATIC_WEB_VOLUME
else
    echo "[HOST_SETUP]Local volume repository $HOME/$HOST_STATIC_WEB_VOLUME already exist"
fi
