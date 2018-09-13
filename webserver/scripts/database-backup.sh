#!/bin/bash

# Script de Backup Rotativo por 7 dias

WEEKDAY=$(date +%A)
DIR_DEST_HOST="/docker-webserver/webserver/backup/"
DIR_DEST_CONTAINER="/webserver/backup/"
LOGFILE=/docker-webserver/webserver/log/database-backup.log
date_format='+%d/%m/%Y-%H:%M:%S'

backup(){
	echo "Backup iniciado"

	echo $(date $date_format)": Backup do schema iniciado" >> $LOGFILE
	docker exec -it web-container mysqldump -u root -p123456 -hdb --comments --default-character-set=utf8 --dump-date --hex-blob --lock-tables=FALSE --max_allowed_packet=500M --net_buffer_length=108576 --all-databases > ${DIR_DEST_CONTAINER}backup.sql

	echo $(date $date_format)": Compactando backup" >> $LOGFILE

	cd ${DIR_DEST_HOST}
	tar -czvf ${WEEKDAY}.tar.gz backup.sql
	rm -rf backup.sql

	echo $(date $date_format)": Backup finalizado" >> $LOGFILE
	echo "Backup finalizado"
}

send_to_cloud(){
	# colocar aqui o comando para enviar para a nuvem

	# gdrive (Google Drive)
	# 1) Na primeira vez, um link simbolico deve ser criado no binario do gdrive para deixar global no Linux
	# ln -s /webserver/bin/gdrive /usr/bin/gdrive
	#
	# 2) O comando 'gdrive list' deve ser executado na primeira vez para fazer o processo de autorização
	# gdrive list
	#
	# 3) no comando gdrive list é exibido o id do diretório, que deve ser usado no comando para upload
	# gdrive upload --parent 1Cv7K7Dxl9LdMwcSm7rExfeEUjz7d87rX ${DIR_DEST_HOST}${WEEKDAY}.tar.gz
}

backup
send_to_cloud