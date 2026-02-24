#!/bin/bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tissad <tissad@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/25 17:58:26 by tissad            #+#    #+#              #
#    Updated: 2025/02/25 17:58:31 by tissad           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
#                                 ADMINER                                      #
# **************************************************************************** #
echo "[👨 ENTRYPOINT: ⚙️  Configuration of Adminer]"
# Adminer setup
## Download adminer
if [ ! -f /var/www/html/adminer/adminer.php ]; then
	echo "[👨 ENTRYPOINT: 💾  Download Adminer]"
	wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php"\
		-O /var/www/html/adminer/adminer.php > /dev/null 2>&1
	## Add the dark theme
	wget "https://raw.githubusercontent.com/Niyko/Hydra-Dark-Theme-for-Adminer/master/adminer.css"\
		-O /var/www/html/adminer/adminer.css > /dev/null 2>&1

	if [ -f /var/www/html/adminer/adminer.php ]; then
		echo "[👨 ENTRYPOINT: ✅  Adminer downloaded]"
		chown -R www-data:www-data /var/www/html/adminer/adminer.php
		chmod 755 /var/www/html/adminer/adminer.php 
		chown -R www-data:www-data /var/www/html/adminer/adminer.css 
		chmod 755 /var/www/html/adminer/adminer.css
	else
		echo "[👨 ENTRYPOINT: ❌  Adminer not downloaded]"
		exit 1
	fi
else
	echo "[👨 ENTRYPOINT: ✅  Adminer already downloaded]"
fi
## move to the adminer directory
cd /var/www/html/adminer
## redirect to the adminer.php page
echo "<?php header('Location: /adminer.php'); ?>" > index.php
## Start the server
echo "[👨 ENTRYPOINT: ✅  Adminer is available at http://localhost:8000]"
php -S 0.0.0.0:8000 > /tmp/adminer.log 2>&1
# **************************************************************************** #