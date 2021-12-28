# dotfiles

My personal configuration files for zsh, vim, git, etc.

## Setting up on a new machine (Mac)

Run the following from the repository root to create symlinks as needed.

```sh
# Z shell
ln -s "${PWD}/.zshrc" ~/.zshrc

# Git 
ln -s "${PWD}/.gitconfig" ~/.gitconfig
mkdir -p ~/.config/git
ln -s "${PWD}/.gitignore_global" ~/.config/git/ignore

# Vim
ln -s "${PWD}/.vimrc" ~/.vimrc
```

## Setting up a new machine (Windows)

Run the following from an elevated PowerShell in the repository root to create symlinks.

```PowerShell
# Git
New-Item -ItemType SymbolicLink -Path ~/.gitconfig -Target "$pwd/.gitconfig"
New-Item -ItemType Directory -Force -Path ~/.config/git
New-Item -ItemType SymbolicLink -Path ~/.config/git/ignore -Target "$pwd/.gitignore_global"

# Vim
New-Item -ItemType SymbolicLink -Path ~/_vimrc -Target "$pwd/.vimrc"

# Windows Terminal
Remove-Item -Path $Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState -Force -Recurse
New-Item -ItemType SymbolicLink -Path "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Target "${pwd}\WindowsTerminal"

```
