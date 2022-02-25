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

3. Install applications listed in Brewfile

``` bash
brew bundle
```

4. Create a symbolic link for the repo version of .zshrc and .zshenv to the home directory

``` bash
# The path to the original needs to be relative to the location of the symbolic link, so be explicit
ln -s ~/projects/dotfiles/zsh/.zshenv ~/.zshenv
ln -s ~/projects/dotfiles/zsh/.zshrc ~/.zshrc
```