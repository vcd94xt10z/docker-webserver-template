#!/bin/bash

cd /webserver/scripts/sslgen/out/

# copiando para a pasta do projeto
rm -rf /webserver/ssl/localhost/localhost.key
rm -rf /webserver/ssl/localhost/localhost.crt
rm -rf /webserver/ssl/localhost/server-chain.crt

cp server.key /webserver/ssl/localhost/localhost.key
cp server.crt /webserver/ssl/localhost/localhost.crt
cp server_rootCA.pem /webserver/ssl/localhost/server-chain.crt

# copiando para a pasta padrão do apache
rm -rf /etc/pki/tls/certs/localhost.crt
rm -rf /etc/pki/tls/private/localhost.key
rm -rf /etc/pki/tls/certs/server-chain.crt

cp /webserver/ssl/localhost/localhost.crt /etc/pki/tls/certs/localhost.crt
cp /webserver/ssl/localhost/localhost.key /etc/pki/tls/private/localhost.key
cp /webserver/ssl/localhost/server-chain.crt /etc/pki/tls/certs/server-chain.crt

# descomentando linha
sed -i '/SSLCertificateChainFile/s/^#//g' /etc/httpd/conf.d/ssl.conf

service httpd restart

echo "Concluido"