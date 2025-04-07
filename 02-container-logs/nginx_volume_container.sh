#!/bin/bash

VOLUME_NAME=nginx_logs
CONTAINER_NAME=meu-nginx-1
NEW_CONTAINER_NAME=meu-nginx-2

echo "### Criar um volume Docker chamado \"${VOLUME_NAME}\""
docker volume create $VOLUME_NAME

echo "### Executar um contêiner nginx, montando o volume nginx_logs no dirétorio /var/log/nginx do container e expondo a página web na porta 8080 da máquina local"
docker container run --name=$CONTAINER_NAME -v $VOLUME_NAME:/var/log/nginx -d -p 8080:80 nginx

TOTAL=3
echo "### Aguardando o start do container (${TOTAL}s)"
for ((i = $TOTAL; i > 0; --i)); do
    sleep 1
    echo "${i}..."
done

echo "### Gerar logs acessando a página hospedada no nginx executando localmente o comando curl http://localhost:8080"
curl http://localhost:8080 > /dev/null

echo "### Parar e remover o contêiner \"${CONTAINER_NAME}\""
docker container stop $CONTAINER_NAME && docker container rm $CONTAINER_NAME

echo "### Criar um novo contêiner e validar que os logs antigos ainda existem"
docker container run --name=$NEW_CONTAINER_NAME -v $VOLUME_NAME:/var/log/nginx -d -p 8080:80 nginx

echo "### Logs do container \"${NEW_CONTAINER_NAME}\""
docker logs $NEW_CONTAINER_NAME