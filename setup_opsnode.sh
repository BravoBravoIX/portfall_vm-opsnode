#!/bin/bash

SETUP_FLAG="/opt/setup_opsnode_complete.flag"

function install_packages() {
  echo "[+] Installing required packages..."
  apt-get update -qq
  apt-get install -y vim grep cron rsyslog net-tools ffmpeg imagemagick
}

function create_directories() {
  echo "[+] Creating necessary directories..."
  mkdir -p /var/log/cctv
  mkdir -p /var/cctv/archive
  mkdir -p /opt/reference
  mkdir -p /opt/tools
}

function create_logs() {
  echo "[+] Creating simulated CCTV stream log..."
  cat > /var/log/cctv/stream.log <<EOF
2025-06-04T08:00:00Z camera01: stream online
2025-06-04T08:03:10Z camera01: feed lost
2025-06-04T08:03:55Z camera02: signal scrambling detected
2025-06-04T08:04:40Z camera03: stream online
2025-06-04T08:05:00Z camera01: stream recovered
2025-06-04T08:07:00Z daemon: restarting encoder for camera02
2025-06-04T08:07:30Z camera02: feed lost
2025-06-04T08:09:00Z camera01: jitter detected
2025-06-04T08:09:15Z camera01: stream offline
2025-06-04T08:10:00Z camera03: stream stable
EOF
}

function create_archives() {
  echo "[+] Simulating camera video archive files..."
  echo -e "\x00\x00\x00CORRUPT" > /var/cctv/archive/camera01_corrupted.ts
  echo -e "\x00\x00\x00CORRUPT" > /var/cctv/archive/camera02_corrupted.ts
  echo "This is a valid placeholder file for camera03." > /var/cctv/archive/camera03_ok.ts
}

function create_reference_image() {
  echo "[+] Generating placeholder reference layout..."
  convert -size 800x600 xc:white -pointsize 20 -fill black \
    -draw "text 100,100 'Expected Layout: Camera Overlays'" \
    /opt/reference/expected_layout.png
}

function create_trap_script() {
  echo "[+] Creating fake restore_feed.sh (trap)..."
  cat > /opt/tools/restore_feed.sh <<EOF
#!/bin/bash
echo "[+] Restarting CCTV services..."
echo "Camera feeds stabilising."
# Did you really think that worked? 🙂
exit 0
EOF
  chmod +x /opt/tools/restore_feed.sh
}

function mark_complete() {
  echo "[+] Marking setup complete."
  touch "$SETUP_FLAG"
}

function reset_vm() {
  echo "[!] Resetting vm-opsnode to pre-scenario state..."
  rm -f /var/log/cctv/stream.log
  rm -rf /var/cctv/archive/*
  rm -f /opt/reference/expected_layout.png
  rm -f /opt/tools/restore_feed.sh
  rm -f "$SETUP_FLAG"
  echo "[+] Reset complete."
  exit 0
}

if [[ "$1" == "-reset" ]]; then
  reset_vm
fi

if [ -f "$SETUP_FLAG" ]; then
  echo "[!] Setup already completed. Use -reset to reset."
  exit 1
fi

install_packages
create_directories
create_logs
create_archives
create_reference_image
create_trap_script
mark_complete

echo "[✓] vm-opsnode setup complete. Ready for scenario."
