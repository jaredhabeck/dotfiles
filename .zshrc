HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch notify prompt_subst
unsetopt beep
bindkey -e
zstyle :compinstall filename '/home/j/.zshrc'
autoload -Uz compinit
compinit
autoload -U colors && colors

# ctrl-arrow don't work by default on zsh, this makes it so
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

git_prompt_info () {
  local g="$(git rev-parse --git-dir 2>/dev/null)"
  if [ -n "$g" ]; then
    local r
    local b
    local d
    local s
    # Rebasing
    if [ -d "$g/rebase-apply" ] ; then
      if test -f "$g/rebase-apply/rebasing" ; then
        r="|REBASE"
      fi
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    # Interactive rebase
    elif [ -f "$g/rebase-merge/interactive" ] ; then
      r="|REBASE-i"
      b="$(cat "$g/rebase-merge/head-name")"
    # Merging
    elif [ -f "$g/MERGE_HEAD" ] ; then
      r="|MERGING"
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    else
      if [ -f "$g/BISECT_LOG" ] ; then
        r="|BISECTING"
      fi
      if ! b="$(git symbolic-ref HEAD 2>/dev/null)" ; then
        if ! b="$(git describe --exact-match HEAD 2>/dev/null)" ; then
          b="$(cut -c1-7 "$g/HEAD")..."
        fi
      fi
    fi

    # Dirty Branch
    local newfile='?? '
    if [ -n "$ZSH_VERSION" ]; then
      newfile='\?\? '
    fi
    d=''
    s=$(git status --porcelain 2> /dev/null)
    [[ $s =~ "$newfile" ]] && d+='+'
    [[ $s =~ "M " ]] && d+='*'
    [[ $s =~ "D " ]] && d+='-'

    if [ -n "${1-}" ]; then
      printf "$1" "${b##refs/heads/}$r$d"
    else
      printf "(%s) " "${b##refs/heads/}$r$d"
    fi
  fi
}


# prompt to add branch name and if changes exist
autoload -Uz add-zsh-hook vcs_info
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'
PROMPT='%~ %F{red}${vcs_info_msg_0_}%f %# '

# use non-package nvim
export PATH="$PATH:/opt/nvim-linux64/bin"

alias vim=nvim
alias cdc='cd /home/$USER/code'
alias gst='git status'
alias glod='git log --oneline'
alias gd='git diff'
alias gco='git checkout'
alias gp='git push'
alias gc='git commit'
