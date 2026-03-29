#!/bin/bash

BUCKET="hashmi-s3-backups"
DATE=$(date +%F-%H-%M)
BACKUP_FILE="backup-$DATE.tar.gz"

tar -czf $BACKUP_FILE ~/aws-ec2-docker-nginx-s3-backup/app

aws s3 cp $BACKUP_FILE s3://$BUCKET/

echo "Backup uploaded: $DATE"

# Retention policy: keep only last 5 backups in S3
aws s3 ls s3://$BUCKET/ | sort | head -n -5 | awk '{print $4}' | while read file; do
  aws s3 rm s3://$BUCKET/$file
done
