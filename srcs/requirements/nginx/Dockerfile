# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tissad <tissad@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/23 20:42:45 by tissad            #+#    #+#              #
#    Updated: 2025/02/28 20:14:39 by tissad           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
#                           NGINX DOCKERFILE                                   #
# **************************************************************************** #

# use the alpine image
FROM alpine:3.20

# Install Nginx
RUN apk add --no-cache nginx openssl curl \
    && rm -rf /etc/nginx/conf.d/default.conf \
    && rm -rf /usr/share/nginx/html/*\
    && rm -rf /var/www/html/*

# Copy the configuration file
COPY conf/nginx.conf /etc/nginx/

# Copy the entrypoint.sh file
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Execute the entrypoint.sh file
ENTRYPOINT [ "/entrypoint.sh" ]
# **************************************************************************** #
