:: Executar script como root!
:: Configuração de vhost
::SSLEngine on
::SSLProtocol all -SSLv2 -SSLv3
::SSLCipherSuite ALL:!DH:!EXPORT:!RC4:+HIGH:+MEDIUM:!LOW:!aNULL:!eNULL
::SSLCertificateFile /etc/letsencrypt/live/meudominio.com/cert.pem
::SSLCertificateKeyFile /etc/letsencrypt/live/meudominio.com/privkey.pem
::SSLCertificateChainFile /etc/letsencrypt/live/meudominio.com/fullchain.pem

@cls

:: ações possíveis: gerar, renovar
@echo off
set ACTION=%1
set DOMAIN=%2

:: switch
IF "%ACTION%"=="gerar" (
	docker exec -it web-container dnf install python3*certbot* -y
	docker exec -it web-container certbot certonly --manual -d %DOMAIN% -d *.%DOMAIN% --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory	
)

IF "%ACTION%"=="renovar" ( 
	docker exec -it web-container dnf install python3*certbot* -y
	docker exec -it web-container certbot renew --no-self-upgrade
)

pause