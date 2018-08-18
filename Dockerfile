FROM fedora:latest

# atualizando o dnf
RUN dnf update -y

# ferramentas básicas de gerenciamento e adminstração
RUN dnf install -y htop psmisc

# servidor web
RUN dnf install -y httpd
RUN dnf install -y mod_ssl
RUN echo "IncludeOptional /webserver/vhosts/*.conf" >> /etc/httpd/conf/httpd.conf
RUN rm -rf /etc/httpd/conf.d/ssl.conf
COPY ./webserver/ssl.conf /etc/httpd/conf.d/ssl.conf

# aplicação
RUN dnf install -y php
RUN mkdir /run/php-fpm/
RUN dnf install -y php-mbstring php-pdo php-mysqlnd php-bcmath php-json
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php.ini

# gerenciador de serviços
RUN dnf install -y supervisor

# processo principal
CMD ["supervisord","-c","/webserver/supervisord.conf"]

EXPOSE 80
EXPOSE 443