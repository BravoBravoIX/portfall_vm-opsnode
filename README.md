VM Build Sheet: vm-opsnode

Purpose:
Simulates the backend for CCTV and operational visibility at Southgate Maritime Terminal. Participants investigate complete camera feed failures and identify signs of signal interference, tampering, or local corruption. This node integrates with manual operations protocols and visual surveillance fallback.

1. Services and Software to Install
Standard CLI: vim, grep, scp, cron, rsyslog, net-tools

Multimedia tools: ffmpeg, imagemagick (or placeholder equivalents)

2. Directory and File Structure
bash
Copy
Edit
/var/log/cctv/
  └── stream.log              # Feed logs with jitter, dropouts, and encoder restarts

/var/cctv/archive/
  ├── camera01_corrupted.ts   # Simulated corrupt media
  ├── camera02_corrupted.ts
  └── camera03_ok.ts          # Simulated working feed

/opt/reference/
  └── expected_layout.png     # Visual layout of camera zones
3. Log Content Details
stream.log includes:

Frequent feed dropouts and jitter (e.g. feed lost, signal scrambling)

Encoder restarts (daemon: restarting encoder)

Late-stage complete camera offline status

Subtle timestamp inconsistencies

4. Archive File Behaviour
.ts files mimic camera recordings:

camera01 and camera02: intentionally unreadable (corrupt header or null content)

camera03: minimal valid placeholder file

5. Reference Overlay Image
expected_layout.png provides camera-to-location mapping

Used by participants to correlate footage loss with critical port zones (e.g. ship berths, gate, crane ops)

6. Expected Participant Actions
Analyse logs for temporal patterns and escalating failures

Attempt playback or inspection of archive footage

Compare layout image with affected streams

Escalate signal jamming or encoder sabotage suspicion

Initiate manual surveillance SOP fallback

7. Outcomes
Participants determine CCTV is not failing randomly, but due to coordinated interference

Correct escalation and SOP activation (Manual Ops) demonstrate resilience

High marks if both logs and overlay image are transferred for audit

8. Inject Linkages
INJ002 — Initial CCTV feed stutter

INJ003 — Complete camera blackout

INJ014 — Manual operations officially triggered

9. Scoring Hooks
Did participants distinguish between random dropout and jamming?

Did they escalate technical sabotage appropriately?

Did they transfer logs + overlay image to vm-audit?

Did they invoke fallback procedures per SOP?
