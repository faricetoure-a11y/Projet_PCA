#!/bin/bash
DATE=$(date +%Y-%m-%d-%Hh%M)
DEST="/root/Projet_PCA/backups/backup_math_info_$DATE.sql.gz"

mysqldump -u root db_universite_2026 | gzip > $DEST

echo "[$DATE] SUCCES : Sauvegarde effectuee avec Succes. " >> /root/Projet_PCA/Logs/journal.log
