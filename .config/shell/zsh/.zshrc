#╔═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
#║ This file is automatically sourced by ZSH after setting $ZDOTDIR in `$HOME/.zshenv` to point to this directory      ║
#╚═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

case $- in *i*) ;; *) return;; esac # don't do anything more if not an interactive shell

#╔═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
#║ Completion                                                                                                          ║
#╚═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

autoload -Uz compinit      # load the function compinit in `$fpath' as soon as it is referenced for the first time
compinit -d "$XDG_CACHE_HOME/.zcompdump"; # compsys is now online with a custom zcompdump location

zmodload -i zsh/complist   # module that defines some widgets like menu-select

setopt auto_menu           # show completion menu on a successive tab press
setopt menu_complete       # auto select the first completion entry
setopt hash_list_all       # hash everything before completion to avoid false reports of spelling errors
setopt completealiases     # auto complete aliases
setopt always_to_end       # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word    # allow completion from within a word/phrase and is needed for the prefix completer
setopt list_ambiguous      # complete as much of a completion until it gets ambiguous
setopt auto_remove_slash   # remove slash from the end if the next typed character is a word delimiter
setopt auto_param_slash    # if completed parameter is a directory, add a trailing slash
setopt no_correct          # disable spelling correction for commands
setopt no_list_beep        # no bell on ambiguous completion

zstyle ':completion:*' verbose yes;                          # use verbose mode for completion
zstyle ':completion:*' menu select=2;                        # menu selection with 2 candidates or more
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' # case insensitive completion

#╔═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
#║ Directory                                                                                                           ║
#╚═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

setopt auto_cd             # if the command is a path, cd into it
setopt chase_links         # resolve symlinks
setopt extended_glob       # consider `#', `~' and `^' characters as part of patterns for filename generation
setopt glob_dots           # include dotfiles in globbing
setopt clobber             # must use >| to truncate existing files

#╔═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
#║ History                                                                                                             ║
#╚═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

# Store ZSH history at a custom location
if [ -d "$DOTFILE_DIR/../../../../Backup" ]; then HISTFILE="$DOTFILE_DIR/../../../../Backup/.zsh_history"; fi

# Ignore certain commands from being stored in history
HISTORY_IGNORE="(ls|cd|cd -|df|ff|cls|reboot|restart|poweroff|pwd|exit|date|* --help|#*)"

HISTSIZE=1000000000             # number of entries from the history file to be kept in memory for the current session
SAVEHIST=1000000000             # number of entries that are stored in the history file

setopt append_history           # append to history file over multiple parallel sessions in the order that they exit
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit
setopt bang_hist                # treat the '!' character specially during expansion
setopt hist_expire_dups_first   # expire a duplicate entry first when trimming history
setopt hist_find_no_dups        # do not display duplicate entries
setopt hist_ignore_dups         # do not write duplicate entries
setopt hist_ignore_all_dups     # delete the older duplicate entry and keep the newer one
setopt hist_ignore_space        # do not write entries that start with a space
setopt hist_reduce_blanks       # trim blank entries
setopt hist_save_no_dups        # do not write a duplicate entry to the history file
setopt hist_verify              # show before executing history commands
setopt share_history            # share hist between zsh sessions
setopt no_extended_history      # do not write the history file in the ':start:elapsed;command' format
setopt no_hist_beep             # disable beep in ZLE when a widget attempts to access an entry which isn’t there

# From https://gist.github.com/danydev/4ca4f5c523b19b17e9053dfa9feb246d
# Exclude failed commands from on-disk zsh history, but not from the in-memory history until the current shell exits.
# We use 3 ZSH hooks (premcmd, zshexit & zshaddhistory) to do this https://zsh.sourceforge.io/Doc/Release/Functions.html
# By modifying these 3 hooks, we tell ZSH to not write the entry to history file when zshaddhistory() is called and
# instead write it when precmd() or zshexit() is run, after checking whether the command was successful or not.

