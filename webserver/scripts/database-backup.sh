#!/bin/bash

# Script de Backup Rotativo por 7 dias

WEEKDAY=$(date +%A)
DIR_DEST="/webserver/backup/"
LOGFILE=/webserver/log/database-backup.log
date_format='+%d/%m/%Y-%H:%M:%S'

backup(){
	echo "Backup iniciado"

	echo $(date $date_format)": Backup do schema iniciado" >> $LOGFILE
	mysqldump -u root -p123456 -hdb --comments --default-character-set=utf8 --dump-date --hex-blob --lock-tables=FALSE --max_allowed_packet=500M --net_buffer_length=108576 --all-databases > ${DIR_DEST}backup.sql

	echo $(date $date_format)": Compactando backup" >> $LOGFILE

	cd ${DIR_DEST}
	tar -czvf ${WEEKDAY}.tar.gz backup.sql
	rm -rf backup.sql

	echo $(date $date_format)": Backup finalizado" >> $LOGFILE
	echo "Backup finalizado"
}

send_to_cloud(){
	# colocar aqui o comando para enviar para a nuvem

	# gdrive
	# o comando 'gdrive list' deve ser executado na primeira vez para autorização	
	# gdrive upload ${DIR_DEST}${WEEKDAY}.tar.gz
	
	# dropbox
}

backup
send_to_cloud