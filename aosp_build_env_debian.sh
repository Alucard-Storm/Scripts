# Sets up AOSP build environment on Debian. Installs required packages,
# configures Git user details, and adds a PixelDrain upload helper to ~/.bashrc.

# Update package list
sudo apt-get update

# Install required packages
sudo apt-get install -y git-core git-lfs gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig libssl-dev

# Git config
git config --global user.name "Alucard-Storm"
git config --global user.email "supersayan1000@gmail.com"

# Add PixelDrain function to ~/.bashrc
cat <<'EOF' >> ~/.bashrc
PD_API_KEY="your_api_key_here"
####################################
function pdup() {
    [ -z "\$1" ] && echo "Error: File not specified!" && return
    ID=\$(curl --progress-bar -T "\$1" -u :\$PD_API_KEY https://pixeldrain.com/api/file/ | grep -Po '(?<="id":")[^"]*')
    echo -e "\nhttps://pixeldrain.com/u/\$ID"
}
EOF

# Reload bashrc
source ~/.bashrc