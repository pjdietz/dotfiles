# dotfiles

My personal configuration files for zsh, vim, git, etc.

## Setting up on a new machine

When cloning the project to a new machine, run the following commands to checkout the dotbot submodule if this doesn't happen automatically:

```bash
git submodule init
git submodule update
```

## Setting up on a new machine (Mac)

Run the following from the repository root to create symlinks as needed.

```sh
./install
```

Dotbot should be able to create all symlinks as needed. If it fails, you may need to delete some existing directories and run it again.


## Setting up a new machine (Windows)

Run the following from an elevated PowerShell in the repository root to create symlinks.

```PowerShell
./install.ps1

# NeoVim
New-Item -ItemType SymbolicLink -Path ~/AppData/Local/nvim -Target "$pwd/nvim"

# Windows Terminal
Remove-Item -Path $Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState -Force -Recurse
New-Item -ItemType SymbolicLink -Path "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Target "${pwd}\WindowsTerminal"
```

The process is a little rough on Windows. Dotbot doesn't seem to be able to create all the symlinks like it should, and auto installing vim-plug doesn't work.

To complete the NeoVim setup, run:

```PowerShell
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```
