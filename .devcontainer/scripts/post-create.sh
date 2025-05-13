#!/bin/bash
set -e

echo "🚀 Setting up Replicate development environment..."

# Install core dependencies
echo "📦 Installing Replicate CLI and Cog..."
pip install -U pip
pip install cog

# Install Replicate CLI using Go
echo "📦 Installing Replicate CLI..."
go install github.com/replicate/cli/cmd/replicate@latest

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

