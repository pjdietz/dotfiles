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
