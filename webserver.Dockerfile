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

# ferramentas de gerenciamento e adminstração
RUN dnf install -y htop psmisc supervisor composer iputils findutils ncurses wget nano langpacks-pt_BR jpegoptim pngquant

# servidor web
RUN dnf install -y httpd mod_ssl
RUN echo "IncludeOptional /webserver/vhosts/*.conf" >> /etc/httpd/conf/httpd.conf
COPY ./webserver/ssl/localhost/localhost.crt /etc/pki/tls/certs/localhost.crt
COPY ./webserver/ssl/localhost/localhost.key /etc/pki/tls/private/localhost.key
COPY ./webserver/ssl/localhost/server-chain.crt /etc/pki/tls/certs/server-chain.crt

# descomentar linha
RUN sed -i '/SSLCertificateChainFile /etc/pki//s/^#//g' /etc/httpd/conf.d/ssl.conf

# aplicação
RUN dnf install -y php php-mbstring php-pdo php-mysqlnd php-pdo-dblib php-mongodb php-bcmath php-json php-opcache php-xml php-soap php-zip php-xdebug
RUN mkdir /run/php-fpm/
COPY ./webserver/conf/99-myphp.ini /etc/php.d/99-myphp.ini

# python
RUN dnf install -y python-requests python-gevent
#RUN pip install --proxy http://$proxy_user:$proxy_passoword@$proxy_host:$proxy_port 
RUN pip install suds-jurko zeep grequests unidecode pymysql

# nodejs
RUN dnf install -y nodejs
#npm config set proxy http://$proxy_host:$proxy_port
#npm config set https-proxy http://$proxy_host:$proxy_port

# ferramenta para backup do banco
RUN dnf install -y mysql

# deixando alguns scripts globais
RUN ln -s /webserver/scripts/util/service.sh /usr/bin/service

# letsencrypt
RUN dnf install python3*certbot* -y
COPY ./webserver/letsencrypt/ /etc/letsencrypt/

# limpando dnf
RUN dnf clean all

# processo principal
CMD ["supervisord","-c","/webserver/conf/supervisord.conf"]