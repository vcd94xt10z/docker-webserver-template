#!/bin/bash

FOLDER=$(pwd)/
FOLDER_OUT=${FOLDER}out/

# não aumente mais a validade para não ocorrer problemas com o reconhecimento do certificado
# https://www.ssl.com/blogs/ssl-certificate-maximum-duration-825-days/
DAYS=825

mkdir ${FOLDER_OUT}
cd ${FOLDER_OUT}

echo "Passo 1"
openssl genrsa -out ${FOLDER_OUT}server_rootCA.key 2048

echo "Passo 2 - Informe os dados da CA"
openssl req -x509 -new -nodes -key ${FOLDER_OUT}server_rootCA.key -sha256 -days ${DAYS} -out ${FOLDER_OUT}server_rootCA.pem

echo "Passo 3"
openssl req -new -sha256 -nodes -out ${FOLDER_OUT}server.csr -newkey rsa:2048 -keyout ${FOLDER_OUT}server.key -config <( cat ${FOLDER}server_rootCA.csr.cnf )

echo "Passo 4"
openssl x509 -req -in ${FOLDER_OUT}server.csr -CA ${FOLDER_OUT}server_rootCA.pem -CAkey ${FOLDER_OUT}server_rootCA.key -CAcreateserial -out ${FOLDER_OUT}server.crt -days ${DAYS} -sha256 -extfile ${FOLDER}v3.ext

echo "Concluido"