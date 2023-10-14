# `.zshenv` is always loaded first and has to live at `$HOME/.zshenv`, and not in $ZDOTDIR
# So either source this file from `$HOME/.zshenv`
# Or symlink this file from your $ZDOTDIR using:
# ln -sf "<path/to/this/file>" "$HOME/.zshenv"

# Read http://mywiki.wooledge.org/BashFAQ/028 to know why we are doing this

# -------------------------------------------------------------------------------------------------------------------- #

# Set DOTFILE_DIR pointing to the location of the on-disk repository containing the dotfiles based on the OS
if grep -qEi "(Microsoft|WSL)" /proc/version &>/dev/null; then
    export DOTFILE_DIR="$(wslpath -a "$(wslvar USERPROFILE)")/Dropbox/Docs/dotfiles/.config/shell/zsh";
else
    export DOTFILE_DIR="$HOME/Dropbox/Docs/dotfiles/.config/shell/zsh";
fi

# -------------------------------------------------------------------------------------------------------------------- #

# Once we set $ZDOTDIR, ZSH will automatically source any `.zshrc` file in $ZDOTDIR
export ZDOTDIR="${DOTFILE_DIR:-${HOME}}";

# -------------------------------------------------------------------------------------------------------------------- #

# Prevent compinit initialization from creating `.zcompdump` in $ZDOTDIR from `/etc/zsh/.zshrc`
export skip_global_compinit=1;

# -------------------------------------------------------------------------------------------------------------------- #

# The global exports should be available to all programs, not just the interactive and login shells
source "$ZDOTDIR/../.exports";

# -------------------------------------------------------------------------------------------------------------------- #
