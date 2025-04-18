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

* [bat](https://github.com/sharkdp/bat) - pretty cat (if not used modify fzf opts in `.bashrc`)
* [delta](https://github.com/dandavison/delta) - syntax highlighting pager
* [just](https://github.com/casey/just) - command runner

### Fonts
For regular text, use Open Sans Regular. For monospace fonts, install a patched font from [Nerd Fonts](https://www.nerdfonts.com/font-downloads).

Install DejaVu Sans Mono by placing `.ttf` files in a directory like `~/.fonts` or `C:/Windows/Fonts`.

Use a relatively big font size in terminals (18 or 20).

Consider one of the following DPI:
* 96 (100%)
* 120 (125%)
* 144 (150%)

### Colorscheme

* [gruvbox dark hard](https://github.com/morhetz/gruvbox)
  * [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) - see neovim config
  * [tmux-gruvbox](https://github.com/egel/tmux-gruvbox/blob/main/tmux-gruvbox-dark.conf) - slightly modified
  * [xfce4-terminal](https://github.com/morhetz/gruvbox-contrib/blob/master/xfce4-terminal/gruvbox-dark-hard.theme)
  * [Windows Terminal](https://gist.github.com/davialexandre/1179070118b22d830739efee4721972d)

The terminal colorscheme requires additional work on top of copying dotfiles. I'm uncertain where I sourced `.dircolors` from. The author credit is in the file. See the `.bashrc` file for how it is loaded.

For `delta` theme support, download the themes file from the repo
[here](https://raw.githubusercontent.com/dandavison/delta/main/themes.gitconfig)
and put somewhere. Update the `.gitconfig` to point to it. Alternatively, use
the provided version in `.config/delta/trimmed_themes.gitconfig`.
