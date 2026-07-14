#!/bin/bash

# ==========================================
# Backup Script  WordPress + MySQL
# ==========================================

BACKUP_DIR="/var/backups/wordpress"
DATE=$(date +"%Y-%m-%d_%H-%M")
DB_USER="wp_user"
DB_PASS="PasswordMySQL"
DB_NAME="wordpress"

DB_FILE="$BACKUP_DIR/db_$DATE.sql"
WWW_FILE="$BACKUP_DIR/www_$DATE.tar.gz"

# 1. Database dump (with the flag to bypass the PROCESS permission error)
mysqldump --no-tablespaces -u$DB_USER -p$DB_PASS $DB_NAME > $DB_FILE

# 2. Backup directory /var/www html (site + wordpress)
tar -czf $WWW_FILE -C /var/www html

# 3. Securing files and rotation
chmod 600 $DB_FILE $WWW_FILE
find $BACKUP_DIR -type f -mtime +7 -delete
