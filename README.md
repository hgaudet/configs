# configs

New Mac Startup

1. First, clone this repository and cd into it

``` bash
git clone https://github.com/hgaudet/configs.git
cd configs
```


2. Install Homebrew

``` bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
OR (if missing sudo)
``` bash
git clone https://github.com/Homebrew/brew homebrew
eval "$(homebrew/bin/brew shellenv)"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"
```

3. Add brew to path
``` bash
export PATH="/opt/homebrew/bin:$PATH" >> ~/.zshrc
```

4. Install applications listed in Brewfile

``` bash
brew bundle
```

5. Clone necessary repo for autocomplete
```git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git```

6. Create a symbolic link for the repo version of .zshrc, .zshenv, and gitconfig to the home directory

``` bash
# The path to the original needs to be relative to the location of the symbolic link, so be explicit
ln -s ~/configs/zsh/.zshenv ~/.zshenv
ln -s ~/configs/zsh/.zshrc ~/.zshrc
ln -s ~/configs/gitconfig ~/.gitconfig
```

7. Create a copy of git completion
``` bash
mkdir ~/.zsh
cp ~/configs/zsh/git/_git ~/.zsh/_git
```

8. Set shell to zsh
``` bash
chsh -s $(which zsh)
```