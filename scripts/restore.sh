#!/bin/bash

BUCKET="hashmi-ec2-backups"

LATEST=$(aws s3 ls s3://$BUCKET/ | sort | tail -n 1 | awk '{print $4}')

aws s3 cp s3://$BUCKET/$LATEST .

tar -xzf $LATEST -C ~/aws-ec2-docker-nginx-s3-backup/

docker restart nginx-site

echo "Restored: $LATEST"
