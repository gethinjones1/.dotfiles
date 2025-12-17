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
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$HOME/.fly/bin:$PATH"
export PATH="$HOME/.config/herd-lite/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"
# Deduplicate PATH (zsh feature)
typeset -U path PATH

# ----- NVM: lazy-load + no heavy bash completion -----
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

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
alias python="python3"

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
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# Added by Antigravity
export PATH="/Users/gethin/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
