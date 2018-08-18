# Atenção! Verificar se as pastas mapeadas no container tem permissão total!
FROM fedora:latest

# atualizando o dnf
RUN dnf update -y

# ferramentas básicas de gerenciamento e adminstração
RUN dnf install -y htop psmisc

# servidor web
RUN dnf install -y httpd
RUN dnf install -y mod_ssl
RUN echo "IncludeOptional /webserver/vhosts/*.conf" >> /etc/httpd/conf/httpd.conf
COPY ./webserver/ssl/localhost.crt /etc/pki/tls/certs/localhost.crt
COPY ./webserver/ssl/localhost.key /etc/pki/tls/private/localhost.key

# aplicação
RUN dnf install -y php
RUN mkdir /run/php-fpm/
RUN dnf install -y php-mbstring php-pdo php-mysqlnd php-bcmath php-json
COPY ./webserver/conf/99-myphp.ini /etc/php.d/99-myphp.ini

# gerenciador de serviços
RUN dnf install -y supervisor

# processo principal
CMD ["supervisord","-c","/webserver/conf/supervisord.conf"]