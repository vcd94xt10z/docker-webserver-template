FROM fedora:latest

# configuração de proxy
#ARG proxy_host=192.168.10.3
#ARG proxy_port=3128
#ARG proxy_user=fulano
#ARG proxy_password=123
 
# setando proxy
#RUN echo "proxy=http://"$proxy_host":"$proxy_port >> /etc/dnf/dnf.conf \
# && echo "proxy_username="$proxy_user >> /etc/dnf/dnf.conf \
# && echo "proxy_password="$proxy_password >> /etc/dnf/dnf.conf

# gerenciadores adicionais que precisam de proxy
RUN dnf install -y python nodejs
# RUN pip install --proxy http://$proxy_user:$proxy_passoword@$proxy_host:$proxy_port pacote_simbolico \
#  && npm config set proxy http://$proxy_host:$proxy_port \
#  && npm config set https-proxy http://$proxy_host:$proxy_port

# instalações dnf
RUN dnf update -y && dnf install -y \
	htop psmisc supervisor composer iputils findutils ncurses wget nano langpacks-pt_BR jpegoptim pngquant \
	httpd mod_ssl mysql python-requests python-gevent python3*certbot* \
	php php-mbstring php-pdo php-mysqlnd php-pdo-dblib php-mongodb php-bcmath php-json php-opcache php-xml \
	php-soap php-zip php-xdebug php-redis \
 && dnf clean all \
 && pip install suds-jurko zeep grequests unidecode pymysql
 
# configurações
RUN echo "IncludeOptional /webserver/vhosts/*.conf" >> /etc/httpd/conf/httpd.conf \
 && sed -i '/SSLCertificateChainFile /etc/pki//s/^#//g' /etc/httpd/conf.d/ssl.conf \
 && mkdir /run/php-fpm/ \
 && ln -s /webserver/scripts/util/service.sh /usr/bin/service
 
# copiando arquivos
COPY ./webserver/ssl/localhost/localhost.crt /etc/pki/tls/certs/localhost.crt
COPY ./webserver/ssl/localhost/localhost.key /etc/pki/tls/private/localhost.key
COPY ./webserver/ssl/localhost/server-chain.crt /etc/pki/tls/certs/server-chain.crt
COPY ./webserver/conf/99-myphp.ini /etc/php.d/99-myphp.ini
COPY ./webserver/letsencrypt/ /etc/letsencrypt/

# processo principal
CMD ["supervisord","-c","/webserver/conf/supervisord.conf"]