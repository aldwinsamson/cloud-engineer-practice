from http.server import HTTPServer, BaseHTTPRequestHandler
import json
import os
import socket

APP_VERSION = "1.1.0"
APP_ENV = os.environ.get("APP_ENV", "development")

class AppHandler(BaseHTTPRequestHandler):

    def log_message(self, format, *args):
        print(f"[{self.log_date_time_string()}] {format % args}")

    def do_GET(self):
        if self.path == "/health":
            self.handle_health()
        elif self.path == "/info":
            self.handle_info()
        else:
            self.handle_home()

    def handle_health(self):
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        self.end_headers()
        response = {"status": "unhealthy", "version": APP_VERSION}
        self.wfile.write(json.dumps(response).encode())

    def handle_info(self):
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        self.end_headers()
        response = {
            "version": APP_VERSION,
            "environment": APP_ENV,
            "hostname": socket.gethostname()
        }
        self.wfile.write(json.dumps(response).encode())

    def handle_home(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        html = f"""
        <html>
        <head><title>Cloud App v{APP_VERSION}</title></head>
        <body style="font-family:Arial;max-width:600px;margin:50px auto;padding:20px">
            <h1>Cloud Engineering Practice App</h1>
            <table border="1" cellpadding="10" style="border-collapse:collapse">
                <tr><td><b>Version</b></td><td>{APP_VERSION}</td></tr>
                <tr><td><b>Environment</b></td><td>{APP_ENV}</td></tr>
                <tr><td><b>Hostname</b></td><td>{socket.gethostname()}</td></tr>
            </table>
            <p>Endpoints: <a href="/health">/health</a> | <a href="/info">/info</a></p>
        </body>
        </html>
        """
        self.wfile.write(html.encode())

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    server = HTTPServer(("0.0.0.0", port), AppHandler)
    print(f"Starting server version {APP_VERSION} on port {port}")
    print(f"Environment: {APP_ENV}")
    server.serve_forever()