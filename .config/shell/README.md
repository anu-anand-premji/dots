# Shell Dotfiles

Dotfiles for BASH & ZSH shells.
Except for the starship prompt (which is also optional), these dotfiles aim to be completely plugin free.

## 1. Screenshots

TODO:

## 2. Files & Folders

```ascii
.
├── bash ----------------------------------> Directory containing BASH settings & a custom plugin-free BASH prompt
│   ├── .bashfzf --------------------------> BASH keybindings with FZF dependency
│   ├── .bashprompt -----------------------> Custom plugin-free BASH prompt
│   └── .bashrc ---------------------------> BASH configuration file
│
├── scripts ------------------------------->
│   └── doupdate -------------------------->
│
├── starship ------------------------------> Directory containing the settings for starship prompt
│   └── agnoster_gaps.toml ----------------> Starship theme based on the original agnoster theme with gaps
│
├── zsh -----------------------------------> Directory containing ZSH settings & a custom plugin-free ZSH prompt
│   ├── .zshenv ---------------------------> Sets ZDOTDIR and other global ZSH defaults
│   ├── .zshfzf ---------------------------> ZSH keybindings with FZF dependency
│   ├── .zshprompt ------------------------> Custom plugin-free ZSH prompt
│   └── .zshrc ----------------------------> ZSH configuration file
│
├── .aliases ------------------------------> Aliases that work across BASH & ZSH
├── .exports ------------------------------> Global exports, XDG specification directories etc
├── .functions ----------------------------> Shell functions that work across BASH & ZSH
└── README.md -----------------------------> This README file
```

## 3. Using these dotfiles

### 3.1 Clone this repository to your PC

> [!NOTE]
> **For ease of explanation, the following instructions will assume that the repo was cloned into `$HOME/repo/` on your local PC.
> If you cloned the repository to another location, please change the directory path in the below instructions accordingly.**

```shell
$ git clone <URL> "$HOME/repo/"
```

### 3.2 Install the required fonts and set it as the default terminal font

To display all the extra glyphs and icons in the shell prompt properly, you need to install a some patched fonts.

- Inside the cloned repository, you can find the required fonts at `$HOME/repo/.config/fonts`.

  > [!NOTE]
  > I use the `JetbrainsMono NF` font family.
  > Alternatively, you can download and use any of the patched fonts from the [Nerd Fonts repository on GitHub.](https://github.com/ryanoasis/nerd-fonts)

- To install the fonts, run:

  ```shell
  # Copy the fonts from the repo to the fonts directory of the OS
  $ cp -av "$HOME/repo/.config/fonts/." "$HOME/.local/share/fonts/"

  # Refresh the font cache for the OS to pick up the newly copied fonts
  $ sudo fc-cache -f
  ```

- Go to the settings of your preferred terminal and set the default font to one of the fonts installed above.

### 3.3 Set `$DOTFILE_DIR`

<u>**For ZSH**</u>

  - Open `$HOME/repo/.config/shell/zsh/.zshenv` in a text editor
  - Edit `$DOTFILE_DIR` and set it to the directory of that same file.

    ```shell
    export DOTFILE_DIR="$HOME/repo/.config/shell/zsh";
    ```

<u>**For BASH**</u>

  - Open `$HOME/repo/.config/shell/bash/.bashrc` in a text editor
  - Edit `$DOTFILE_DIR` and set it to the directory of that same file.

    ```shell
    export DOTFILE_DIR="$HOME/repo/.config/shell/bash";
    ```

### 3.4 Configure your default shell to use these dotfiles

<u>**For ZSH**</u>

You have two ways to configure ZSH to use these dotfiles.
You can either:

- Source `$HOME/repo/.config/shell/zsh/.zshenv` from `$HOME/.zshenv`.
To do that, open `$HOME/.zshenv` in a text editor and add the following line to it

  ```shell
  source "$HOME/repo/.config/shell/zsh/.zshenv"
  ```

Or

- Replace the default `$HOME/.zshenv` with a symlink to `$HOME/repo/.config/shell/zsh/.zshenv` by running:

  ```shell
  $ ln -sf "$HOME/repo/.config/shell/zsh/.zshenv" "$HOME/.zshenv"
  ```

Now, reload ZSH to complete the procedure

```shell
$ exec "$(ps -p $$ -ocomm=)"
```

<u>**For BASH**</u>

You have two ways to configure BASH to use these dotfiles.
You can either:

- Source `$HOME/repo/.config/shell/bash/.bashrc` from `$HOME/.bashrc`.
To do that, open `$HOME/.bashrc` in a text editor and add the following line to it


  ```shell
  source "$HOME/repo/.config/shell/bash/.bashrc"
  ```

Or

- Replace the default `$HOME/.bashrc` with a symlink to `$HOME/repo/.config/shell/bash/.bashrc` by running:

  ```shell
  $ ln -sf "$HOME/repo/.config/shell/bash/.bashrc" "$HOME/.bashrc"
  ```

Now, reload BASH to complete the procedure

```shell
$ exec "$(ps -p $$ -ocomm=)"
```

## 4. The Prompt

The custom shell prompt defined in `./bash/.bashprompt` & `./zsh/.zshprompt` provides the following features:

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

If Starship prompt is installed, then all the supported shells will have the same prompt with all of the features enabled by Starship.

## 5. Keybindings

These are the keybindings that are currently defined across BASH and ZSH

| Keybinding | Function                                                      | Dependency      | ZSH | BASH |
|------------|---------------------------------------------------------------|-----------------|-----|------|
| `Ctrl-R`   | Fuzzy search history and then paste the selected entry        | `fzf`           |  ✓  |  ✓   |
| `Ctrl-T`   | Fuzzy search files & directories and paste the selected entry | `fzf`, `fd-find`|  ✓  |  ✓   |
| `Up`       | Start typing + `Up` - fuzzy find history backward             |      -          |  ✓  |  ✓   |
| `Down`     | Start typing + `Down` - fuzzy find history forward            |      -          |  ✓  |  ✓   |

## 6. Extra

- ZSH has an additional feature where only valid commands gets stored in the history file
