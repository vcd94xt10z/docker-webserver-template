#!/bin/bash

# Executar script como root!
# Configuração de vhost
#SSLEngine on
#SSLProtocol all -SSLv2 -SSLv3
#SSLCipherSuite ALL:!DH:!EXPORT:!RC4:+HIGH:+MEDIUM:!LOW:!aNULL:!eNULL
#SSLCertificateFile /etc/letsencrypt/live/meudominio.com/cert.pem
#SSLCertificateKeyFile /etc/letsencrypt/live/meudominio.com/privkey.pem
#SSLCertificateChainFile /etc/letsencrypt/live/meudominio.com/fullchain.pem

# ações possíveis: gerar, renovar
ACTION=$1
DOMAIN=$2
CONTAINER=web-container
PACKAGE_MANAGER=dnf

gerar(){
	docker exec -it $CONTAINER $PACKAGE_MANAGER install python3*certbot* -y
	docker exec -it $CONTAINER certbot certonly --manual -d $DOMAIN -d *.$DOMAIN --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory	
	
	# copiando dados gerados
	docker exec -it $CONTAINER cp -a /etc/letsencrypt/. /webserver/letsencrypt
}

renovar(){
	docker exec -it $CONTAINER $PACKAGE_MANAGER install python3*certbot* -y
	docker exec -it $CONTAINER certbot renew --no-self-upgrade
	
	# copiando dados gerados
	docker exec -it $CONTAINER cp -a /etc/letsencrypt/. /webserver/letsencrypt
}

case $ACTION in
gerar)
	gerar
;;
renovar)
	renovar
;;
esac
