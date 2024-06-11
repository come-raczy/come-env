# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# better cat
if [[ $(uname -r) == *ubuntu* ]] ; then
    alias bat=batcat
fi
alias ll="eza --color=always --long --git --icons=always "
# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

alias cd="z"

