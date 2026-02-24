# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tissad <tissad@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/07 10:45:50 by tissad            #+#    #+#              #
#    Updated: 2025/03/24 16:22:01 by tissad           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
#                           MARIADB DOCKERFILE                                 #
# **************************************************************************** #
# Use the alpine image as base image
FROM alpine:3.20

# Install MariaDB and create a new user and group
RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils \
    && mkdir -p /run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Copy configuration file
COPY ./conf/mysql.conf /etc/my.cnf


# Copy entrypoint.sh file
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


# Expose the port 3306
EXPOSE 3306


# Execute the entrypoint.sh file
ENTRYPOINT ["/entrypoint.sh"]
# **************************************************************************** #

