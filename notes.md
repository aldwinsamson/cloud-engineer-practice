# My Cloud Engineering Notes

## AWS CLI Commands I Learned

### S3 Commands
- aws s3 ls — list all buckets
- aws s3 mb s3://bucket-name — create a bucket
- aws s3 cp file.txt s3://bucket-name/ — upload a file
- aws s3 sync folder/ s3://bucket-name/ — sync a folder
- aws s3 rm s3://bucket-name/file.txt — delete a file

### EC2 Commands
- aws ec2 describe-instances — list all instances
- aws ec2 start-instances --instance-ids i-xxx — start an instance
- aws ec2 stop-instances --instance-ids i-xxx — stop an instance

### IAM Commands
- aws iam list-users — list all users
- aws iam list-roles — list all roles

## Linux Commands I Learned

### Navigation
- pwd — show current directory
- ls -la — list all files with details
- cd /path — change directory
- cd ~ — go home

### Files
- cat file.txt — read a file
- tail -f file.txt — watch a file update live
- grep -i "error" file.txt — search inside a file
- chmod 755 script.sh — make a script executable

### Processes
- ps aux — list all processes
- top — live process view
- kill -9 PID — force stop a process

### Networking
- ping 8.8.8.8 — test connectivity
- curl http://localhost — test HTTP endpoint
- netstat -tulpn — see open ports

## Shell Scripting I Learned

- Scripts start with #!/bin/bash
- Variables: MY_VAR="value"
- Use variables with $MY_VAR
- If/else conditions with fi to close
- For loops with done to close
- Schedule scripts with crontab -e

## Work in progress - not ready yet

This section is not finished