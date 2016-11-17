autoload -U compinit promptinit
compinit
promptinit;
autoload -U pick-web-browser
autoload -U incremental-complete-word
zle -N incremental-complete-word
autoload -U insert-files
zle -N insert-files
autoload -U predict-on
zle -N predict-on

precmd();
{
           [[ -t 1 ]] || return
                  case $TERM in
                                 xterm*|rxvt|(dt|k|E)term*) print -Pn "\e]2;[%~] :: %l\a"
                                                ;;
                                                       esac
}
preexec() {
           [[ -t 1 ]] || return
                  case $TERM in
                                 *xterm*|rxvt|(dt|k|E)term*) print -Pn "\e]2;<$1> [%~] :: %l\a"
                                                ;;
                                                       esac
}

function rnm () {
    if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Rename file or folder. Changes in the name; spaces with '_', substrings ' - ' with '-', and delete non printable characters. Usage ${RED_FG}'rnm file'$NC or ${RED_FG}'rnm folder'$NC"
        return
    fi
    if [ ! -d "$1" ] && [ ! -f "$1" ]; then
        echo "'$1' is not a valid file or folder"
        return
    fi
    # first delete blank spaces using sed, later tr delete non printable characters
    local NEW=`echo $1 | sed s/' '/_/g | tr -cd '\11\12\40-\176'`
    # others adjust for best renaming
    NEW=`echo $NEW | sed s/'_-_'/-/g`
    mv "$1" $NEW
    echo "renamed as '$NEW'"
}


function rmtabs () {
    if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Remove the tabulators in files and replace each by 4 spaces. Usage ${RED_FG}'rmtabs file1 file2...'$NC"
        return
    fi

    for file in $*; do
        if [ -f "$file" ]; then
            sed s/'\t'/'    '/g < $file > modified
            mv modified $file
        else
            echo "'$file' is not a valid file; jumping it"
        fi
    done
}


function rmnpc () {
    if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Remove non printable characters from a files. Usage ${RED_FG}'rmnpc file1 file2...'$NC"
        return
    fi

    for file in $*; do
        if [ -f "$file" ]; then
            tr -cd '\11\12\40-\176' < $file > modified
            mv modified $file
        else
            echo "'$file' is not a valid file; jumping it"
        fi
    done
}

setopt autocd           # AutoCD
# Extended opts
setopt extendedglob
setopt extended_glob
# Expands {abc}file to afile bfile cfile, etc.
setopt brace_ccl
# Searches =name in PATH
setopt equals
# Dont require a leading dot for matching "hidden" files
setopt glob_dots
# Enable multiple redirections
setopt multios
# Report status of bg jobs immediately
setopt notify
# Report status of bg jobs if exiting
setopt check_jobs
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# this one is very nice:
# cursor up/down look for a command that started like the one starting on the command line
function history-search-end {
    integer ocursor=$CURSOR

    if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then
      # Last widget called set $hbs_pos.
      CURSOR=$hbs_pos
    else
      hbs_pos=$CURSOR
    fi

    if zle .${WIDGET%-end}; then
      # success, go to end of line
      zle .end-of-line
    else
      # failure, restore position
      CURSOR=$ocursor
      return 1
    fi
}
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# some keys
#bindkey "\e[A" history-beginning-search-backward #cursor up
#bindkey "\e[B" history-beginning-search-forward  #cursor down
bindkey "\e[A" history-beginning-search-backward-end #cursor up
bindkey "\e[B" history-beginning-search-forward-end  #cursor down

zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

zstyle ':completion::default' list-colors '${LS_COLORS}'
zstyle ':completion:*:default' list-colors 'no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;31:'
#zstyle ':completion:*' completer complete _list _oldlist _expand _ignored _match _correct _approximate _prefix
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' add-space true
zstyle ':completion:*:processes' command 'ps -xuf'
zstyle ':completion:*:processes-names' command 'ps xho command'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:functions' ignored-patterns '*'
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' old-menu false
zstyle ':completion:*' original true

. $HOME/.alias

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
CDPATH=".:~:/mnt"
EDITOR=gvim

bindkey '\e[3~' delete-char # del
bindkey ';5D' backward-word # ctrl+left
bindkey ';5C' forward-word #ctrl+right

if [[ $EUID == 0 ]]
then
PROMPT=$'%{\e[1;31m%} %{\e[1;34m%}%~ #%{\e[0m%} ' # user dir %
else
PROMPT=$'%{\e[1;32m%} %{\e[1;34m%}%~ %#%{\e[0m%} ' # root dir #
fi
RPROMPT=$'%{\e[1;34m%}%T%{\e[0m%}' # right prompt with time

#export MANOPT="-L ru"
#export HISTCONTROL=ignorespace
alias \$=''

# Распаковать архив $1
extr() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xjvf $1 ;;
    *.tar.gz) tar xzvf $1 ;;
    *.bz2) bunzip2 $1 ;;
    *.rar) rar x $1 ;;
    *.gz) gunzip $1 ;;
    *.tar) tar xvf $1 ;;
    *.tbz2) tar xjvf $1 ;;
    *.tgz) tar xzvf $1 ;;
    *.zip) unzip $1 ;;
    *.Z) uncompress $1 ;;
    *.7z) 7z x $1 ;;
    *) echo "'$1' не может быть распакован с помощь extr()" ;;
    esac
    else
        echo "'$1' не является поддерживаемым файлом"
            fi
}

 # Упаковать $1 в архив
pk() {
    if [ $1 ] ; then
        case $1 in
            tbz) tar cjvf $2.tar.bz2 $2 ;;
    tgz) tar czvf $2.tar.gz $2 ;;
    tar) tar cpvf $2.tar $2 ;;
    bz2) bzip $2 ;;
    gz) gzip -c -9 -n $2 > $2.gz ;;
    zip) zip -r $2.zip $2 ;;
    7z) 7z a $2.7z $2 ;;
    *) echo "'$1' не может быть упакован с помощью pk()" ;;
    esac
    else
        echo "'$1' не является поддерживаемым файлом"
            fi
}

# Редактирование команд в стиле vi
#set -o vi
