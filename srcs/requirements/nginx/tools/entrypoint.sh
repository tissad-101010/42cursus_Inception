#!/bin/sh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tissad <tissad@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/21 07:39:01 by tissad            #+#    #+#              #
#    Updated: 2025/02/21 07:39:08 by tissad           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
#                                NGINX ENTRYPOINT                              #
# **************************************************************************** #

# Exit immediately if a command exits with a non-zero status.
set -e

# Configuration of Nginx with the configuration file nginx.conf
echo "[🚀 ENTRYPOINT: ⚙️  Configuration of Nginx]"

#Start Nginx with the command "daemon off;" to keep the process running
echo "[🚀 ENTRYPOINT: ▶️  Starting Nginx]"
exec nginx -g "daemon off;"
