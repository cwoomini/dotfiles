# [[=================================]]
#           MACOS ZSH CONFIG 
#    Author: Cwoo
#    Last Updated: 2025.08.27
# [[=================================]]


# [[=================================]]
#           New Device Setup
# [[=================================]]
#   * Treats missing Homebrew as a new MacOS install.
#     (Checks if the 'brew' command exists)
if [[ "$(uname)" == "Darwin" ]] && ! command -v brew >/dev/null 2>&1; then
  defaults write -g ApplePressAndHoldEnabled 0
  defaults write -g NSWindowShouldDragOnGesture -bool true
  defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
fi


# [[=================================]]
#            Util Functions
# [[=================================]]
batch_exec() {
  local cmd="$1"
  shift
  for item in "$@"; do
    eval "$cmd \"$item\""
  done
}

parsegitbranch() {
  git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/ %F{3}(\1)%f/p'
}


# [[=================================]]
#                Alias
# [[=================================]]
alias ls='gls -a --color --group-directories-first'
alias ll='gls -al --color --group-directories-first'
alias cls=clear
alias vim=nvim
alias v=nvim


# [[=================================]]
#               API Keys
# [[=================================]]
source $HOME/.apikeys


# [[=================================]]
#               Homebrew
# [[=================================]]
if ! command -v brew >/dev/null 2>&1; then
  HOMEBREW_TAPS=("FelixKratz/formulae")
  HOMEBREW_PACKAGES="borders cmake coreutils fzf gh llvm neovim node pnpm tmux uv zoxide zsh-autosuggestions zsh-syntax-highlighting"
  HOMEBREW_CASKS="aerospace font-ibm-plex-mono font-monaspace ghostty karabiner-elements zed"

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  batch_exec "brew tap" "${HOMEBREW_TAPS[@]}"
  brew install $HOMEBREW_PACKAGES
  brew install --cask $HOMEBREW_CASKS
fi


# [[=================================]]
#                 ZSH 
# [[=================================]]
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

PROMPT="%F{6}%n%f:%F{2}%c%f$(parsegitbranch) %(!.#.$) "
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
zstyle ':completion:*' list-colors


# [[=================================]]
#                 LLVM
# [[=================================]]
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"


# [[=================================]]
#                Zoxide 
# [[=================================]]
eval "$(zoxide init zsh)"


# [[=================================]]
#                 Tmux 
# [[=================================]]
# if [ "$TMUX" = "" ]; then tmux; fi


# [[=================================]]
#                 Rust
# [[=================================]]
if ! command -v rustc >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
