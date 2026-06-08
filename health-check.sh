#!/bin/bash

echo "=========================================="
echo "    SERVER HEALTH CHECK"
echo "    Date: $(date)"
echo "    Server: $(hostname)"
echo "=========================================="

echo ""
echo "[ DISK USAGE ]"
df -h /

echo ""
echo "[ MEMORY USAGE ]"
free -m

echo ""
echo "[ RUNNING SERVICES ]"
systemctl is-active nginx && echo "nginx: running" || echo "nginx: stopped"
systemctl is-active sshd && echo "sshd: running" || echo "sshd: stopped"

echo ""
echo "=========================================="
echo "Health check complete."
echo "=========================================="