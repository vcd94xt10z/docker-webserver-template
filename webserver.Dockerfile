# Atenção! Verificar se as pastas mapeadas no container tem permissão total!
FROM fedora:latest

# configuração de proxy
ARG proxy_host=192.168.10.3
ARG proxy_port=3128
ARG proxy_user=fulano
ARG proxy_password=123

# proxy dnf
#RUN echo "proxy=http://$proxy_host:$proxy_port" >> /etc/dnf/dnf.conf
#RUN echo "proxy_username=$proxy_user" >> /etc/dnf/dnf.conf
#RUN echo "proxy_password=$proxy_password" >> /etc/dnf/dnf.conf

# atualizando o dnf
RUN dnf update -y

# instalações dnf
RUN dnf install -y \
	&& htop psmisc supervisor composer iputils findutils ncurses wget nano langpacks-pt_BR jpegoptim pngquant \
	&& httpd mod_ssl nodejs mysql python-requests python-gevent python3*certbot* \
	&& php php-mbstring php-pdo php-mysqlnd php-pdo-dblib php-mongodb php-bcmath php-json php-opcache php-xml php-soap php-zip php-xdebug
	
# configurações de proxy (outros gerenciadores)
#RUN pip install --proxy http://$proxy_user:$proxy_passoword@$proxy_host:$proxy_port
#RUN npm config set proxy http://$proxy_host:$proxy_port
#RUN npm config set https-proxy http://$proxy_host:$proxy_port

# configurações
RUN echo "IncludeOptional /webserver/vhosts/*.conf" >> /etc/httpd/conf/httpd.conf
COPY ./webserver/ssl/localhost/localhost.crt /etc/pki/tls/certs/localhost.crt
COPY ./webserver/ssl/localhost/localhost.key /etc/pki/tls/private/localhost.key
COPY ./webserver/ssl/localhost/server-chain.crt /etc/pki/tls/certs/server-chain.crt
RUN sed -i '/SSLCertificateChainFile /etc/pki//s/^#//g' /etc/httpd/conf.d/ssl.conf
RUN echo "/webserver/config/hosts" >> /etc/hosts
RUN mkdir /run/php-fpm/
COPY ./webserver/conf/99-myphp.ini /etc/php.d/99-myphp.ini
COPY ./webserver/letsencrypt/ /etc/letsencrypt/
RUN ln -s /webserver/scripts/util/service.sh /usr/bin/service

# dependencias python
RUN pip install suds-jurko zeep grequests unidecode pymysql

# limpando dnf
RUN dnf clean all

# processo principal
CMD ["supervisord","-c","/webserver/conf/supervisord.conf"]