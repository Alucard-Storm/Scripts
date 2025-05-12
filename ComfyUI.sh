# Install Python venv
sudo apt install python-is-python3 python3.12-venv

# Clone ComfyUI only if it doesn't exist
if [ ! -d "$HOME/ComfyUI" ]; then
    git clone https://github.com/comfyanonymous/ComfyUI.git --depth=1 ~/ComfyUI
fi

# Move into the ComfyUI directory
cd "$HOME/ComfyUI"

# Setup only if in the correct directory
if [ "$PWD" = "$HOME/ComfyUI" ]; then
    python -m venv .venv
    source .venv/bin/activate
    pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu126
    pip install -r requirements.txt
fi
