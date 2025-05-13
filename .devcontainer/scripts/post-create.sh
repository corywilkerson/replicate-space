#!/bin/bash
set -e

echo "🚀 Setting up Replicate development environment..."

# Install core dependencies
echo "📦 Installing Python dependencies..."
pip install -U pip

# Ensure the bin directory exists
mkdir -p $HOME/.local/bin

# Install Cog prebuilt binary (v0.14.10) for Linux x86_64
echo "📦 Downloading Cog v0.14.10 binary..."
curl -L -o $HOME/.local/bin/cog https://github.com/replicate/cog/releases/download/v0.14.10/cog_Linux_x86_64
chmod +x $HOME/.local/bin/cog
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# Install Replicate CLI from source
echo "📦 Installing Replicate CLI from source..."
git clone https://github.com/replicate/cli.git /tmp/replicate-cli
cd /tmp/replicate-cli
make install PREFIX=$HOME/.local
cd -
rm -rf /tmp/replicate-cli

# Check if requirements.txt exists and install if it does
if [ -f "requirements.txt" ]; then
    echo "📦 Installing requirements from requirements.txt..."
    pip install -r requirements.txt
fi

# Check if we have any .py files, if not, initialize a basic structure
if [ ! -f "predict.py" ] && [ ! -f "cog.yaml" ]; then
    echo "🏗️ No existing Replicate project found, initializing a template..."
    
    # Create cog.yaml if it doesn't exist
    if [ ! -f "cog.yaml" ]; then
        echo "📝 Creating cog.yaml..."
        cat > cog.yaml << 'EOL'
build:
  gpu: false
  python_version: "3.10"
  python_packages:
    - numpy==1.25.2

predict: "predict.py:Predictor"
EOL
    fi
    
    # Create predict.py if it doesn't exist
    if [ ! -f "predict.py" ]; then
        echo "📝 Creating predict.py..."
        cat > predict.py << 'EOL'
from cog import BasePredictor, Input


class Predictor(BasePredictor):
    def setup(self):
        """Load the model into memory (no-op for this simple example)"""
        pass
        
    def predict(
        self,
        name: str = Input(description="Your name", default="world")
    ) -> str:
        """A simple hello-world function that runs on CPU"""
        return f"Hello, {name}! This is a CPU-based Replicate model."
EOL
    fi
fi

echo "✅ Replicate development environment setup complete!"
echo "📚 Run 'cog --help' to see available commands"
echo "📚 Run 'replicate --help' to see available Replicate CLI commands"

