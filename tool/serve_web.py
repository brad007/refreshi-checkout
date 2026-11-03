"""Serves the Flutter web build, falling back to index.html so deep links work.

The app uses path URLs (/orders/ord_123). A plain static server would 404 on a
refresh or a pasted link; this serves index.html for any path that isn't a file.

Usage: python3 tool/serve_web.py [buildDir] [port]
"""
import http.server
import os
import sys

root = sys.argv[1] if len(sys.argv) > 1 else 'build/web'
port = int(sys.argv[2]) if len(sys.argv) > 2 else 8686


class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=root, **kwargs)

    def send_head(self):
        if not os.path.exists(self.translate_path(self.path)):
            self.path = '/index.html'
        return super().send_head()


print(f'Serving {root} on http://localhost:{port} (Ctrl+C to stop)')
http.server.ThreadingHTTPServer(('127.0.0.1', port), Handler).serve_forever()
