# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set directory where we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if it doesn't exist
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# Load completions
autoload -U compinit && compinit

# Keybindings
bindkey -v
bindkey '^ ' autosuggest-accept
bindkey '^R' history-incremental-search-backward
bindkey '^T' history-incremental-search-forward

bindkey -s "^p" 'tmux-sessionizer\n'


# ─── History Options ───────────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
HISTDUP=erase

setopt APPENDHISTORY
setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt HIST_BEEP
setopt SHAREHISTORY


# ─── Custom Functions ──────────────────────────────────────────────────
tom() {
  if [[ -z "$(rg tomlscript pyproject.toml)" ]]; then
    echo -e "\n[tool.tomlscript]"\
      "\n# runserver"\
      "\ndev = \"uv run manage.py runserver\""\
      "\n# manage.py"\
      "\nmanage = \"uv run manage.py\""\
      "\n# makemigrations and migrate"\
      "\nmigrate = \"uv run manage.py makemigrations && uv run manage.py migrate\""\
      "\n# startapp"\
      "\nstartapp = \"uv run manage.py startapp\"" >> pyproject.toml
  fi
  uvx tomlscript "$@"
}


# ─── Tmux Reload ───────────────────────────────────────────────────────
if [ -n "$TMUX" ]; then
  tmux source-file "$TMUX_CONF"
fi

# Completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select

# ─── Aliases ────────────────────────────────────────────────────────────
alias todo='nvim /home/shivang/todo.md'
alias ls='ls --color=auto'


# Shell integrations
# eval "$(fzf --zsh)"

# ─── Environment Variables ─────────────────────────────────────────────
export GOPATH="$HOME/go"
export TMUX_CONF="$HOME/.config/tmux/tmux.conf"
export PERSONAL="$HOME/personal"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH:$MY_BIN"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$GOPATH/bin"
export EDITOR="nvim"
unset VIMINIT

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
