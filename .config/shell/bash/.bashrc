# `.bashrc` is always loaded first and has to live at `$HOME/.bashrc`
# So either source this file from `$HOME/.bashrc`
# Or symlink this file using:
# ln -sf "<path/to/this/file>" "~/.bashrc"

# Read http://mywiki.wooledge.org/BashFAQ/028 to know why we are doing this

# -------------------------------------------------------------------------------------------------------------------- #

# Set DOTFILE_DIR pointing to the location of the on-disk repository containing the dotfiles based on the OS
if grep -qEi "(Microsoft|WSL)" /proc/version &>/dev/null; then
    export DOTFILE_DIR="$(wslpath -a "$(wslvar USERPROFILE)")/Dropbox/Docs/dotfiles/.config/shell/bash";
else
    export DOTFILE_DIR="$HOME/Dropbox/Docs/dotfiles/.config/shell/bash";
fi

# -------------------------------------------------------------------------------------------------------------------- #

# The global exports should be available to all programs, not just the interactive and login shells
source "$DOTFILE_DIR/../.exports";

# -------------------------------------------------------------------------------------------------------------------- #

case $- in *i*) ;; *) return;; esac # don't do anything more if not an interactive shell

# -------------------------------------------------------------------------------------------------------------------- #

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# -------------------------------------------------------------------------------------------------------------------- #

# History

# Ignore certain commands from being stored in history
export HIST_IGNORE="ls:cd:cd -:df:ff:cls:reboot:restart:poweroff:pwd:exit:date:* --help:#*";

# Store BASH histroy at a custom location
if [ -d "$DOTFILE_DIR/../../../../Backup" ]; then HISTFILE="$DOTFILE_DIR/../../../../Backup/.bash_history"; fi

HISTSIZE=1000000000      # number of entries from the history file to be kept in memory for the current session
HISTFILESIZE=1000000000  # number of entries that are stored in the history file
HISTCONTROL=ignoreboth   # don't put duplicate lines or lines starting with space in the history

shopt -s histappend      # append to the history file, don't overwrite it

# -------------------------------------------------------------------------------------------------------------------- #

# Completion

export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME"/bash-completion/bash_completion;

# Case insensitive tab completion in Bash
# Or update ~/.inputrc to include `set completion-ignore-case on`
bind "set completion-ignore-case on"

# enable programmable completion features
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then . /usr/share/bash-completion/bash_completion;
    elif [ -f /etc/bash_completion ]; then . /etc/bash_completion
    fi
fi

# -------------------------------------------------------------------------------------------------------------------- #

# Flow Control

# https://en.wikipedia.org/wiki/Software_flow_control
# 'CTRL-S' & 'CTRL-Q' keys do flow control by default by the system, not BASH. The shell simply respects these settings.
# Turn off system level control flow with 'stty -ixon' or undefining 'stty start' or 'stty stop'.

stty stop undef       # disable CTRL-S from stopping terminal output
stty start undef      # disable Ctrl-Q from resuming terminal output

# -------------------------------------------------------------------------------------------------------------------- #

# Miscellaneous options

shopt -s autocd       # automatically do cd if the command is a path
shopt -s cdspell      # autocorrect typos in path names when using `cd`
shopt -s checkwinsize # to line wrap, check window size after each command and update the values of LINES and COLUMNS

# -------------------------------------------------------------------------------------------------------------------- #

# Keybindings

bind '"\e[A": history-search-backward' # Use up arrow to go backward in history search completion
bind '"^[[A": history-search-backward' # Use up arrow to go backward in history search completion
bind '"\e[B": history-search-forward'  # Use down arrow to go forward in history search completion
bind '"^[[B": history-search-forward'  # Use down arrow to go forward in history search completion

bind '"\eOC":forward-word'             # CTRL-RIGHT goes forward one word.
bind '"\eOD":backward-word'            # CTRL-LEFT goes backward one word.
bind -r "\C-s"                         # Disable CTRL-S from trigering forward-i-search

# -------------------------------------------------------------------------------------------------------------------- #

# Load custom prompt, aliases and functions

source "$DOTFILE_DIR/.bashprompt";
source "$DOTFILE_DIR/.bashfzf";
source "$DOTFILE_DIR/../.aliases";
source "$DOTFILE_DIR/../.functions";

# -------------------------------------------------------------------------------------------------------------------- #

# Notes

# Set/Unset bash configuration options
# Run `set -o` or shopt to  see all bash config options and their current settings
# https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# https://unix.stackexchange.com/questions/32409/set-and-shopt-why-two

# -------------------------------------------------------------------------------------------------------------------- #
