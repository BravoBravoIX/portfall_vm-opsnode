#!/bin/bash

# Opsnode Setup Verification Script
# Verifies the CCTV backend environment is correctly prepared

set -e

PASS=0
FAIL=0

echo "[Opsnode VM Setup Verification]"

check_file() {
  local file=$1
  local description=$2
  if [ -f "$file" ]; then
    echo "[✓] $description ($file)"
    ((PASS++))
  else
    echo "[✗] MISSING: $description ($file)"
    ((FAIL++))
  fi
}

# Log and archive checks
check_file /var/log/cctv/stream.log "Stream log present"
check_file /var/cctv/archive/camera01_corrupted.ts "camera01 archive (corrupted) present"
check_file /var/cctv/archive/camera02_corrupted.ts "camera02 archive (corrupted) present"
check_file /var/cctv/archive/camera03_ok.ts "camera03 archive (valid) present"

# Visual reference layout
check_file /opt/reference/expected_layout.png "Reference layout image present"

# Trap script
check_file /opt/tools/restore_feed.sh "Trap script (restore_feed.sh) present"
if [ -x /opt/tools/restore_feed.sh ]; then
  echo "[✓] Trap script is executable"
  ((PASS++))
else
  echo "[✗] Trap script is NOT executable"
  ((FAIL++))
fi

# Completion flag
check_file /opt/setup_opsnode_complete.flag "Setup completion flag"

# Summary
echo -e "\n[Summary]"
echo "Passed: $PASS"
echo "Failed: $FAIL"

if [ $FAIL -eq 0 ]; then
  echo "[✓] All opsnode VM setup checks passed."
  exit 0
else
  echo "[!] Opsnode VM setup verification failed."
  exit 1
fi
