# Replicate Codespaces Template

A template repository for developing and deploying [Replicate](https://replicate.com/) models using GitHub Codespaces.

## Features

- Pre-configured development container with all necessary tools
- Docker-in-Docker support for building and pushing images
- Automatic setup of Cog and Replicate CLI tools
- Simple "Hello World" CPU-based template
- VS Code extensions for Python and Docker development

## Using This Template

### Create a New Repository

1. Click the "Use this template" button at the top of this repository
2. Name your new repository and click "Create repository from template"

### Open in Codespaces

1. From your new repository, click the "Code" button
2. Select the "Codespaces" tab
3. Click "Create codespace on main"

The development environment will automatically set up with all the necessary tools and configurations.

### Setting Up Replicate API Token

To push models to Replicate, you'll need to set up your API token. You have two options:

#### Option 1: Set as a Codespaces Secret (Recommended)

1. Go to your GitHub repository
2. Navigate to Settings > Secrets and variables > Codespaces
3. Click "New repository secret"
4. Name: `REPLICATE_API_TOKEN`
5. Value: Your Replicate API token from https://replicate.com/account/api-tokens
6. Click "Add secret"

The token will be automatically available in your Codespace environment.

#### Option 2: Set in Your Terminal Session

```bash
export REPLICATE_API_TOKEN=your_token_here
```

This will set the token for your current session only.

## Developing Your Model

The environment comes with:

- [Cog](https://github.com/replicate/cog) - Tool for packaging machine learning models
- [Replicate CLI](https://github.com/replicate/cli) - Command-line interface for Replicate

### Basic Workflow

1. **Test the template model locally:**
   ```bash
   cog predict -i name="Your Name"
   ```

2. **Develop your own model:**
   - Edit `predict.py` to implement your model's prediction logic
   - Modify `cog.yaml` to specify your dependencies

3. **Push to Replicate:**
   ```bash
   # Build and push your model
   cog push
   ```

## Hello World Template

The template includes a simple CPU-based hello world model:

- `predict.py` - Contains a simple greeting function
- `cog.yaml` - Minimal configuration with no GPU requirements

This serves as a starting point - replace it with your own model code!

## Customizing the Template

### Devcontainer Configuration

The main configuration is in `.devcontainer/devcontainer.json`. You can modify this file to:

- Change the base image
- Add or remove development features
- Customize VS Code settings and extensions
- Modify environment variables

### Post-Creation Scripts

Two scripts handle the initialization:

- `.devcontainer/scripts/post-create.sh` - Runs when the container is created
- `.devcontainer/scripts/post-start.sh` - Runs each time the container starts

Modify these to customize your environment setup.

## Notes on GPU Support

GitHub Codespaces doesn't support GPUs, so this template is designed for:

- Developing and testing your model's interface
- Building Docker images locally
- Pushing to Replicate for GPU-powered execution

## Making Your Own Template

If you've customized this template and want to make your own version:

1. In your repository, go to Settings
2. Scroll down to "Template repository"
3. Check "Template repository"

Now others can create new repositories based on your customized template.

