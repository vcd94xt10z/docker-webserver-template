#!/bin/bash

FOLDER=$(pwd)/
FOLDER_OUT=${FOLDER}out/
DAYS=99999

mkdir ${FOLDER_OUT}
cd ${FOLDER_OUT}

openssl genrsa -out ${FOLDER_OUT}server_rootCA.key 2048
openssl req -x509 -new -nodes -key ${FOLDER_OUT}server_rootCA.key -sha256 -days ${DAYS} -out ${FOLDER_OUT}server_rootCA.pem
openssl req -new -sha256 -nodes -out ${FOLDER_OUT}server.csr -newkey rsa:2048 -keyout ${FOLDER_OUT}server.key -config <( cat ${FOLDER}server_rootCA.csr.cnf )
openssl x509 -req -in ${FOLDER_OUT}server.csr -CA ${FOLDER_OUT}server_rootCA.pem -CAkey ${FOLDER_OUT}server_rootCA.key -CAcreateserial -out ${FOLDER_OUT}server.crt -days ${DAYS} -sha256 -extfile ${FOLDER}v3.ext

echo "Concluido"