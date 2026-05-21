#!/bin/bash
DIR_BACKUP="/root/Projet_PCA/backups"
DIR_LOGS="/root/Projet_PCA/Logs"
DATE=$(date +%Y-%m-%d-%Hh%M)
NOM_FICHIER="backup_vault_$DATE.sql.gz"

mysqldump -u root --skip-password db_vault_core | gzip > "$DIR_BACKUP/$NOM_FICHIER"

if [ ${PIPESTATUS[0]} -eq 0 ]; then
    echo "[$DATE] SUCCÈS : Sauvegarde globale VaultSystem effectuée ($NOM_FICHIER)." >> "$DIR_LOGS/journal.log"
else
    echo "[$DATE] ÉCHEC : Alerte critique sur la sauvegarde VaultSystem." >> "$DIR_LOGS/journal.log"
fi
