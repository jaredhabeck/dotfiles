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

if uname -a | grep -q Darwin; then
  source "$HOME/.dotfiles/.osxrc"
else
  source "$HOME/.dotfiles/.linuxrc"
fi

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

# fxn to take two branches and output git pretty diff
git_pretty_cdiff() {
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative $1..$2
}
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
alias gcdiff=git_pretty_cdiff

# create and enter dir
mcd() { mkdir -p "${@}" && cd "${1}"; }

# history from beginning with optional grep
h() { if [ -z "$*" ]; then history 1; else history 1 | egrep "$@"; fi; }
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
