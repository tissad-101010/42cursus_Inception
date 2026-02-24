#!/bin/sh

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tissad <tissad@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/20 19:10:06 by tissad            #+#    #+#              #
#    Updated: 2025/02/20 19:10:54 by tissad           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
#                        MARIADB ENTRYPOINT SCRIPT                             #
# **************************************************************************** #

# Exit immediately if a command exits with a non-zero status.
set -e

echo "[🐬 ENTRYPOINT: ⚙️   Configuration of MariaDB]"
# Get the database user and password from the secrets files
mysql_password=$(cat $MYSQL_PASSWORD_FILE)
mysql_root_password=$(cat $MYSQL_ROOT_PASSWORD_FILE)

# Create the log file
touch mariadb.log
chmod +rx mariadb.log

#Create init.sql
touch /tmp/init.sql
chmod +x /tmp/init.sql

# check if database exists
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "[🐬 ENTRYPOINT: ✅  Database $MYSQL_DATABASE already exists]"
else
    echo "[🐬 ENTRYPOINT: ⚙️   Creating database $MYSQL_DATABASE]"
    # Create Database
    echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" > /tmp/init.sql

    echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' \
        IDENTIFIED BY '$mysql_password';" >> /tmp/init.sql

    echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%'\
        IDENTIFIED BY '$mysql_password';" >> /tmp/init.sql

    echo "ALTER USER 'root'@'localhost' 
        IDENTIFIED BY '$mysql_root_password';" >> /tmp/init.sql

    echo "FLUSH PRIVILEGES;" >> /tmp/init.sql
    echo "[🐬 ENTRYPOINT: ✅  Database $MYSQL_DATABASE created successfully]"

    # database initialization
    echo "[🐬 ENTRYPOINT: ⚙️   Initializing database]"
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

# Start MariaDB
echo "[🐬 ENTRYPOINT: ▶️   Starting MariaDB]"
exec mysqld --user=mysql --init-file=/tmp/init.sql > /dev/null 2>&1
# **************************************************************************** #
