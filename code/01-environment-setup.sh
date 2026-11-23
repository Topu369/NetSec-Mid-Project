#!/usr/bin/env bash
# =============================================================================
# Phase 1 – Target Selection and Environment Preparation
# =============================================================================
# Prerequisites:
#   - Oracle VirtualBox installed on the host machine
#   - Kali Linux VM imported into VirtualBox
#   - Basic Pentesting 1 VM (.ova) downloaded from VulnHub and imported
#   - Both VMs attached to the same NAT Network (NatNetwork, 192.168.10.0/24)
#
# Network environment used in this project:
#   Kali Linux  : 192.168.10.3  (attacker machine)
#   Target VM   : 192.168.10.4  (Basic Pentesting 1 – vtcsec)
# =============================================================================

# -----------------------------------------------------------------------------
# Step 1: Verify your network interface and assigned IP address (run on Kali)
# -----------------------------------------------------------------------------
ip a

# -----------------------------------------------------------------------------
# Step 2: Discover live hosts on the NAT Network using netdiscover
#         This identifies the target IP (192.168.10.4) via ARP scanning.
# WARNING: Run only inside an isolated lab environment.
# -----------------------------------------------------------------------------
sudo netdiscover -i eth0 -r 192.168.10.0/24

# -----------------------------------------------------------------------------
# Step 3: Confirm communication between Kali and the target with ping
# -----------------------------------------------------------------------------
ping -c 4 192.168.10.4
