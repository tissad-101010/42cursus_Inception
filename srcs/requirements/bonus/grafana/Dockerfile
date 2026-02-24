# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tissad <tissad@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/27 12:13:46 by tissad            #+#    #+#              #
#    Updated: 2025/03/03 23:23:39 by tissad           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#******************************************************************************#
#                                   GRAFANA                                    #
#******************************************************************************#

FROM alpine:3.20


RUN apk add --no-cache jq bash wget gpg curl
## Add Grafana repository key
RUN mkdir -p /etc/apt/keyrings/
RUN mkdir -p /etc/apt/sources.list.d/

RUN wget -q -O - https://apt.grafana.com/gpg.key \
    | gpg --dearmor | tee /etc/apt/keyrings/grafana.gpg > /dev/null

## Add Grafana repository
RUN echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main"\
    | tee -a /etc/apt/sources.list.d/grafana.list


RUN apk add --no-cache grafana

EXPOSE 3000

COPY ./tools/entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh

ENTRYPOINT ["/etc/entrypoint.sh"]
