# Automates installation of ComfyUI in the user's home directory.
# Installs Python venv, clones ComfyUI, creates and activates a virtual environment,
# and installs required Python packages including PyTorch with CUDA 12.6 support.

# Install Python venv
sudo apt install -y python-is-python3 python3.12-venv

# Clone ComfyUI only if it doesn't exist
if [ ! -d "$HOME/ComfyUI" ]; then
    echo "Cloning ComfyUI repository..."
    git clone https://github.com/comfyanonymous/ComfyUI.git --depth=1 ~/ComfyUI || { echo "Git clone failed!"; exit 1; }
fi

# Move into the ComfyUI directory
cd "$HOME/ComfyUI"

# Create and activate virtual environment
python -m venv .venv
source .venv/bin/activate

# Install PyTorch with CUDA 12.6 support and other requirements
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu126
pip install -r requirements.txt