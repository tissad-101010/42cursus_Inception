# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tissad <tissad@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/03/17 19:17:03 by tissad            #+#    #+#              #
#    Updated: 2025/03/17 21:32:56 by tissad           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#******************************************************************************#
#                         STATIC APP WITH CADDY                                #
#******************************************************************************#

# use the alpine image
FROM alpine:3.20

# Install Caddy
RUN apk add --no-cache caddy

# Set the working directory
WORKDIR /var/www/html

# Copy the Caddyfile
COPY ./conf/Caddyfile.conf /etc/caddy/Caddyfile

# Copy the entrypoint.sh file
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

#port
EXPOSE 8080

# Execute the entrypoint.sh file
ENTRYPOINT ["/entrypoint.sh"]
# ***************************************************************************** #