#!/bin/bash

# 1. Recréation sécurisée de la base de données et de sa structure
mysql -u root -e "
CREATE DATABASE IF NOT EXISTS db_vault_core;
USE db_vault_core;

CREATE TABLE IF NOT EXISTS clients (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    cnib_passport VARCHAR(50) NOT NULL UNIQUE,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    telephone VARCHAR(25) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS comptes (
    id_compte INT AUTO_INCREMENT PRIMARY KEY,
    id_client INT,
    numero_compte VARCHAR(30) NOT NULL UNIQUE,
    type_compte VARCHAR(20) NOT NULL,
    solde_calcule DECIMAL(18,2) NOT NULL DEFAULT 0.00,
    FOREIGN KEY (id_client) REFERENCES clients(id_client) ON DELETE CASCADE
) ENGINE=InnoDB;
"

# 2. Injection du dernier backup s'il existe
BACKUP_FILE=$(ls -1t /root/Projet_PCA/Backups/*.sql 2>/dev/null | head -n 1)

if [ -f "$BACKUP_FILE" ]; then
    mysql -u root db_vault_core < "$BACKUP_FILE"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Restauration réussie depuis $BACKUP_FILE" >> /root/Projet_PCA/Logs/journal.log
else
    # Si aucun backup n'existe, on met un jeu de données par défaut pour éviter le tableau vide
    mysql -u root -e "
    USE db_vault_core;
    INSERT IGNORE INTO clients (id_client, cnib_passport, nom, prenom, telephone) VALUES (1, 'B1234567', 'Ouedraogo', 'Alimata', '+22670000000');
    INSERT IGNORE INTO comptes (id_client, numero_compte, type_compte, solde_calcule) VALUES (1, 'BF-77777', 'Courant', 250000);
    "
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Base recréée à blanc (Aucun fichier SQL trouvé)" >> /root/Projet_PCA/Logs/journal.log
fi