my_zshaddhistory() {

    # Remove line continuations since otherwise a "\" will eventually get written to history with no newline.
    LASTHIST=${1//\\$'\n'/}

    # Return 2 to save the history line on the internal history list, but not written to the history file
    return 2
}

save_last_command_in_history_if_successful() {

    # Write the last command if successful, using the history buffered by zshaddhistory().
    if [[ ($? == 0 || $? == 130) && -n ${LASTHIST//[[:space:]\n]/} && -n $HISTFILE ]] ; then
        print -sr -- ${=${LASTHIST%%'\n'}}
    fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd save_last_command_in_history_if_successful
add-zsh-hook zshexit save_last_command_in_history_if_successful
add-zsh-hook zshaddhistory my_zshaddhistory

#╔═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
#║ Flow Control                                                                                                        ║
#╚═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

# 'CTRL-S' & 'CTRL-Q' keys do flow control by default by the system, not ZSH. The shell simply respects these settings.
# Turn off system level control flow with 'stty -ixon' or un-defining 'stty start' or 'stty stop'.
# The option NO_FLOW_CONTROL stops ZSH from allowing flow control and hence restoring the use of the keys.

stty stop undef                 # disable CTRL-S from stopping terminal output
stty start undef                # disable Ctrl-Q from resuming terminal output
setopt noflowcontrol            # disable flow control for ZSH

#╔═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
#║ Various                                                                                                             ║
#╚═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

setopt interactivecomments      # allow comments in shell and stop interpreting them
setopt no_print_exit_value      # do not print return value if non-zero
setopt no_beep                  # no bell on error
setopt no_bg_nice               # no lower priority for background jobs
setopt no_hup                   # no hup signal at shell exit
setopt no_ignore_eof            # do not exit on end-of-file
setopt no_rm_star_silent        # ask for confirmation for `rm *' or `rm path/*'

#╔═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
#║ Keybinds                                                                                                            ║
#╚═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

# Start typing + [Up/Down] - fuzzy find history forward/backward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
    bindkey "^[[A" up-line-or-beginning-search
fi
if [[ "${terminfo[kcud1]}" != "" ]]; then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
    bindkey "^[[B" down-line-or-beginning-search
fi

# Home & End Keys
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line
bindkey '\eOH'  beginning-of-line
bindkey '\eOF'  end-of-line
bindkey '\e[H'  beginning-of-line
bindkey '\e[F'  end-of-line

bindkey '\e[1;5D' backward-word # CTRL-LEFT goes backward one word
bindkey '\e[1;5C' forward-word  # CTRL-RIGHT goes forward one word
bindkey '^H' backward-kill-word # CTRL-BACKSPACE deletes the previous word
bindkey '5~' kill-word          # CTRL-DEL deletes the next word
bindkey -r '^S'                 # Disable CTRL-S from triggering forward-i-search

#╔═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
#║ Extras                                                                                                              ║
#╚═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

# Load custom prompt, aliases, fzf key-binds, and other functions

source "$ZDOTDIR/.zshprompt";
source "$ZDOTDIR/.zshfzf";
source "$ZDOTDIR/../.functions";
source "$ZDOTDIR/../.aliases";
if [ -f "$ZDOTDIR/../../../../Backup/.extra" ]; then source "$ZDOTDIR/../../../../Backup/.extra"; fi

#╔═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
#║ Notes                                                                                                               ║
#╚═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

# Run `set -o` to  see all zsh config options and their current settings
# Run `zsh -x` to see how ZSH startup with high verbosity
# Run `print -l $fpath` to see all directories in $fpath that contains functions like the completion system (compsys)
# zcompdump - speeds up compinit by providing pre-built completions and preventing re-initialization every time
# Built-in modules are in `/usr/share/zsh/functions/Zle`
# Built-in key definitions are in `/etc/zsh/zshrc`

# Steps to set a keybinding in ZSH
# Step 1: mark the desired function for auto-loading and suppress alias expansion.
# Step 2: create a widget with the same name as the function you want to bind a key to.
# Step 3: bind a key to the widget which calls the desired function.

# ══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
