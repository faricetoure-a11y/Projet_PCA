#!/bin/bash
DEST="/root/Projet_PCA/backups"
LOG="/root/Projet_PCA/logs/journal.log"
DATE=$(date +%Y-%m-%d_%Hh%M)
echo "---Sauvegarde lancee le $DATE---" >> $LOG
mysqldump db_universite | gzip > $DEST/backup_universite_$DATE.sql.gz
if [ $? -eq 0 ]; then
echo "[$DATE] SUCCES: Donnees securisees." >> $LOG
echo "Felicitations ! Sauvegarde reussie."
else
    echo "[$DATE] ERREUR : Echec de la sauvegarde." >> $LOG
    echo "Dommage,il y a encore une erreur."
fi
