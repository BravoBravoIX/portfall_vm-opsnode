#!/bin/bash

# Participant Action Simulation Script for vm-opsnode
# Simulates technical actions a team might take in investigating CCTV anomalies

set -e

STREAM_LOG="/var/log/cctv/stream.log"
ARCHIVE_DIR="/var/cctv/archive"
REFERENCE_IMG="/opt/reference/expected_layout.png"

### 1. Inspect stream log for video feed issues

echo -e "\n[1] Reviewing stream log for anomalies..."
tail -n 10 "$STREAM_LOG"

echo -e "\n[1a] Highlighting feed losses, scrambling, jitter..."
grep -Ei "feed|lost|scrambling|jitter|offline" "$STREAM_LOG" || echo "[!] No anomalies matched"

### 2. Review video archive contents

echo -e "\n[2] Listing camera archive directory..."
ls -lh "$ARCHIVE_DIR"

### 3. Simulate video inspection on all files

echo -e "\n[3] Simulating video file reads (corrupt vs valid)..."
for f in camera01_corrupted.ts camera02_corrupted.ts camera03_ok.ts; do
  echo -e "\nTesting: $f"
  file "$ARCHIVE_DIR/$f" || echo "[!] File unreadable or corrupt"
done

### 4. Reference overlay comparison

echo -e "\n[4] Expected layout overlay available at:"
echo "$REFERENCE_IMG"
echo "[i] Participants should visually compare layout against affected feeds."

### 5. Recommended SOP for feed failure

echo -e "\n[5] Trigger manual surveillance fallback per SOP..."
echo "Refer to: Manual Ops SOP → camera fallback protocols."

### 6. Suggest secure log transfer

echo -e "\n[6] Example transfer command to vm-audit:"
echo "scp $STREAM_LOG audituser@vm-audit:/incident/archive/opsnode/"

### 7. Completion

echo -e "\n[✓] Participant simulation complete. This VM is now in investigative state."
