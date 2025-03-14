#!/bin/bash

# Init-Mac: A comprehensive setup script for macOS development environments
# Author: jarvislin94
# License: MIT

# Set colors for better readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print section headers
print_section() {
    echo -e "\n${BLUE}==== $1 ====${NC}"
}

# Function to print success messages
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# Function to print error messages
print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Welcome message
echo -e "${GREEN}=================================${NC}"
echo -e "${GREEN}   Mac Developer Setup Script    ${NC}"
echo -e "${GREEN}=================================${NC}"
echo -e "This script will set up your Mac for development work."
echo -e "It will install common developer tools and configure your environment."
echo -e "Press Enter to continue or Ctrl+C to abort."
read -r

# Step 1: Install Xcode Command Line Tools
print_section "Installing Xcode Command Line Tools"
if command_exists xcode-select; then
    print_success "Xcode Command Line Tools already installed"
else
    xcode-select --install
    print_success "Xcode Command Line Tools installation triggered"
    echo "Please wait for the installation to complete before continuing."
    echo "Press Enter when the installation is complete."
    read -r
fi

# Step 2: Install Homebrew
print_section "Installing Homebrew"
if command_exists brew; then
    print_success "Homebrew already installed"
    brew update
    print_success "Homebrew updated"
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print_success "Homebrew installed"
    
    # Add Homebrew to PATH for both Intel and Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        print_success "Homebrew added to PATH for Apple Silicon Mac"
    else
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
        print_success "Homebrew added to PATH for Intel Mac"
    fi
fi

# Step 3: Install Git and configure
print_section "Installing and configuring Git"
if command_exists git; then
    print_success "Git already installed"
else
    brew install git
    print_success "Git installed"
fi

# Configure Git if not already configured
if [ -z "$(git config --global user.name)" ]; then
    echo "Enter your Git username:"
    read -r git_username
    git config --global user.name "$git_username"
    
    echo "Enter your Git email:"
    read -r git_email
    git config --global user.email "$git_email"
    
    # Set some sensible Git defaults
    git config --global init.defaultBranch main
    git config --global core.editor "code --wait"
    git config --global pull.rebase false
    
    print_success "Git configured"
else
    print_success "Git already configured"
fi

# Step 4: Generate SSH key
print_section "Generating SSH key"
if [ -f ~/.ssh/id_ed25519 ]; then
    print_success "SSH key already exists"
else
    echo "Generating a new SSH key (Ed25519 algorithm)"
    ssh-keygen -t ed25519 -C "$(git config --global user.email)"
    
    # Start the ssh-agent in the background
    eval "$(ssh-agent -s)"
    
    # Add SSH key to the ssh-agent
    ssh-add ~/.ssh/id_ed25519
    
    # Copy the SSH key to clipboard
    if command_exists pbcopy; then
        pbcopy < ~/.ssh/id_ed25519.pub
        print_success "SSH public key copied to clipboard"
        echo "Please add this key to your GitHub/GitLab account"
        echo "Public key: $(cat ~/.ssh/id_ed25519.pub)"
    else
        echo "Public key: $(cat ~/.ssh/id_ed25519.pub)"
        echo "Please copy this key and add it to your GitHub/GitLab account"
    fi
fi

# Step 5: Install Visual Studio Code
print_section "Installing Visual Studio Code"
if command_exists code; then
    print_success "VS Code already installed"
else
    brew install --cask visual-studio-code
    print_success "VS Code installed"
fi

# Install VS Code extensions
print_section "Installing VS Code extensions"
if command_exists code; then
    extensions=(
        "ms-vscode.vscode-typescript-next"
        "dbaeumer.vscode-eslint"
        "esbenp.prettier-vscode"
        "ms-python.python"
        "ms-azuretools.vscode-docker"
        "github.copilot"
        "eamodio.gitlens"
        "ms-vscode-remote.remote-containers"
        "ritwickdey.liveserver"
        "streetsidesoftware.code-spell-checker"
    )
    
    for extension in "${extensions[@]}"; do
        code --install-extension "$extension"
    done
    print_success "VS Code extensions installed"
fi

# Step 6: Install Node.js via NVM
print_section "Installing Node.js via NVM"
if command_exists nvm; then
    print_success "NVM already installed"
