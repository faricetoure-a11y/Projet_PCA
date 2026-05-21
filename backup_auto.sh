#!/bin/bash

# Configuration des répertoires
BACKUP_DIR="/root/Projet_PCA/backups"
LOG_FILE="/root/Projet_PCA/Logs/journal.log"
DATE=$(date +%Y-%m-%d-%Hh%M)

# Créer les dossiers s'ils n'existent pas
mkdir -p "$BACKUP_DIR"

# Nom du fichier de sauvegarde
FILE_NAME="$BACKUP_DIR/backup_universite_$DATE.sql.gz"

# Exécution du mysqldump avec compression native
mysqldump -u root --databases db_universite_virtuelle 2>/dev/null | gzip > "$FILE_NAME"

# Vérification du succès et écriture dans le journal log du PCA
if [ $? -eq 0 ]; then
    echo "[$DATE] SUCCÈS : Sauvegarde automatique de db_universite_virtuelle effectuée ($(basename $FILE_NAME))." >> "$LOG_FILE"
else
    echo "[$DATE] ERROR : Échec de la sauvegarde automatique de db_universite_virtuelle." >> "$LOG_FILE"
fi
