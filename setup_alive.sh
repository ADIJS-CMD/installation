#!/bin/bash

sudo apt-get update -y && sudo apt-get install -y curl wget python3 git

echo 'from http.server import SimpleHTTPRequestHandler; from socketserver import TCPServer; TCPServer(("", 8000), SimpleHTTPRequestHandler).serve_forever()' > keep_alive.py

nohup python3 keep_alive.py > /dev/null 2>&1 &

if command -v gh &> /dev/null; then
    gh codespace ports visibility 8000:public -c $CODESPACE_NAME
fi

echo ""
echo "========================================================"
echo "   LINK JANTUNG BUATAN (COPY KE UPTIMEROBOT)"
echo "========================================================"
echo "https://${CODESPACE_NAME}-8000.app.github.dev"
echo "========================================================"
echo "PASANG DI UPTIMEROBOT SEKARANG (INTERVAL 5 MENIT)"
echo "========================================================"
