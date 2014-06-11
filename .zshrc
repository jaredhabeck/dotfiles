# set the path
path=(
  "$HOME/bin"
  /usr/local/bin
  /usr/local/sbin
  /opt/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
)

# this is, I believe, totally unnecessary.
fpath=(
  $fpath
)

source "$HOME/.jaredrc"

# linux ls color equivalent to LSCOLORS
export LS_COLORS="di=01;34:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;43:tw=0;42:ow=0;43:"
# Do we need Linux or BSD Style?
export LC_CTYPE=en_US.UTF-8
export LESS=FRX

# make with the nice completion
autoload -U compinit; compinit

# Completion for kill-like commands
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:ssh:*' tag-order hosts users
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

# make with the pretty colors
autoload colors; colors

# options
setopt appendhistory autocd extendedglob histignoredups nonomatch prompt_subst interactivecomments

# Bindings
# external editor support
autoload edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Partial word history completion
bindkey '\ep' up-line-or-search
bindkey '\en' down-line-or-search
bindkey '\ew' kill-region

# %  $
PROMPT='%{$fg_bold[green]%}%c %{$fg_bold[cyan]%}$(git_prompt_info "(%s)") $ %{$reset_color%}'

# history
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# default applications
(( ${+PAGER}   )) || export PAGER='less'
(( ${+EDITOR}  )) || export EDITOR='vim'
export PSQL_EDITOR='vim -c"set syntax=sql"'

# aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias spec='nocorrect spec'
alias rspec='nocorrect rspec'
alias ll="ls -l"
alias la="ls -a"
alias l.='ls -ld .[^.]*'
alias lsd='ls -ld *(-/DN)'
alias md='mkdir -p'
alias rd='rmdir'
alias cd..='cd ..'
alias ..='cd ..'
alias spec='spec -c'
alias heroku='nocorrect heroku'
alias cdc='cd ~/Code'
alias sync='rsync -rvu ~/Code/SD/client/dfb jared@yarbles.org:/var/www/www.yarbles.org/'

# create and enter dir
mcd() { mkdir -p "${@}" && cd "${1}"; }

# history from beginning with optional grep
h() { if [ -z "$*" ]; then history 1; else history 1 | egrep "$@"; fi; }
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
