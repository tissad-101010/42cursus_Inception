# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tissad <tissad@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/18 16:43:14 by tissad            #+#    #+#              #
#    Updated: 2025/02/28 15:31:00 by tissad           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
#                                VSFTPD                                        #
# **************************************************************************** #
# use the alpine image
FROM alpine:3.20

# Install vsftpd
RUN apk add --no-cache vsftpd \
	&& rm -fr /etc/vsftpd/*
	
# Copy the configuration file
COPY ./conf/vsftpd.conf /etc/vsftpd/

# Copy the entrypoint.sh file
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Execute the entrypoint.sh file
ENTRYPOINT ["/entrypoint.sh"]
# ***************************************************************************** #
