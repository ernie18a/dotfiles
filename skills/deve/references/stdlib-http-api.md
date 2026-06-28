# stdlib HTTP Server with API Endpoints (no framework)

Pattern for adding REST-style API endpoints to a static-file server using only Python stdlib, with atomic file persistence.

## Structure

```
project/
├── index.html        # static frontend (served by default)
├── styles.css
├── app.js
├── main.py           # server with inline API routes
├── uv.toml
├── DATA/
│   └── dial-state.json  # created at runtime
```

## Server with Custom Routes

```python
import json
from functools import partial
from http.server import SimpleHTTPRequestHandler
from pathlib import Path

class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *args, directory, **kwargs):
        super().__init__(*args, directory=directory, **kwargs)

    def do_GET(self):
        if self.path == "/api/state":
            self.send_response(200)
            self.send_header("Content-Type", "application/json; charset=utf-8")
            self.end_headers()
            self.wfile.write(json.dumps(load_state(), ensure_ascii=False).encode("utf-8"))
        else:
            super().do_GET()

    def do_POST(self):
        if self.path == "/api/state":
            length = int(self.headers.get("Content-Length", 0))
            body = self.rfile.read(length)
            try:
                data = json.loads(body)
                if not isinstance(data, dict):
                    raise ValueError("body must be a JSON object")
                save_state(data)
                self.send_response(200)
                self.send_header("Content-Type", "application/json; charset=utf-8")
                self.end_headers()
                self.wfile.write(json.dumps({"ok": True}, ensure_ascii=False).encode("utf-8"))
            except (json.JSONDecodeError, ValueError, OSError) as exc:
                self.send_response(400)
                self.send_header("Content-Type", "application/json; charset=utf-8")
                self.end_headers()
                self.wfile.write(json.dumps({"error": str(exc)}, ensure_ascii=False).encode("utf-8"))
        else:
            self.send_response(404)
            self.end_headers()

# Wired up with functools.partial to pass directory to the constructor
handler = partial(Handler, directory=root)
with ReusableTCPServer((host, port), handler) as server:
    server.serve_forever()
```

## Key Details

### Constructor signature
`SimpleHTTPRequestHandler.__init__` accepts `*args, directory=None, **kwargs`. Use `functools.partial` to inject `directory=` because TCPServer calls the handler class with `(request, client_address, server)`.

### Same-origin = no CORS
Since the API and static files come from the same port, no CORS headers are needed.

### Atomic file writes
```python
def save_state(state: dict) -> None:
    DATA_DIR.mkdir(parents=True, exist_ok=True)
    tmp = STATE_FILE.with_suffix(".tmp")
    tmp.write_text(json.dumps(state, ensure_ascii=False))
    tmp.replace(STATE_FILE)  # atomic on POSIX
```

### Graceful missing-state handling
```python
def load_state() -> dict:
    if not STATE_FILE.is_file():
        return dict(DEFAULT_STATE)
    try:
        data = json.loads(STATE_FILE.read_text())
        if not isinstance(data, dict) or "rotation" not in data:
            return dict(DEFAULT_STATE)
        return data
    except (json.JSONDecodeError, OSError):
        return dict(DEFAULT_STATE)
```

## Verification Commands

```bash
# Start from clean state
rm -rf DATA/
uv run main.py &

# Test endpoints
curl -fsS http://127.0.0.1:8000/            # static page
curl -fsS http://127.0.0.1:8000/api/state   # GET → default state
curl -fsS -X POST -H 'Content-Type: application/json' -d '{"rotation":13.5}' http://127.0.0.1:8000/api/state   # POST
curl -fsS http://127.0.0.1:8000/api/state   # GET → saved state
cat DATA/dial-state.json                      # verify file

# Malformed request → 400
curl -s -X POST -d 'not-json' http://127.0.0.1:8000/api/state

# Stop server
kill %1  # or use process(kill)
```

## Port Management

### ReusableTCPServer pattern
```python
from socketserver import TCPServer

class ReusableTCPServer(TCPServer):
    allow_reuse_address = True
```
This sets `SO_REUSEADDR` so the port can be rebound quickly after restart.

### Stale socket cleanup
When `[Errno 98] Address already in use` occurs:
1. `fuser -k 8000/tcp 2>/dev/null; sleep 2` — most reliable
2. `pkill -f "uv run main.py"` — kill by process name
3. Fallback: use `--port 8001` to work around stuck sockets

### Verify port is free
```bash
ss -tlnp | grep 8000 || echo "free"
```
