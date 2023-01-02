# dotfiles

My personal configuration files for zsh, neovim, tmux, git, etc.

## Setting up on a new machine (Mac)

Clone the repository to your home directory. Then, use [Gnu Stow](https://www.gnu.org/software/stow/) to create symlinks.

```sh
stow */
```

To symlink only part of the configuration, use `stow zsh`, etc.

### Additional Installs

#### Tmux

```bash
# Install tmux
brew install tmux
# Update the tmux-256color profile
./install-tmux-256color
```

#### Node.js and Python Providers

```bash
brew install node
npm install -g neovim
```

```bash
pip3 install pynvim
```

#### Fonts

If the system does not already have fonts available, download them from [Nerd Fonts](https://www.nerdfonts.com/font-downloads)

I'm partial to Droid Sans.
