
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git asdf ansible kubectx kubectl nvm yarn npm colored-man-pages zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night
alias cat=bat

# ---- Eza (better ls) -----
alias ls="eza --color=always --long --git --icons=always --no-time --no-user --no-permissions"

# thefuck alias
eval $(thefuck --alias)

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

# history setup
#HISTFILE=$HOME/.zhistory
#SAVEHIST=1000
#HISTSIZE=999
#setopt share_history
#setopt hist_expire_dups_first
#setopt hist_ignore_dups
#setopt hist_verify

# completion using arrow keys (based on history)
#bindkey '^[[A' history-search-backward
#bindkey '^[[B' history-search-forward

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

# Add spicetify to the path
export PATH="$HOME/.spicetify:$PATH"

export ZKSYNC_HOME="$HOME/projects/web3/zksync-era"
export PATH=$ZKSYNC_HOME/bin:$PATH
export PATH="$HOME/.foundry/bin:$PATH"

export NNN_TMPFILE="$HOME/.config/nnn/.lastd"
export NNN_OPTS="AdHoU"
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'

export NARGO_HOME="$HOME/.nargo"
export PATH="$PATH:$NARGO_HOME/bin"

export PATH="/opt/homebrew/bin:$PATH"

#export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

eval "$(starship init zsh)"

# Starting neofetch for sass
#neofetch
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Created by `pipx` on 2025-07-26 15:47:16
export PATH="$PATH:/Users/thanhquan/.local/bin"

# Github Automation
export PATH="$HOME/projects/gh-automation:$PATH"
alias gh-promo="gh-promo.py"



# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons -a --group-directories-first --git --color=always $realpath' 
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --icons -a --group-directories-first --git --color=always $realpath'


# aliases
alias fetch="sh $HOME/.config/fetch.sh"

fetch


# bun completions
[ -s "/Users/thanhquan/.bun/_bun" ] && source "/Users/thanhquan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