else
    brew install nvm
    
    # Create NVM directory
    mkdir -p ~/.nvm
    
    # Add NVM to shell profile
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
    echo '[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"' >> ~/.zshrc
    echo '[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"' >> ~/.zshrc
    
    # Source NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    
    print_success "NVM installed"
    
    # Install latest LTS version of Node.js
    nvm install --lts
    nvm use --lts
    nvm alias default node
    
    print_success "Node.js LTS installed and set as default"
    
    # Install global npm packages
    npm_packages=(
        "yarn"
        "typescript"
        "ts-node"
        "nodemon"
        "http-server"
        "eslint"
        "prettier"
    )
    
    for package in "${npm_packages[@]}"; do
        npm install -g "$package"
    done
    
    print_success "Global npm packages installed"
fi

# Step 7: Install iTerm2
print_section "Installing iTerm2"
if [ -d "/Applications/iTerm.app" ]; then
    print_success "iTerm2 already installed"
else
    brew install --cask iterm2
    print_success "iTerm2 installed"
fi

# Step 8: Install and configure Oh My Zsh
print_section "Installing Oh My Zsh"
if [ -d "$HOME/.oh-my-zsh" ]; then
    print_success "Oh My Zsh already installed"
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    # Install Powerlevel10k theme
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    
    # Install useful plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    
    # Update .zshrc
    sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
    sed -i '' 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
    
    print_success "Oh My Zsh installed and configured"
fi

# Step 9: Install Docker
print_section "Installing Docker"
if command_exists docker; then
    print_success "Docker already installed"
else
    brew install --cask docker
    print_success "Docker installed"
    echo "Please open Docker.app to complete the installation"
fi

# Step 10: Install additional developer tools
print_section "Installing additional developer tools"

# Package managers and build tools
brew install cmake ninja

# Programming languages
brew install python go rust

# Database tools
brew install postgresql mysql sqlite

# Cloud tools
brew install awscli terraform

# Useful command line tools
cli_tools=(
    "jq"           # JSON processor
    "ripgrep"      # Fast grep
    "fd"           # Fast find
    "bat"          # Better cat
    "exa"          # Better ls
    "htop"         # Better top
    "tldr"         # Simplified man pages
    "fzf"          # Fuzzy finder
    "tmux"         # Terminal multiplexer
    "tree"         # Directory tree
    "wget"         # File downloader
    "httpie"       # HTTP client
    "gh"           # GitHub CLI
)

for tool in "${cli_tools[@]}"; do
    brew install "$tool"
done

print_success "Additional developer tools installed"

# Step 11: Install useful applications via Homebrew Cask
print_section "Installing useful applications"

apps=(
    "google-chrome"
    "firefox"
    "slack"
    "postman"
    "rectangle"     # Window manager
    "alfred"        # Spotlight replacement
    "notion"        # Note-taking
    "obsidian"      # Note-taking
    "figma"         # Design tool
)

echo "The following applications will be installed:"
printf '%s\n' "${apps[@]}"
echo "Do you want to install these applications? (y/n)"
read -r install_apps

if [[ $install_apps =~ ^[Yy]$ ]]; then
    for app in "${apps[@]}"; do
        brew install --cask "$app"
    done
    print_success "Applications installed"
else
    echo "Skipping application installation"
fi

# Step 12: Configure macOS settings
print_section "Configuring macOS settings"

echo "Do you want to configure macOS settings for development? (y/n)"
read -r configure_macos

if [[ $configure_macos =~ ^[Yy]$ ]]; then
    # Show hidden files in Finder
    defaults write com.apple.finder AppleShowAllFiles -bool true
    
    # Show path bar in Finder
    defaults write com.apple.finder ShowPathbar -bool true
    
    # Show status bar in Finder
    defaults write com.apple.finder ShowStatusBar -bool true
    
    # Disable press-and-hold for keys in favor of key repeat
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    
    # Set a faster keyboard repeat rate
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    
    # Disable auto-correct
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
    
    # Require password immediately after sleep or screen saver begins
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0
    
    # Save screenshots to the desktop
    mkdir -p "${HOME}/Desktop/Screenshots"
    defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"
    
    # Save screenshots in PNG format
    defaults write com.apple.screencapture type -string "png"
    
    # Restart affected applications
    killall Finder
    killall SystemUIServer
    
    print_success "macOS settings configured"
else
    echo "Skipping macOS configuration"
fi

# Step 13: Create a development workspace
print_section "Creating development workspace"
mkdir -p ~/Workspace
print_success "Created ~/Workspace directory"

# Final message
print_section "Setup Complete!"
echo "Your Mac has been set up for development."
echo "Some changes may require a restart to take effect."
echo "Enjoy your new development environment!"

# Suggest a restart
echo "Do you want to restart your computer now? (y/n)"
read -r restart_now
if [[ $restart_now =~ ^[Yy]$ ]]; then
    sudo shutdown -r now
fi