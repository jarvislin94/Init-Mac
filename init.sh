# step 1. install home brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# step 2. install git
brew install git

# step 3. generate git public ssh key
ssh-keygen -o

# step 4. install vscode
curl https://vscode.cdn.azure.cn/stable/704ed70d4fd1c6bd6342c436f1ede30d1cff4710/VSCode-darwin-universal.zip

# step 5. install nvm
brew install nvm

# step 6. install item2
brew install iterm2 --cask

# step 7. install oh-myzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"