setopt NO_CASE_GLOB

PATH="${HOME}/bin:${PATH}"
PATH="${HOME}/.local/bin:${PATH}"

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Git prompt configuration
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *' # %u
zstyle ':vcs_info:*' stagedstr ' +'   # %c
# This line obtains information from the vcs.
zstyle ':vcs_info:git:*' formats       ' %F{green}( %b%u%c%m)%f'
zstyle ':vcs_info:git:*' actionformats ' %F{red}( %b|%a%u%c%m)%f'
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
KUBE_PS1_PATH='/usr/local/opt/kube-ps1/share/kube-ps1.sh'
if [[ -f "${KUBE_PS1_PATH}" ]]; then
  source "${KUBE_PS1_PATH}"
  RPROMPT='$(kube_ps1)'$RPROMPT
  kubeoff
fi

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# kubectl autocompletion
if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
fi

# Vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey "^R" history-incremental-search-backward

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
  zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
  echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Aliases
alias dc='docker-compose'
alias gitgraph='git log --oneline --graph --color --all --decorate'
alias k='kubectl'
alias phpstorm='open . -a phpstorm'
alias vim='nvim'
alias mvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
