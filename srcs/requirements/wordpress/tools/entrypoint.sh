#!/bin/sh

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tissad <tissad@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/20 19:49:32 by tissad            #+#    #+#              #
#    Updated: 2025/02/20 19:49:38 by tissad           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


echo "[📝 ENTRYPOINT: ⚙️  Configuration of Wordpress]"

set -e  # stop on error

## Recover password from secret file
database_password=$(cat $WORDPRESS_DB_PASSWORD_FILE)
wp_admin_password=$(cat $WORDPRESS_ADMIN_USER_PASSWORD_FILE)
wp_user_password=$(cat $WORDPRESS_USER_PASSWORD_FILE)
REDIS_HOST="redis"  # Redis container name
REDIS_PORT=6379

# Wait for MariaDB to be available
until nc -z -v -w30 mariadb 3306
do
echo "[📝 ENTRYPOINT: ⏳  Waiting for MariaDB to be available...]"
sleep 10
done
echo "[📝 ENTRYPOINT: ✅  MariaDB is available]"

mkdir -p /run/php
chown -R www-data:www-data /run/php

echo "[📝 ENTRYPOINT: 🔍  Check $WORDPRESS_WORKDIR  permissions]"
chown -R www-data:www-data $WORDPRESS_WORKDIR

if [ -z "${HTTP_HOST}" ]; then
	export HTTP_HOST="localhost"
fi
## Check if wp-config.php exists
echo "[📝 ENTRYPOINT: 🔍  Check if wp-config.php exists]"
if [ ! -f wp-config.php ] ; then
	echo "[📝 ENTRYPOINT: ⚙️  Create wp-config.php]"
	## Create wp-config.php
	wp config create \
		--dbhost=$WORDPRESS_DB_HOST \
		--dbname=$WORDPRESS_DB_NAME \
		--dbuser=$WORDPRESS_DB_USER \
		--dbpass=$database_password \
		--dbcharset=utf8 \
		--dbcollate=utf8_general_ci \
		--dbprefix=wp_ \
		--allow-root # > /dev/null 2>&1
	echo "[📝 ENTRYPOINT: ✅  wp-config.php created]"
fi

## Check if Wordpress is installed
if ! wp core is-installed --allow-root ; then
	echo "[📝 ENTRYPOINT: ⚙️  Install Wordpress]"
	## Setup Wordpress URL,Title,PATH and Admin user
	wp core install \
		--url=$WORDPRESS_URL \
		--title=$WORDPRESS_TITLE \
		--admin_user=$WORDPRESS_ADMIN_USER \
		--admin_password=$wp_admin_password \
		--admin_email=$WORDPRESS_ADMIN_USER_EMAIL \
		--skip-email \
		--allow-root #> /dev/null 2>&1
	
	echo "[📝 ENTRYPOINT: ✅	 Wordpress installed successfully]"
	echo "[📝 ENTRYPOINT: ✅	 Admin user $WORDPRESS_ADMIN_USER created]"
	## Add User
	echo "[📝 ENTRYPOINT: ⚙️  Create user $WORDPRESS_USER]"
	wp user create \
		$WORDPRESS_USER $WORDPRESS_USER_EMAIL \
		--role=contributor \
		--user_pass=$wp_user_password > /dev/null 2>&1
	echo "[📝 ENTRYPOINT: ✅	 User $WORDPRESS_USER created]"

fi

## Check if Redis is available and install Redis plugin
echo "[📝 ENTRYPOINT: 🔍  Check Redis availability]"
if redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" ping | grep -q "PONG"; then
	### Install Redis plugin
	if [ ! -d /var/www/html/wordpress/wp-content/plugins/redis-cache ]; then
		echo "[📝 ENTRYPOINT: ⚙️  Configuration Redis]"
		
		# Install Redis Object Cache
		wp plugin install redis-cache --activate --allow-root > /dev/null 2>&1

		# Redis Configuration
		wp config set WP_CACHE true --raw --allow-root > /dev/null 2>&1 # Enable Cache
		
		# Set Redis Host and Port
		wp config set WP_REDIS_HOST "$REDIS_HOST" --allow-root > /dev/null 2>&1 # host is redis container name
		wp config set WP_REDIS_PORT "$REDIS_PORT" --raw --allow-root > /dev/null 2>&1 # default port

		# Set Redis parameters
		wp config set WP_REDIS_DATABASE 0 --raw --allow-root > /dev/null 2>&1 # default database
		wp config set WP_REDIS_PASSWORD "" --allow-root > /dev/null 2>&1  # default password
		wp config set WP_REDIS_TIMEOUT 1 --raw --allow-root > /dev/null 2>&1 # default timeout
		wp config set WP_REDIS_READ_TIMEOUT 5 --raw --allow-root > /dev/null 2>&1 # default read timeout
		wp config set WP_REDIS_MAXTTL 3600 --raw --allow-root > /dev/null 2>&1  # default max ttl in seconds
		
		wp redis enable --allow-root > /dev/null 2>&1

		echo "[📝 ENTRYPOINT: ✅  Redis configuration completed]"
		# Check Redis status
		echo "[📝 ENTRYPOINT: 🔍  Check Redis status]"
		wp redis status --allow-root | grep -q "Status: Connected" 
		if [ $? -eq 0 ]; then
			echo "[📝 ENTRYPOINT: ✅  Redis is connected]"
		else
			echo "[📝 ENTRYPOINT: ❌  Redis is not connected]"
		fi
	else
		echo "[📝 ENTRYPOINT: ✅  Redis is already installed]"

	fi
else
	echo "[📝 ENTRYPOINT: ⚠️  Redis is not available]"
fi


# Démarrer PHP-FPM
echo "[📝 ENTRYPOINT: ▶️  Starting PHP-FPM https://localhost https://tissad.42.fr https://localhost:4443]"

exec php-fpm83 -F
