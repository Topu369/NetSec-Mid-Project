#!/usr/bin/env bash
# =============================================================================
# Phase 2 – System Discovery
# =============================================================================
# Goal: Identify open ports, running services, service versions, and potential
#       weaknesses on the target (192.168.10.4) with no prior knowledge.
#
# Tools required: nmap, whatweb, nikto
# =============================================================================

TARGET="192.168.10.4"

# -----------------------------------------------------------------------------
# Step 1: Port and service version detection with Nmap
#         Identifies open TCP ports and the software/version behind each.
#         Results: 21/tcp ProFTPD 1.3.3c, 22/tcp OpenSSH 7.2p2, 80/tcp Apache 2.4.18
# -----------------------------------------------------------------------------
nmap -sV "$TARGET"

# -----------------------------------------------------------------------------
# Step 2: Web server technology fingerprinting with WhatWeb
#         Confirms the web stack: Apache 2.4.18 on Ubuntu Linux.
# -----------------------------------------------------------------------------
whatweb "http://$TARGET"

# -----------------------------------------------------------------------------
# Step 3: Web server vulnerability enumeration with Nikto
#         Reports: outdated Apache, missing security headers (X-Content-Type-Options,
#         Content-Security-Policy, etc.), and additional misconfigurations.
# -----------------------------------------------------------------------------
nikto -h "$TARGET"
