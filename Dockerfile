# Atenção! Verificar se as pastas mapeadas no container tem permissão total!
FROM fedora:latest

# configurando proxy (descomente se utilizar proxy)
#RUN echo "proxy=http://192.168.10.3:3128" >> /etc/dnf/dnf.conf
#RUN echo "proxy_username=fulano" >> /etc/dnf/dnf.conf
#RUN echo "proxy_password=123" >> /etc/dnf/dnf.conf

# atualizando o dnf
RUN dnf update -y

# ferramentas de gerenciamento e adminstração
RUN dnf install -y htop psmisc supervisor composer iputils findutils ncurses

# servidor web
RUN dnf install -y httpd mod_ssl
RUN echo "IncludeOptional /webserver/vhosts/*.conf" >> /etc/httpd/conf/httpd.conf
COPY ./webserver/ssl/localhost.crt /etc/pki/tls/certs/localhost.crt
COPY ./webserver/ssl/localhost.key /etc/pki/tls/private/localhost.key

# aplicação
RUN dnf install -y php php-mbstring php-pdo php-mysqlnd php-bcmath php-json php-opcache php-xml php-soap
RUN mkdir /run/php-fpm/
COPY ./webserver/conf/99-myphp.ini /etc/php.d/99-myphp.ini

# processo principal
CMD ["supervisord","-c","/webserver/conf/supervisord.conf"]