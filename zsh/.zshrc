setopt NO_CASE_GLOB

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export EDITOR=nvim
export FCEDIT=nvim
export KEYTIMEOUT=1
export MANPAGER="nvim +Man!"
export XDG_CONFIG_HOME="${HOME}/.config"
export DOTNET_ROOT="${HOME}/dotnet"
export PYTHONUSERBASE="${HOME}/.local"

if command -v fd &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f'
  export FZF_CTRL_T_COMMAND='fd --type f'
fi

# Array of directories to add to the path in order.
# Any directories that do not exist will not be added.
declare -a PATH_DIRS=(
  "${HOME}/bin"
  "${HOME}/.local/bin"
  "/usr/local/bin"
  "${HOME}/.cargo/bin"
  "${HOME}/.krew/bin"
  "${HOME}/dotnet"
)

if command -v go &> /dev/null; then
  export GOPATH=$(go env GOPATH)
  PATH_DIRS+=("${GOPATH}/bin")
fi

main()
{
  set_path
  set_prompt
  set_autocomplete
  set_vi_mode
  set_aliases

  # Source platform-specific zshrc
  readonly platform_zshrc="${HOME}/.zshrc-$(uname)"
  if [[ -f "${platform_zshrc}" ]]; then source "${platform_zshrc}"; fi
}

set_path()
{
  local filtered=()
  for p in $PATH_DIRS; do
    if [ -d "${p}" ]; then
      filtered+=("${p}")
    fi
  done

  local joined=${(j.:.)filtered}
  PATH="${joined}:${PATH}"
}

set_prompt()
{
  # Git prompt configuration
  autoload -Uz vcs_info
  zstyle ':vcs_info:*' enable git svn
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:*' unstagedstr ' *' # %u
  zstyle ':vcs_info:*' stagedstr ' +'   # %c
  # This line obtains information from the vcs.
  zstyle ':vcs_info:git:*' formats       ' %F{green} %b%c%u%m%f'
  zstyle ':vcs_info:git:*' actionformats ' %F{red} %b|%a%u%u%m%f'
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
  PROMPT='%F{blue}%1~%f'
  PROMPT=${PROMPT}'${vcs_info_msg_0_}'
  PROMPT=${PROMPT}' %F{blue}󰁕%f '

  # If kube-ps1 is installed, add it to the prompt.
  KUBE_PS1_PATH='/usr/local/opt/kube-ps1/share/kube-ps1.sh'
  if [[ -f "${KUBE_PS1_PATH}" ]]; then
    source "${KUBE_PS1_PATH}"
    RPROMPT='$(kube_ps1)'$RPROMPT
    kubeoff
  fi
}

set_autocomplete()
{
  # Basic auto/tab complete:
  autoload -U compinit
  zstyle ':completion:*' menu select
  zmodload zsh/complist
  compinit
  _comp_options+=(globdots)

  # fzf
  if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
  fi

  # Zoxdie autocompletion
  if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
  fi

  # kubectl autocompletion
  if command -v kubectl &> /dev/null; then
    source <(kubectl completion zsh)
    if kubectl stern --version &> /dev/null; then
      source <(kubectl stern --completion=zsh)
    fi
  fi
}

set_vi_mode()
{
  # Vi mode
  bindkey -v
  bindkey "^R" history-incremental-search-backward

  # Use vim keys in tab complete menu:
  bindkey -M menuselect 'h' vi-backward-char
  bindkey -M menuselect 'k' vi-up-line-or-history
  bindkey -M menuselect 'l' vi-forward-char
  bindkey -M menuselect 'j' vi-down-line-or-history
  bindkey -v '^?' backward-delete-char

  # Open current line in an editor.
  autoload -Uz edit-command-line
  zle -N edit-command-line
  bindkey -M vicmd 'E' edit-command-line

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
}

set_aliases()
{
  if command -v bat &> /dev/null; then
    alias cat='bat'
  fi
  if command -v xh &> /dev/null; then
    alias xh='http'
  fi
  if command -v xhs &> /dev/null; then
    alias xh='https'
  fi

  alias d='docker'
  alias dc='docker compose'
  alias dcl='docker compose logs -f'
  alias dclt='docker compose logs -f --timestamps'
  alias dcr='docker compose run --rm'
  alias dce='docker compose exec'
  alias flush-dns='sudo killall -HUP mDNSResponder'
  alias gitgraph='git graph'
  alias ga='git add'
  alias gad='git add .'
  alias gap='git add -p'
  alias gc='git commit'
  alias gca='git commit --amend'
  alias gcan="git commit --amend --no-edit"
  alias gg='git graph'
  alias gl='git log'
  alias glo='git oneline'
  alias gs='git status'
  alias ll='ls -l'
  alias ls='eza'
  alias k='kubectl'
  alias kd='kubectl describe'
  alias kg='kubectl get'
  alias kpf='kubectl port-forward'
  alias wk='watch kubectl'
  alias tms='tmux-session'
  alias tmw='tmux-window'
  alias tree='eza -T'
  alias vim='nvim'
}

gdf() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}

gaf() {
  git add $@ $(gdf)
}

db() {
  mysql --defaults-file="~/.mysql/${1}.cnf" -A
}

ksecret() {
  kubectl get secrets/$1 --template='{{ range $key, $value := .data }}{{ printf "%s: %s\n" $key ($value | base64decode) }}{{ end }}'
}

main
