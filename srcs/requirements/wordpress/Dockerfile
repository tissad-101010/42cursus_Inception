# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tissad <tissad@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/07 10:53:47 by tissad            #+#    #+#              #
#    Updated: 2025/03/17 18:13:52 by tissad           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
#                                   WORDPRESS                                  #
# **************************************************************************** #

# Use the alpine image
FROM alpine:3.20

# Create the www-data user and group
RUN  addgroup -S www-data || true && adduser -S -G www-data www-data || true 


# Install PHP , PHP-FPM, PHP extensions, MariaDB client, cURL, tar, wget"
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.20/community" >> /etc/apk/repositories
RUN apk update
RUN apk add --no-cache php php-mysqli php-phar php-fpm php-mbstring php-tokenizer 
RUN php -v

# Set the working directory
WORKDIR /var/www/html/wordpress

RUN  apk add wget tar curl redis

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 \
    && rm latest.tar.gz \
    && chown -R www-data:www-data /var/www/html/wordpress && chmod -R 755 /var/www/html/wordpress \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P \
        /usr/local/bin/ \
    && chmod +x /usr/local/bin/wp-cli.phar \
    && mv /usr/local/bin/wp-cli.phar /usr/local/bin/wp

# Copy the PHP-FPM configuration file

COPY ./conf/php-fpm.conf /etc/php83/php-fpm.conf

# Copy the ENTRYPOINT script
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the port 9000
EXPOSE 9000

# Execute the ENTRYPOINT script to start the PHP-FPM service
ENTRYPOINT ["/entrypoint.sh"]
# **************************************************************************** #
