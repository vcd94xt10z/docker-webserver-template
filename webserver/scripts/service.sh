#!/bin/bash

SERVICE=$1
ACTION=$2

f_php()
{
	case $ACTION in
	stop) 
		killall php-fpm 2>/dev/null
		echo "PHP parado"
	;;
	start) 
		php-fpm -D 2>/dev/null
		echo "PHP iniciado"
	;;
	restart) 
		killall php-fpm 2>/dev/null
		echo "PHP parado"
		php-fpm -D 2>/dev/null
		echo "PHP iniciado"
	;;
	esac
}

f_httpd()
{
	case $ACTION in
	stop) 
		httpd -k stop 2>/dev/null
		echo "Apache parado"
	;;
	start) 
		httpd -k start 2>/dev/null
		echo "Apache iniciado"
	;;
	restart) 	
		httpd -k stop 2>/dev/null
		echo "Apache parado"
		httpd -k start 2>/dev/null
		echo "Apache iniciado"
	;;
	esac
}

case $SERVICE in
php) f_php ;;
httpd) f_httpd ;;
*) echo "Serviço desconhecido" ;;
esac
