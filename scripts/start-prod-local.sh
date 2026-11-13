#!/usr/bin/env bash
# Start local dev servers pointed at production API (https://api.getgpride.com/v1).
# Production API, web, and admin are already deployed — this is for local testing only.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROD_API="https://api.getgpride.com/v1"
export NEXT_PUBLIC_API_URL="$PROD_API"
export EXPO_PUBLIC_API_URL="$PROD_API"

echo "GP Ride — local dev → production API"
echo "  API target: $PROD_API"
echo ""

for port in 3001 3002 8081 8082; do
  pids=$(lsof -ti tcp:"$port" -sTCP:LISTEN 2>/dev/null || true)
  if [ -n "$pids" ]; then
    echo "Stopping existing listener on port $port ($pids)"
    kill -9 $pids 2>/dev/null || true
  fi
done

mkdir -p "$ROOT/.local/logs"

start() {
  local name="$1"
  local dir="$2"
  local cmd="$3"
  local log="$ROOT/.local/logs/${name}.log"
  echo "Starting $name → $log"
  nohup bash -lc "cd \"$dir\" && $cmd" >>"$log" 2>&1 &
  disown
  echo "$!" >"$ROOT/.local/logs/${name}.pid"
}

start "gp-ride-web" "$ROOT/gp-ride-web" "npm run dev -- -p 3002"
start "gp-ride-admin" "$ROOT/gp-ride-admin" "npm run dev"
start "gp-ride-mobile" "$ROOT/gp-ride-mobile" "npx expo start --clear"
start "gp-ride-driver-mobile" "$ROOT/gp-ride-driver-mobile" "npx expo start --clear --port 8082"

sleep 8

echo ""
echo "=== Health checks ==="
curl -sf "$PROD_API/health" | head -c 120 && echo "  ✓ production API"
curl -sf -o /dev/null -w "  ✓ local web :3002 (%{http_code})\n" http://127.0.0.1:3002 || echo "  ✗ local web not ready yet"
curl -sf -o /dev/null -w "  ✓ local admin :3001 (%{http_code})\n" http://127.0.0.1:3001 || echo "  ✗ local admin not ready yet"
curl -sf -o /dev/null -w "  ✓ passenger Metro :8081 (%{http_code})\n" http://127.0.0.1:8081 || echo "  ✗ passenger Metro not ready yet"
curl -sf -o /dev/null -w "  ✓ driver Metro :8082 (%{http_code})\n" http://127.0.0.1:8082 || echo "  ✗ driver Metro not ready yet"

echo ""
echo "Logs: $ROOT/.local/logs/"
echo "  tail -f .local/logs/gp-ride-mobile.log"
echo "  tail -f .local/logs/gp-ride-driver-mobile.log"
