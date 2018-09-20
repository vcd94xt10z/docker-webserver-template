#!/bin/bash

FILE=/etc/apt/apt.conf

clear

# removendo configuração anterior
sed --in-place '/Acquire::http/d' $FILE

echo "Script de Configuração do Proxy"

read -p 'Usuario: ' usuario
read -sp 'Senha: ' senha
echo
read -p 'Host: ' host
read -p 'Porta: ' porta

echo 'Acquire::http::Proxy "http://'$user':'$password'@'$host':'$porta'"' >> $FILE;
echo 'Acquire::https::Proxy "https://'$user':'$password'@'$host':'$porta'"' >> $FILE;

echo "Configurações gravadas no arquivo "$FILE