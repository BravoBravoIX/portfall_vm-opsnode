**VM Build Sheet: vm-opsnode**

**Purpose:**
Simulates the backend for the CCTV and operational visibility system at Southgate Terminal. Participants will investigate why all camera feeds are down and identify possible interference or tampering. This machine includes log entries, anomalous footage file names, and system instability. Unlike other VMs, this one also ties into the manual operations SOP.

---

### 1. Services and Software to Install

* Standard CLI: `vim`, `grep`, `scp`, `cron`, `rsyslog`, `net-tools`
* `ffmpeg` or placeholder binaries to simulate video stream utilities

### 2. Directory and File Structure

```bash
/var/log/cctv/
  └── stream.log            # Logs showing stream errors, jitter, feed resets
/var/cctv/archive/
  ├── camera01_corrupted.ts
  ├── camera02_corrupted.ts
  └── camera03_ok.ts
/opt/reference/
  └── expected_layout.png   # Screenshot of expected camera views for comparison
```

### 3. Log Content Details

* `stream.log` includes:

  * Periodic drops (`feed lost`, `signal scrambling`)
  * Timestamp anomalies
  * Intermittent reboot entries (e.g. `daemon: restarting encoder`)

### 4. Archive Files

* `.ts` files are dummy media files with:

  * camera01/camera02: unreadable (simulate with empty files or corrupted headers)
  * camera03: valid dummy video or placeholder text

### 5. Reference File for Analysis

* Layout image: shows which cameras point where
* Teams can use this to assess what might be impacted (i.e. crane area, gate, ship berth)

### 6. Expected Participant Actions

* Review logs for systemic vs. localised issues
* Attempt to playback or view corrupted streams
* Compare with reference layout to determine coverage loss
* Escalate due to signal scrambling (potential interference or compromise)
* Initiate manual surveillance protocols (tie to Manual Ops SOP)

### 7. Outcomes

* Participants conclude cameras were intentionally jammed or disrupted
* Triggers SOP fallback to manual ops
* If they submit reference overlay and stream log together, earns points

### 8. Inject Linkages

* INJ002 (CCTV feed stutter starts)
* INJ003 (Camera feeds down)
* INJ014 (Manual ops triggered due to sustained failure)

### 9. Scoring Hooks

* Did they differentiate stream dropout vs hardware failure?
* Did they escalate interference?
* Did they attempt playback or extract metadata?
* Did they activate manual procedures as per SOP?

---

**Next Step:** Prepare `setup_opsnode.sh`, `verify_opsnode_setup.sh`, and `participant_action_opsnode.sh`.
