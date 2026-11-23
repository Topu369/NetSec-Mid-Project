#!/usr/bin/env bash
# =============================================================================
# Phase 3 – Network Communication Observation
# =============================================================================
# Goal: Capture live network traffic to demonstrate that FTP (port 21) and
#       HTTP (port 80) transmit credentials in plain text.
#
# Tools required: wireshark (GUI), ftp client
# Note: Wireshark is a GUI application; this script prepares the environment
#       and generates the traffic. Apply filters manually inside Wireshark:
#         FTP traffic  : filter  ftp  → Follow → TCP Stream
#         HTTP traffic : filter  http.request.method == "POST"
# =============================================================================

TARGET="192.168.10.4"

# -----------------------------------------------------------------------------
# Step 1: Add the target hostname to /etc/hosts so the WordPress site resolves
# -----------------------------------------------------------------------------
echo "$TARGET vtcsec" | sudo tee -a /etc/hosts

# -----------------------------------------------------------------------------
# Step 2: Launch Wireshark (capture on eth0) in the background
# WARNING: Capturing network traffic must only be performed in a lab
#          environment with explicit permission.
# -----------------------------------------------------------------------------
wireshark &

# -----------------------------------------------------------------------------
# Step 3: Generate FTP traffic – attempt login to trigger credential exchange
#         The login is rejected, but USER and PASS are still sent in plain text.
#         When prompted:
#           Name  : topu
#           Password: test123
# -----------------------------------------------------------------------------
ftp "$TARGET"
# After connecting, type: quit

# -----------------------------------------------------------------------------
# Step 4: Generate HTTP POST traffic – submit the WordPress login form
#         Browse to: http://192.168.10.4/secret/wp-login.php
#         Enter any test credentials (e.g., log=topu, pwd=ttest123).
#         The POST body is transmitted in clear text over HTTP.
#
# Note: This step is performed via a web browser, not the command line.
#       The Wireshark capture of this traffic is shown in Figure 12 and 13.
# -----------------------------------------------------------------------------
