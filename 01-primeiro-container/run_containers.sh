#!/bin/bash

echo "### Baixando imagem"
docker pull nginx
echo "### Executando container"
docker container run --name=meu-servidor -d -p 8080:80 nginx
echo "### Listando containers ativos"
docker container ls
echo "### Parando e removendo container"
docker container stop meu-servidor && docker container rm meu-servidor
echo "### Listando todos os containers"
docker container ls -a
