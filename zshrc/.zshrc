# ----- Oh My Zsh -----
export ZSH="$HOME/.oh-my-zsh"

# Use Pure prompt (fast) and disable OMZ themes
ZSH_THEME=""
plugins=(git)
source "$ZSH/oh-my-zsh.sh"

fpath+=(/opt/homebrew/share/zsh/site-functions)
# Pure prompt (keep if you like Pure; otherwise remove these 2 lines and set a theme)
autoload -U promptinit; promptinit
prompt pure

# ----- Language / tool PATHs (keep PATH tidy) -----
export PATH="$PATH:/usr/local/lib/node_modules/.bin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$HOME/.fly/bin:$PATH"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$HOME/.config/herd-lite/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"
# Deduplicate PATH (zsh feature)
typeset -U path PATH

# ----- NVM: lazy-load + no heavy bash completion -----
export NVM_DIR="$HOME/.nvm"

# Lazy loader so nvm/node/npm don't load until first use
load-nvm() {
  # load nvm core only; skip bash_completion (slow)
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use
}

nvm()     { unset -f nvm;     load-nvm; nvm "$@"; }
node()    { unset -f node;    load-nvm; node "$@"; }
npm()     { unset -f npm;     load-nvm; npm "$@"; }
npx()     { unset -f npx;     load-nvm; npx "$@"; }
corepack(){ unset -f corepack; load-nvm; corepack "$@"; }

# Optional: auto-use .nvmrc on cd (quiet)
autoload -Uz add-zsh-hook
use-nvmrc() { [[ -f .nvmrc ]] && nvm use &>/dev/null || true }
add-zsh-hook chpwd use-nvmrc

# DO NOT force Homebrew’s Node ahead of nvm (remove this if present):
# export PATH="/opt/homebrew/opt/node@18/bin:$PATH"

# ----- Aliases -----
alias chrome='open -a "Google Chrome"'
alias spotify='open -a "Spotify"'
alias lock="osascript -e 'tell application \"System Events\" to keystroke \"q\" using {control down, command down}'"

BOOT_FLAG="/tmp/iterm_boot_flag"

if [ ! -f "$BOOT_FLAG" ]; then
    # Run your script
    echo "hello, Gethin 👋"

    # Create a flag so it won't run again until next reboot
    touch "$BOOT_FLAG"
fi

# Always load prompt and oh-my-zsh, even in nvim :term

# In Neovim's terminal, also source login config so fpath/Pure are available
if [[ -n $NVIM ]]; then
  [[ -r ~/.zprofile ]] && source ~/.zprofile
  export TERM=xterm-256color
fi
