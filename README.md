# Scripts

This repository contains useful automation scripts for Debian-based systems:

1. [docker.sh](docker.sh)  
   Installs Docker on Debian-based OS.

2. [ComfyUI.sh](ComfyUI.sh)  
   Automates installation and setup of ComfyUI in your home directory, including Python venv and PyTorch with CUDA 12.6 support.

3. [aosp_build_env_debian.sh](aosp_build_env_debian.sh)  
   Sets up the AOSP build environment by installing required packages, configuring Git, and adding a PixelDrain upload helper to your shell.

4. [sound_fix.sh](sound_fix.sh)  
   Applies audio and volume control fixes for ASUS ROG and Zenbook laptops. Patches ALSA and PulseAudio/ALSA profiles for better compatibility. Run as root and reboot after applying.

---
**Usage:**  
Run each script with `bash <scriptname>.sh` for automated setup.