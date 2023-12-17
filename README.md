# Dotfiles

My dotfiles for Bash, Zsh, Git, Neovim. etc..

## 1. Shell Configuration

The dotfiles are for the BASH & ZSH shells.

### 1.1 Screenshots

TODO:

### 1.2 Usage Instructions

- Clone this repository.
- For clarity, the following instructions will assume the repo was cloned into `$HOME/repo/`
- Open `$HOME/repo/.config/shell/bash/.bashrc` or `$HOME/repo/.config/shell/zsh/.zshenv` in a text editor
- Set `$DOTFILE_DIR` to the directory which contains that `.bashrc` or `.zshenv` file.

  ```shell
  export DOTFILE_DIR="$HOME/repo/.config/shell/zsh";  # in .zshenv
  export DOTFILE_DIR="$HOME/repo/.config/shell/bash"; # in .bashrc
  ```

- Install the fonts in `$HOME/repo/.config/fonts` to display all the characters in the shell prompt properly.

  ```shell
  $ cp -av "$HOME/repo/.config/fonts/." "$HOME/.local/share/fonts/"
  ```

- Set the default font in your terminal to one of the nerd fonts installed in the previous step.

- Now, you can either:

  - Source the new config files from `$HOME/.bashrc` or `$HOME/.zshenv` by adding the following line to the default config file of your shell

    ```shell
    source "$HOME/repo/.config/shell/zsh/.zshenv"  # Add this to $HOME/.zshenv
    source "$HOME/repo/.config/shell/bash/.bashrc" # Add this to $HOME/.bashrc
    ```

  Or

  - Replace the default `$HOME/.bashrc` or `$HOME/.zshenv` with a symlink to `$DOTFILE_DIR/<your-shellrc>` using:

    ```shell
    $ ln -sf "$HOME/repo/.config/shell/zsh/.zshenv" "$HOME/.zshenv"  # For ZSH
    $ ln -sf "$HOME/repo/.config/shell/bash/.bashrc" "$HOME/.bashrc" # For BASH
    ```

- Reload your shell and everything should now be working as expected

### 1.3 Files

Settings/functions for BASH and ZSH shells.

| Filename    | Function                                          |
| ----------- | ------------------------------------------------- |
|`.aliases`   | Aliases that work across BASH & ZSH               |
|`.exports`   | Global exports, XDG specification directories etc |
|`.functions` | Shell functions that work across BASH & ZSH       |
|`.bashrc`    | BASH configuration file                           |
|`.bashprompt`| Custom BASH prompt                                |
|`.bashfzf`   | BASH keybindings with FZF dependency              |
|`.zshenv`    | Sets ZDOTDIR and other global ZSH defaults        |
|`.zshrc`     | ZSH configuration file                            |
|`.zshprompt` | Custom ZSH prompt                                 |
|`.zshfzf`    | ZSH keybindings with FZF dependency               |

### 1.4 Prompt

The custom shell prompt defined in `bashprompt` & `zshprompt` provides the shells with the following features:

| Feature                                             | ZSH | BASH |
|-----------------------------------------------------|-----|------|
| Username                                            | ✓   |  ✓   |
| Hostname                                            | ✓   |  ✓   |
| Working directory name                              | ✓   |  ✓   |
| Is working directory read-only                      | ✓   |  ✓   |
| Git branch name                                     | ✓   |  ✓   |
| Is inside a Git submodule                           | ✓   |  ✓   |
| Number of Git stashes                               | ✓   |  ✓   |
| Custom Python venv indication                       | ✓   |  ✓   |
| Green/Red prompt symbol based on previous exit code | ✓   |  ⨯   |
| Previous command duration                           | ✓   |  ⨯   |

Features can be individually turned on/off easily by commenting out a single line in the function `set_prompt()`

### 1.5 Keybindings

These are the keybindings that are currently defined across BASH and ZSH

| Keybinding | Function                                                      | Dependency   | ZSH | BASH |
|------------|---------------------------------------------------------------|--------------|-----|------|
| `Ctrl-R`   | Fuzzy search history and then paste the selected entry        | fzf          |  ✓  |  ✓   |
| `Ctrl-T`   | Fuzzy search files & directories and paste the selected entry | fzf, fd-find |  ✓  |  ✓   |
| `Up`       | Start typing + `Up` - fuzzy find history backward             |      -       |  ✓  |  ✓   |
| `Down`     | Start typing + `Down` - fuzzy find history forward            |      -       |  ✓  |  ✓   |

### 1.6 Extra

- ZSH has an additional feature where only valid commands gets stored in the history file
