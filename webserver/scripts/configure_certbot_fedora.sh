#!/bin/bash

# Executar script como root!

# passo 1: Instalar o certbot
dnf install python3*certbot* -y

# passo 2: Gerar os certificados no sistema para que na próxima vez, a renovação seja possível
DOMAIN=meudominio.com
certbot certonly --manual -d *.$DOMAIN -d $DOMAIN --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory

# passo 3: Adicionar no final do crontab para renovar periodicamente
echo "39      1,13    *       *       *       root    certbot renew --no-self-upgrade" >> /var/spool/cron/root

# passo 4: Configurar seu vhost da seguinte forma
#SSLEngine on
#SSLProtocol all -SSLv2 -SSLv3
#SSLCipherSuite ALL:!DH:!EXPORT:!RC4:+HIGH:+MEDIUM:!LOW:!aNULL:!eNULL
#SSLCertificateFile /etc/letsencrypt/live/meudominio.com/cert.pem
#SSLCertificateKeyFile /etc/letsencrypt/live/meudominio.com/privkey.pem

