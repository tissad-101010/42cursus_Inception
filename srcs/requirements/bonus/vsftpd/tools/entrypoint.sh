#!/bin/sh

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tissad <tissad@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/20 19:49:52 by tissad            #+#    #+#              #
#    Updated: 2025/02/20 19:49:58 by tissad           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
#                        VSFTPD ENTRYPOINT SCRIPT                              #
# **************************************************************************** #

# Exit immediately if a command exits with a non-zero status.
set -e

echo "[📁 ENTRYPOINT: ⚙️  Configuration of vsftpd]"

# Get the FTP user password from the secret file
ftp_user_pw=$(cat $FTP_USER_PASSWORD_FILE)

# Check if the FTP user already exists
if [ ! -d "$FTP_USER_HOME" ]; then
	# Create the FTP user
	echo "[📁 ENTRYPOINT: ⚙️  Creating FTP user $FTP_USER]"
	adduser -h $FTP_USER_HOME -s /sbin/nologin -D $FTP_USER
	echo "[📁 ENTRYPOINT: ⚙️  Setting password for FTP user $FTP_USER]"
	echo "$FTP_USER:$ftp_user_pw" | chpasswd 
	echo "[📁 ENTRYPOINT: ⚙️  Creating FTP user $FTP_USER_HOME directory]"
	mkdir -p "$FTP_USER_HOME"
	chown -R "$FTP_USER:$FTP_USER" "$FTP_USER_HOME"
	chmod 755 "$FTP_USER_HOME"
	touch "$FTP_USER_CHROOT"
	echo "$FTP_USER" > "$FTP_USER_CHROOT"
	echo "[📁 ENTRYPOINT: ✅  FTP user $FTP_USER created successfully]"
else
    echo "[📁 ENTRYPOINT: ✅  FTP user $FTP_USER already exists]"
fi

vsftpd_ip=$(ip a|grep -A 3 'eth0'|grep 'inet '|awk '{print $2}'|cut -d'/' -f1)


echo "[📁 ENTRYPOINT: ▶️  Starting vsftpd on $vsftpd_ip]"
exec vsftpd /etc/vsftpd/vsftpd.conf
# **************************************************************************** #
