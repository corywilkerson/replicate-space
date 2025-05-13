#!/bin/bash
set -e

echo "🔄 Running post-start initialization..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "⚠️ Docker doesn't seem to be running. Some Replicate features may not work properly."
else
    echo "✅ Docker is running correctly."
fi

# Print Replicate/Cog versions
echo "📋 Installed tool versions:"
echo -n "Cog: "
cog --version

echo -n "Replicate CLI: "
if command -v replicate &> /dev/null; then
    replicate --version
else
    echo "Not found. Run /tmp/install.sh to install."
fi

# Check for Replicate token
if [ -z "$REPLICATE_API_TOKEN" ]; then
    echo "⚠️ REPLICATE_API_TOKEN environment variable not set."
    echo "💡 You can set it using GitHub Codespaces secrets or by running:"
    echo "   export REPLICATE_API_TOKEN=your_token_here"
else
    echo "✅ REPLICATE_API_TOKEN is set."
fi

echo "🌟 Replicate development environment ready!"
echo "💡 Tip: Use 'cog predict' to test your model locally and 'cog push' to deploy to Replicate"

