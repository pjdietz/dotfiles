setopt NO_CASE_GLOB

readonly KUBE_PS1_PATH='/usr/local/opt/kube-ps1/share/kube-ps1.sh'

PATH=$HOME/bin:$PATH

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Git prompt configuration
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *' # %u
zstyle ':vcs_info:*' stagedstr ' +'   # %c
# This line obtains information from the vcs.
zstyle ':vcs_info:git:*' formats       ' %F{green}(%b%u%c%m)%f'
zstyle ':vcs_info:git:*' actionformats ' %F{red}(%b|%a%u%c%m)%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

precmd() {
    vcs_info
}

+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     git status --porcelain | grep -m 1 '^??' &>/dev/null
  then
    hook_com[misc]=' ?'
  fi
}

# Enable substitution in the prompt.
setopt prompt_subst

# Set the prompt
PROMPT='[%F{blue}%1~%f${vcs_info_msg_0_}] '

# If kube-ps1 is installed, add it to the prompt.
if [[ -f "${KUBE_PS1_PATH}" ]]; then
  source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
  PROMPT='$(kube_ps1)'$PROMPT
  kubeoff
fi

# Add additional autocompletion, such as git
autoload -Uz compinit && compinit

# kubectl autocompletion
source <(kubectl completion zsh)

# Aliases
alias gitgraph="git log --oneline --graph --color --all --decorate"
alias k=kubectl
alias phpstorm="open . -a phpstorm"
alias mvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
