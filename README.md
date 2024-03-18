# dotfiles
Configuration instructions and files for setting up a Linux developer environment.

## Setup

1. Setup [fonts](#fonts)
2. Setup terminal [colorscheme](#colorscheme)
3. Copy dotfiles
4. Install [CLI utilties](#cli-utilities)

Some additional considerations:
* Possibly rename `.bashrc` to `.bashrc.$USER`
* Allow fzf install to modify `.bashrc` to source its scripts

## Details

### CLI Utilities
If the environment does not allow sudo for installing programs, consider [Linuxbrew](https://docs.brew.sh/Homebrew-on-Linux).

#### Core Utilities

* [ripgrep](https://github.com/BurntSushi/ripgrep) - faster grep with better defaults
* [fd-find](https://github.com/sharkdp/fd) - faster find with better defaults
* [fzf](https://github.com/junegunn/fzf) - fuzzy finder w/ rg and fd integration
* [neovim (>=0.9.4)](https://github.com/neovim/neovim) - vim text editor
* [tmux (>=3.2)](https://github.com/tmux/tmux/wiki) - terminal multiplexer (pre-installed version may be old)

#### Optional Utilities

* [bat](https://github.com/sharkdp/bat) - pretty cat (if not used modify fzf opts in `.bashrc`

### Fonts
Install a patched font from [Nerd Fonts](https://www.nerdfonts.com/font-downloads) like DejaVu Sans Mono. Place the extracted files in a directory like `~/.fonts`.

### Colorscheme

* [gruvbox dark hard](https://github.com/morhetz/gruvbox)
  * [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) - see neovim config
  * [xfce4-terminal](https://github.com/morhetz/gruvbox-contrib/blob/master/xfce4-terminal/gruvbox-dark-hard.theme)
  * [tmux-gruvbox](https://github.com/egel/tmux-gruvbox/blob/main/tmux-gruvbox-dark.conf) - slightly modified

The terminal colorscheme requires additional work on top of copying dotfiles. I'm uncertain where I sourced `.dircolors` from. The author credit is in the file. See the `.bashrc` file for how it is loaded.
