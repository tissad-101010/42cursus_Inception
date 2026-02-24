# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tissad <tissad@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/21 22:35:04 by tissad            #+#    #+#              #
#    Updated: 2025/02/28 16:02:52 by tissad           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#******************************************************************************#
#                           ADMINER DOCKERFILE                                 #
#******************************************************************************#
# Set the base image to Alpine
FROM alpine:3.20
# Define the TERM environment variable
ENV TERM=xterm
# Set the working directory
WORKDIR /var/www/html/adminer
# Install PHP 8.1, PHP-FPM, PHP extensions, MariaDB client, cURL, tar, wget"
RUN apk add --no-cache php php-mysqli php-session \
    curl wget bash\
    # Create the www-data user and group
    && addgroup -S www-data || true && adduser -S -G www-data www-data || true 

# Copy the ENTRYPOINT script
COPY ./tools/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
# Expose the port 8000
EXPOSE 8000
# Execute the ENTRYPOINT script to start the PHP-FPM service    
ENTRYPOINT ["/tmp/entrypoint.sh"]
#******************************************************************************#
