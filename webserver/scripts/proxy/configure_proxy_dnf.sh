#!/bin/bash

FILE=/etc/dnf/dnf.conf

clear

# removendo configuração anterior
sed --in-place '/proxy=/d' $FILE
sed --in-place '/proxy_username=/d' $FILE
sed --in-place '/proxy_password=/d' $FILE

echo "Script de Configuração do Proxy"

read -p 'Usuario: ' usuario
read -sp 'Senha: ' senha
echo
read -p 'Host: ' host
read -p 'Porta: ' porta

echo "proxy=http://"$host":"$porta >> $FILE
echo "proxy_username="$usuario >> $FILE
echo "proxy_password="$senha >> $FILE

echo "Configurações gravadas no arquivo "$FILE