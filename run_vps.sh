#!/bin/bash
if [ ! -f "cloudflared" ]; then
    wget -q -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
    chmod +x cloudflared
fi

echo 'from http.server import SimpleHTTPRequestHandler
from socketserver import TCPServer
class MyHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"ALIVE")
TCPServer(("", 8000), MyHandler).serve_forever()' > keep_alive.py

nohup python3 keep_alive.py > /dev/null 2>&1 &

if command -v gh &> /dev/null; then
    gh codespace ports visibility 8000:public -c $CODESPACE_NAME
fi

./cloudflared tunnel --url ssh://localhost:22 --logfile cloudflared.log > /dev/null 2>&1 &

echo "LOADING..."
sleep 5
echo "SSH LINK (TERMUX):"
grep -o 'https://.*\.trycloudflare.com' cloudflared.log
echo "MONITOR LINK (UPTIMEROBOT):"
echo "https://${CODESPACE_NAME}-8000.app.github.dev"
echo "PASSWORD: admin123"
