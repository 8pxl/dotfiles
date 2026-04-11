# Homebrew environment
if [ -e /opt/homebrew/bin/brew ]; then
  eval "$(${HOMEBREW_PREFIX:-/opt/homebrew}/bin/brew shellenv)"
fi

# Ensure path array is synced
path=(${(s/:/)PATH})

# Custom PATH additions
path+=(
  "$HOME/Library/Python/3.9/bin"
  "$HOME/miniconda3/condabin"
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/Library/Python/3.13/bin"
)
export PATH

# Conda initialization
# >>> conda initialize >>>
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/miniconda3/etc/profile.d/conda.sh"
  else
    export PATH="$HOME/miniconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Additional PATHs
export PATH="$PATH:$HOME/.spicetify"
export PATH="$PATH:$HOME/Luxonis/depthai/entrypoint"

# zoxide
eval "$(zoxide init zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# Editor
export EDITOR="nvim"
set -o emacs

# yazi directory picker
function y() {
  local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f "$tmp"
}

# Starship prompt
eval "$(starship init zsh)"

# gh copilot helpers

ghcs() {
  FUNCNAME="$funcstack[1]"
  TARGET="shell"
  local GH_DEBUG="$GH_DEBUG"
  local GH_HOST="$GH_HOST"

  read -r -d '' __USAGE <<-EOF
Wrapper around `gh copilot suggest` to suggest a command based on a natural language description.
Supports executing suggested commands if applicable.

USAGE
  $FUNCNAME [flags] <prompt>

FLAGS
  -d, --debug           Enable debugging
  -h, --help            Display help
      --hostname        GitHub host to use for authentication
  -t, --target target   Suggestion target: shell, gh, or git
                        default: "$TARGET"

EXAMPLES
  $ $FUNCNAME
  $ $FUNCNAME -t git "Undo the most recent local commits"
  $ $FUNCNAME -t git "Clean up local branches"
  $ $FUNCNAME -t gh "Create pull request"
EOF

  local OPT OPTARG OPTIND
  while getopts "dht:-:" OPT; do
    if [ "$OPT" = "-" ]; then
      OPT="${OPTARG%%=*}"
      OPTARG="${OPTARG#"$OPT"}"
      OPTARG="${OPTARG#=}"
    fi
    case "$OPT" in
      debug|d) GH_DEBUG=api ;;
      help|h) echo "$__USAGE"; return 0 ;;
      hostname) GH_HOST="$OPTARG" ;;
      target|t) TARGET="$OPTARG" ;;
    esac
  done

  shift "$((OPTIND-1))"

  TMPFILE="$(mktemp -t gh-copilotXXXXXX)"
  trap 'rm -f "$TMPFILE"' EXIT

  if GH_DEBUG="$GH_DEBUG" GH_HOST="$GH_HOST" gh copilot suggest -t "$TARGET" "$@" --shell-out "$TMPFILE"; then
    if [ -s "$TMPFILE" ]; then
      FIXED_CMD="$(cat "$TMPFILE")"
      print -s -- "$FIXED_CMD"
      echo
      eval -- "$FIXED_CMD"
    fi
  else
    return 1
  fi
}

chpwd() {
  lsd
  if [[ -d •venv ]]; then
    source .venv/bin/activate
  elif [[ -d venv ]]; then
    source venv/bin/activate
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    deactivate
  fi
}

ghce() {
  FUNCNAME="$funcstack[1]"
  local GH_DEBUG="$GH_DEBUG"
  local GH_HOST="$GH_HOST"

  read -r -d '' __USAGE <<-EOF
Wrapper around `gh copilot explain` to explain a given command in natural language.

USAGE
  $FUNCNAME [flags] <command>

FLAGS
  -d, --debug      Enable debugging
  -h, --help       Display help
      --hostname   GitHub host to use
EOF

  local OPT OPTARG OPTIND
  while getopts "dh-:" OPT; do
    if [ "$OPT" = "-" ]; then
      OPT="${OPTARG%%=*}"
      OPTARG="${OPTARG#"$OPT"}"
      OPTARG="${OPTARG#=}"
    fi
    case "$OPT" in
      debug|d) GH_DEBUG=api ;;
      help|h) echo "$__USAGE"; return 0 ;;
      hostname) GH_HOST="$OPTARG" ;;
    esac
  done

  shift "$((OPTIND-1))"

  GH_DEBUG="$GH_DEBUG" GH_HOST="$GH_HOST" gh copilot explain "$@"
}
export MANPATH="$HOME/.local/share/man:$MANPATH"
export OPENROUTER_API_KEY=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
export GEMINI_API_KEY=AIzaSyCoksmWvvagNn8uCgaKUdnKIcbiIZXLrog
export RIPGREP_CONFIG_PATH="/Users/keijayhuang/.config/ripgrep/ripgreprc"

alias fetch="fastfetch"
alias lg="lazygit -ucd ~/.config/lazygit"
alias nv="nvim"
alias p3="python3"
alias ls="lsd"
alias venv="source .venv/bin/activate"
alias weather="curl wttr.in"


# Added by Antigravity
export PATH="/Users/keijayhuang/.antigravity/antigravity/bin:$PATH"

# bun completions
[ -s "/Users/keijayhuang/.bun/_bun" ] && source "/Users/keijayhuang/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# sql
export PATH="/usr/local/mysql/bin:$PATH"

# uvenv() {
#     local venv_name=${1:-'.venv'}
#     venv_name=${venv_name//\//} # remove trailing slashes (Linux)
#     venv_name=${venv_name//\\/} # remove trailing slashes (Windows)
#
#     local venv_bin=
#     if [[ -d ${WINDIR} ]]; then
#         venv_bin='Scripts/activate'
#     else
#         venv_bin='bin/activate'
#     fi
#
#     local activator="${venv_name}/${venv_bin}"
#     echo "[INFO] Activate Python venv: ${venv_name} (via ${activator})"
#
#     if [[ ! -f ${activator} ]]; then
#         echo "[ERROR] Python venv not found: ${venv_name}"
#         return
#     fi
#
#     # shellcheck disable=SC1090
#     . "${activator}"
# }

fetch
export PATH="/usr/local/mysql/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
