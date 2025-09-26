#!/bin/bash
#
# Audio Patch Script for ASUS ROG and Zenbook Laptops
#
# This script applies fixes for sound and volume control issues on some laptops 
# (e.g., ASUS ROG Strix G17). It does two things:
#
# 1. **Sound Fix (ALSA config):**
#    - Appends an option to `/etc/modprobe.d/alsa-base.conf` 
#      to force the `snd-hda-intel` driver to use the `asus-zenbook` model.
#
# 2. **Volume Control Fix (PulseAudio/ALSA profile patch):**
#    - Detects which `analog-output.conf.common` file exists:
#        - `/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common`
#        - `/usr/share/alsa-card-profile/mixer/paths/analog-output.conf.common`
#    - Appends configuration to ensure the Master element ignores volume 
#      but allows mute switching.
#
# Usage:
#   1. Save this script as `sound_fix.sh`.
#   2. Make it executable: `chmod +x sound_fix.sh`.
#   3. Run it with superuser privileges: `sudo ./sound_fix.sh`.
#   4. Reboot your system to apply the changes.
#   Note: Always back up configuration files before modifying them.

# Sound Fix
echo "Patching Alsa Config"
sudo tee -a /etc/modprobe.d/alsa-base.conf >/dev/null <<EOF
options snd-hda-intel model=asus-zenbook
EOF

# Volume Control Fix
echo "Patching PulseAudio Config"
FILE1="/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common"
FILE2="/usr/share/alsa-card-profile/mixer/paths/analog-output.conf.common"

if [ -f "$FILE1" ]; then
    sudo tee -a "$FILE1" >/dev/null <<EOF
[Element Master]
switch = mute
volume = ignore
EOF
elif [ -f "$FILE2" ]; then
    sudo tee -a "$FILE2" >/dev/null <<EOF
[Element Master]
switch = mute
volume = ignore
EOF
else
    echo "Neither file exists!"
fi

echo "Patch Applied Successfully"
echo "Please reboot your system to apply the changes."