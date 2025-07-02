# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin:~/.local/bin

unset rc
. "$HOME/.cargo/env"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[4~"   end-of-line

if [ -f ~/Documents/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh ]; then
  setopt HIST_FIND_NO_DUPS

  # Handle $0 according to the standard:
  # https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
  0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
  0="${${(M)0:#/*}:-$PWD/$0}"

  source ~/Documents/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh

  bindkey '^[[A' history-substring-search-up # or '\eOA'
  bindkey '^[[B' history-substring-search-down # or '\eOB'
fi

if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# User configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export REACT_EXPLODED_WAR_FOLDER=/usr/local/bin/apache-tomcat/webapps/readiness/
export JCC2_EXPLODED_WAR_FOLDER=/usr/local/bin/apache-tomcat/webapps/ROOT/

alias tc.kill='sudo kill -9 $(ps aux | grep org.apache.catalina.startup.Bootstrap | grep -v grep | awk "{ print \$2}" | head -n 1)'
alias kats='sudo kill -9 $(ps aux | grep tsserver | grep -v grep | awk "{ print \$2}" | head -n 1)'
alias tc.dep='sudo rm -rf /usr/local/bin/apache-tomcat/webapps/readiness; sudo cp /home/jshaver/Documents/jcc2r/cent-web/target/*.war /usr/local/bin/apache-tomcat/webapps/readiness.war'
alias cent='cd ~jshaver/Documents/jcc2r'
alias react='cd ~jshaver/Documents/jcc2r/cent-web/src/main/webapp/js/react'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bun completions
[ -s "/home/jshaver/.bun/_bun" ] && source "/home/jshaver/.bun/_bun"

# bun
export BUN_INSTALL="/home/jshaver/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export CHROMIUM_FLAGS="$CHROMIUM_FLAGS --password-store=gnome"
export DENO_INSTALL="/home/jshaver/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

eval "$(starship init zsh)"
