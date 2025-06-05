#!/bin/bash

# Participant Action Simulation Script for vm-opsnode
# Simulates the likely technical actions a team might take in investigating CCTV failures

set -e

STREAM_LOG="/var/log/cctv/stream.log"
ARCHIVE_DIR="/var/cctv/archive"
REFERENCE_IMG="/opt/reference/expected_layout.png"

### 1. Inspect CCTV log for errors

echo -e "\n[1] Reviewing stream log for failures..."
tail -n 10 "$STREAM_LOG"
grep -i "feed\|lost\|scrambling\|jitter" "$STREAM_LOG"

### 2. List archive files

echo -e "\n[2] Listing camera archive directory..."
ls -lh "$ARCHIVE_DIR"

### 3. Simulate playback test (corrupted and ok files)

echo -e "\n[3] Simulating file reads for camera feeds..."
for f in camera01_corrupted.ts camera02_corrupted.ts camera03_ok.ts; do
  echo -e "\nTesting: $f"
  file "$ARCHIVE_DIR/$f" || echo "[!] File unreadable or corrupt"
done

### 4. Compare with expected camera layout

echo -e "\n[4] Reference overlay expected layout is here: $REFERENCE_IMG"
echo "[i] Participants may visually compare coverage zones vs failed feeds."

### 5. Recommend fallback (manual surveillance trigger)

echo -e "\n[5] Manual surveillance protocols recommended per SOP."
echo "Refer to Manual Ops SOP if feeds cannot be restored."

### 6. Prepare logs and archive list for transfer to vm-audit

echo -e "\n[6] Example transfer command to vm-audit:"
echo "scp $STREAM_LOG audituser@vm-audit:/incident/archive/opsnode/"

### 7. Wrap-up

echo -e "\n[✓] Participant simulation complete for vm-opsnode."
