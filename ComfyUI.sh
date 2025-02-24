sudo apt install python-is-python3 python3.10-venv
git clone https://github.com/comfyanonymous/ComfyUI.git --depth=1
cd ComfyUI
python -m venv .venv
source .venv/bin/activate
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu126
pip install -r requirements.txt
