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

source <(fzf --zsh)

# ----- Language / tool PATHs (keep PATH tidy) -----
export PATH="$PATH:/usr/local/lib/node_modules/.bin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$HOME/.fly/bin:$PATH"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$HOME/.config/herd-lite/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"
export JAVA_HOME=$(brew --prefix openjdk@25)
export PATH=$JAVA_HOME/bin:$PATH
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

if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

nvm use node > /dev/null 2>&1

export NATSEC_ENABLED=true
export NATSEC_PASSWORD=PASSWORD
export NATSEC_USER=TEST
export ADDRESSING_API_KEY=CsEfKfxDnR81aFV1x60MIa1vE2bVpZf01B55qAvx
export IMAGE_API_KEY=0MNBy4DwrW9802Jw288Y43RNqwElJr17akTO4DDD

natdiff() {
    if [ -z "$1" ]; then
        echo "Usage: natdiff <filename>"
        return 1
    fi
    
    diff "Natural-Libraries/DLSYST/SRC/$1" "Natural-Libraries/AWSBATCH/SRC/$1"
}

rgf () {
  if [ -z "$1" ]; then
      echo "Usage: rgf <filename>"
      return 1
  fi
  rg . -g "$1" | fzf | cut -d: -f1 | xargs nvim
}

dcat () {
  
  if [ -z "$1" ]; then
      echo "Usage: rgf <filepath>"
      return 1
  fi
  docker exec -it d90-d90-1 cat "$1"
}

dexec () {
  docker exec -it d90-d90-1 bash
}
