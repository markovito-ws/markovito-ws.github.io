#!/bin/sh

# Exit on error
set -e

echo "Starting Setup..."

# 1. Update and install system dependencies
echo "Updating apt package list..."
sudo apt update

echo "Installing system dependencies..."
sudo apt install -y \
    ros-noetic-navigation \
    ros-noetic-slam-toolbox \
    qtbase5-dev \
    libqt5svg5-dev \
    libzmq3-dev \
    libdw-dev \
    libportaudio2 \
    git \
    curl

# 2. Clone repositories using git clone --depth 1
echo "Cloning repositories..."
mkdir -p src

clone_repo() {
    _repo_url="$1"
    _dest_path="$2"
    if [ ! -d "$_dest_path" ]; then
        echo "Cloning $_dest_path..."
        git clone --depth 1 "$_repo_url" "$_dest_path"
    else
        echo "$_dest_path already exists, skipping."
    fi
}

clone_repo "https://github.com/markovito-ws/bt_markovito" "src/bt_markovito"
clone_repo "https://github.com/markovito-ws/BehaviorTree.CPP" "src/BehaviorTree.CPP"
clone_repo "https://github.com/markovito-ws/Groot" "src/Groot"
clone_repo "https://github.com/markovito-ws/BehaviorTree.ROS" "src/BehaviorTree.ROS"
clone_repo "https://github.com/markovito-ws/module_sam" "src/module_sam"
clone_repo "https://github.com/markovito-ws/module_whisper" "src/module_whisper"
clone_repo "https://github.com/markovito-ws/module_nav" "src/module_nav"

if ! command -v uv >/dev/null 2>&1; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    echo "uv is already installed."
fi

echo "Setup complete!"
