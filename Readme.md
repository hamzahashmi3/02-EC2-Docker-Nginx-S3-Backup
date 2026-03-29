# AWS EC2 Dockerized Nginx Web Server + S3 Automated Backups

## Project Overview
This project demonstrates a modern AWS deployment using EC2, Docker, Nginx, S3, IAM, and Linux automation.

A custom static website is hosted inside a Docker container using the official Nginx image on an Ubuntu EC2 instance. Automated daily backups of the website files are created using a Bash script and uploaded securely to Amazon S3. A restore script is also included to recover the website from the latest or a specific backup.

This project highlights practical skills in cloud infrastructure, containerization, automation, backup management, and disaster recovery.


## Objectives
- Launch and configure an EC2 instance
- Use Security Groups to secure access
- Install Docker on Amazon Linux using the official method
- Build and run a custom Nginx container
- Host a live website on EC2
- Create automated S3 backups using Bash and cron
- Apply retention policy to old backups
- Restore website files from backup


## How It Works
1. A user visits the EC2 public IP in a browser
2. HTTP traffic reaches the EC2 instance through the Security Group
3. Docker runs an Nginx container that serves the custom website
4. A backup script compresses the website files into a `.tar.gz` archive
5. The archive is uploaded to an S3 bucket using the EC2 IAM role
6. Object tags are applied to each backup in S3
7. Old backups are removed automatically based on retention policy
8. A restore script can recover the latest or selected backup when needed


## Architecture Diagram

### Visual Diagram
```mermaid
flowchart TB
  U[User Browser] -->|HTTP 80| IGW[Internet]
  IGW --> SG[Security Group: HTTP 80, SSH 22 My IP]
  SG --> EC2[EC2 Ubuntu Instance]
  EC2 --> D[Docker Engine]
  D --> N[Nginx Container]
  N --> W[Static Website]
  EC2 -->|IAM Role| S3[(S3 Bucket Backups)]
  EC2 --> C[Cron Job]
  C --> B[backup.sh]
  B --> S3
  S3 --> R[restore.sh]
  R --> W
