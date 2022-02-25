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

4. Clone necessary repo for autocomplete
```git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git```

5. Create a symbolic link for the repo version of .zshrc and .zshenv to the home directory

``` bash
# The path to the original needs to be relative to the location of the symbolic link, so be explicit
ln -s ~/configs/zsh/.zshenv ~/.zshenv
ln -s ~/configs/zsh/.zshrc ~/.zshrc
```

6. Create a copy of git completion
mkdir ~/.zsh
cp ~/configs/zsh/git/git-completion.zsh ~/.zsh/_git