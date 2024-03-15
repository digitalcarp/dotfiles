# dotfiles
Configuration instructions and files for setting up a Linux developer environment.

## Setup

1. Setup [fonts](#fonts)
2. Copy dotfiles
  * Possibly rename `.bashrc` to `.bashrc.$USER`
3. Install [CLI utilties](#cli-utilities)
  * Allow fzf install to modify `.bashrc` to source its scripts

## Details

### CLI Utilities
If the environment does not allow sudo for installing programs, consider [Linuxbrew](https://docs.brew.sh/Homebrew-on-Linux).

#### Core Utilities

* [ripgrep](https://github.com/BurntSushi/ripgrep) - faster grep with better defaults
* [fd-find](https://github.com/sharkdp/fd) - faster find with better defaults
* [fzf](https://github.com/junegunn/fzf) - fuzzy finder w/ rg and fd integration
* [neovim](https://github.com/neovim/neovim) - vim text editor
* [tmux (>=3.2)](https://github.com/tmux/tmux/wiki) - terminal multiplexer (pre-installed version may be old)

#### Optional Utilities

* [bat](https://github.com/sharkdp/bat) - pretty cat (if not used modify fzf opts in `.bashrc`

### Fonts
Install a patched font from [Nerd Fonts](https://www.nerdfonts.com/font-downloads) like DejaVu Sans Mono. Place the extracted files in a directory like `~/.fonts`.

### Colorscheme

* [gruvbox dark hard](https://github.com/morhetz/gruvbox)
  * [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) - see neovim config
  * [xfce4-terminal](https://github.com/morhetz/gruvbox-contrib/blob/master/xfce4-terminal/gruvbox-dark-hard.theme)

I'm uncertain where I sourced `.dircolors` from. The author credit is in the file. See the `.bashrc` file for how it is loaded.
