PORT=8889
HOST=127.0.0.1
PROFILE="/Volumes/X-Drive/AI-Agent-Profile"

echo "Loading..."

open -na "Chrome Testing" --args \
  --remote-debugging-port="$PORT" --remote-debugging-address="$HOST" \
  --user-data-dir="$PROFILE" --no-first-run --no-default-browser-check \
  --disable-background-networking --disable-sync --disable-component-update\
  --disable-ipc-flooding-protection --disable-breakpad --disable-gpu \
  --disable-hang-monitor --metrics-recording-only --disable-infobars --disable-popup-blocking \
  --disable-features=OptimizationHints --disable-blink-features=AutomationControlled &

for i in {1..20}; do
    if curl -fs "http://$HOST:$PORT/json/version" >/dev/null; then
        echo "Chrome Testing is ready"
        exit 0
    fi
    sleep 1
done

echo "Off & Timed out."
exit 1
