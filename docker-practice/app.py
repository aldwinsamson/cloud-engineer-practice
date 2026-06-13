from http.server import HTTPServer, BaseHTTPRequestHandler
import socket, os

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type','text/html')
        self.end_headers()
        hostname = socket.gethostname()
        environment = os.environ.get('APP_ENV','not set')
        html = f"""<html><body>
            <h1>Hello from my Docker container! Version 2</h1>
            <p>Hostname: {"{hostname}"}</p>
            <p>Environment: {"{environment}"}</p>
            <p>Path: {"{self.path}"}</p>
        </body></html>"""
        self.wfile.write(html.encode())

if __name__ == "__main__":
    server = HTTPServer(('0.0.0.0',5000), Handler)
    print("Server running on port 5000")
    server.serve_forever()