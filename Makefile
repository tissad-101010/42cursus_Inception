# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tissad <tissad@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/23 20:39:05 by tissad            #+#    #+#              #
#    Updated: 2025/03/18 10:01:00 by tissad           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE_PATH=./srcs/docker-compose.yml

all: host_setup build_modatory up_modatory

bonus: host_setup build_bonus up_bonus

mondatory: host_setup build_modatory up_modatory

build_modatory:
	docker-compose -f ${DOCKER_COMPOSE_PATH} build mariadb wordpress nginx --no-cache

up_modatory:
	docker-compose -f ${DOCKER_COMPOSE_PATH} up mariadb wordpress nginx

build_bonus:
	docker-compose -f ${DOCKER_COMPOSE_PATH} build adminer grafana vsftpd redis mariadb wordpress nginx static --no-cache
up_bonus:
	docker-compose -f ${DOCKER_COMPOSE_PATH} up adminer grafana vsftpd redis mariadb wordpress nginx static
	
down :
	docker-compose -f ${DOCKER_COMPOSE_PATH} down -v

ps :
	docker-compose -f ${DOCKER_COMPOSE_PATH} ps -a

volumes :
	docker volume ls

networks :
	docker network ls

services :
	docker service ls

images :
	docker images -a

#setup the host machine, generate SSL certificates, and create volumes repositories
host_setup :
	sh ./tools/host_setup.sh

clean: down
	docker rmi -f $$(docker images -q)


clean_volumes:
	@echo "[MAKEFILE]WARNING: Removing all volumes!"
	sudo rm -rf $$(docker volume ls -q)

clean_images:
	@echo "[MAKEFILE]Removing all images!"
	docker rmi -f $$(docker images -q)

prune:
	@echo "[MAKEFILE]WARNING: Removing all volumes, images and cache!"
	sudo docker system prune -a --volumes

clean_ssl:
	@echo "[MAKEFILE]Removing all SSL certificates!"

hclean:
	@echo "[MAKEFILE]WARNING: Removing all host volumes!"
	sudo rm -rf $(HOME)/data/web_data/
	sudo rm -rf $(HOME)/data/mariadb_data/
	sudo rm -rf $(HOME)/data/grafana_data/

fclean: down hclean clean_volumes clean_images 


	

re: fclean all
	
.PHONY: ssl clean clean_volumes clean_images fclean re
